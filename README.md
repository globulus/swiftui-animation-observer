# SwiftUI Animation Observer

Track SwiftUI animation progress and completion via callbacks! For an animated value (offset, opacity, etc.), get its current value as the animation progresses and then get notified when the animation is completed.

![Preview](https://github.com/globulus/swiftui-animation-observer/blob/main/Images/preview.gif?raw=true)

## Installation

This component is distributed as a **Swift package**. Just add this repo's URL to XCode:

```text
https://github.com/globulus/swiftui-animation-observer
```

## How to use

Add the `animationObserver` modifier to your view. Pass the **property whose value is changed by the animation** and two optional callbacks:
1. `onProgress` is called on each animation frame and reports the current value of the animated property.
1. `onComplete` is called when the animation is completed.

```swift
struct AnimationObserverTest: View {
  @State private var offset = 0.0
  @State private var offsetSpan: ClosedRange<Double> = 0...1
  @State private var progressPercentage = 0.0
  @State private var isDone = false

   var body: some View {
     GeometryReader { geo in
       VStack {
         Text("Loading: \(progressPercentage)%")
         Rectangle()
           .foregroundColor(.blue)
           .frame(height: 50)
           .offset(x: offset)
           .animationObserver(for: offset) { progress in // HERE
             progressPercentage = 100 * abs(progress - offsetSpan.lowerBound) / (offsetSpan.upperBound - offsetSpan.lowerBound)
           } onComplete: {
             isDone = true
           }

         if isDone {
           Text("Done!")
         } else if progressPercentage >= 50 {
           Text("Woooooah, we're half way there...")
         }
         
         Button("Reload") {
           isDone = false
           offset = -geo.size.width
           offsetSpan = offset...0
           withAnimation(.easeIn(duration: 5)) {
             offset = 0
           }
         }
       }
     }
   }
}
```

## Recipe

Check out [this recipe](https://swiftuirecipes.com/blog/swiftui-animation-observer) for in-depth description of the component and its code. Check out [SwiftUIRecipes.com](https://swiftuirecipes.com) for more **SwiftUI recipes**!

## Changelog

* 1.0.0 - Initial release.

