import SwiftUI

public struct AnimationObserverModifier<Value: VectorArithmetic>: AnimatableModifier {
  private let observedValue: Value
  private let onChange: ((Value) -> Void)?
  private let onComplete: (() -> Void)?
  
  public var animatableData: Value {
    didSet {
      notifyProgress()
    }
  }

  public init(for observedValue: Value,
              onChange: ((Value) -> Void)?,
              onComplete: (() -> Void)?) {
    self.observedValue = observedValue
    self.onChange = onChange
    self.onComplete = onComplete
    animatableData = observedValue
  }
  
  public func body(content: Content) -> some View {
    content
  }
  
  private func notifyProgress() {
    DispatchQueue.main.async {
      onChange?(animatableData)
      if animatableData == observedValue {
        onComplete?()
      }
    }
  }
}

public extension View {
    func animationObserver<Value: VectorArithmetic>(for value: Value,
                                                    onChange: ((Value) -> Void)? = nil,
                                                    onComplete: (() -> Void)? = nil) -> some View {
      self.modifier(AnimationObserverModifier(for: value,
                                                 onChange: onChange,
                                                 onComplete: onComplete))
    }
}

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
           .animationObserver(for: offset) { progress in
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

struct AnimationProgressTest_Previews: PreviewProvider {
    static var previews: some View {
        AnimationObserverTest()
    }
}


