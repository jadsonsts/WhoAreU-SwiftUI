//
//  SubmitBtn.swift
//  WhoAreU
//
//  Created by Jadson on 27/12/22.
//

import SwiftUI

struct SubmitBtn: View {
    
    let animationDuration: TimeInterval = 0.45
    let trackerRotation: Double = 2.585
    
    @State var isAnimating: Bool = false
    @State var taskDone: Bool = false
    
    @State var submitScale: CGFloat = 1
    
    var body: some View {
        ZStack {
            Color(.clear)
                .ignoresSafeArea()
            ZStack {
                RoundedRectangle(cornerRadius: self.isAnimating ? 46 : 20, style: .circular)
                    .fill(Color.white)
                    .frame(width: self.isAnimating ? 46 : 150, height: 46)
                    .scaleEffect(submitScale, anchor: .center)
                    .onTapGesture() {
                        if (!self.isAnimating) {
                            HapticManager().makeSelectionFeedback()
                            toggleIsAnimating()
                            animateButton()
                            resetSubmit()
                            Timer.scheduledTimer(withTimeInterval:  trackerRotation * 0.95, repeats: false) { _ in
                                self.taskDone.toggle()
                            }
                        }
                    }
                if (self.isAnimating) {
                    RotatingCircle(trackerRotation: trackerRotation, timerInterval:  trackerRotation * 0.91) //speed
                }
                Tick(scaleFactor: 0.3)
                    .trim(from: 0, to: self.taskDone ? 1 : 0)
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .foregroundColor(Color.black)
                    .frame(width: 4)
                    .offset(x: -4, y: 4)
                    .animation(.easeOut(duration: 0.35))
                Text("Submit")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundColor(Color.black)
                    .opacity(self.isAnimating ? 0 : 1)
                    .animation(.easeOut(duration: animationDuration), value: 0)
                    .scaleEffect(self.isAnimating ? 0.7 : 1)
                    .animation(.easeOut(duration: animationDuration), value: 0)
            }
        }
    }
    
    // MARK:- functions
    func animateButton() {
        expandButton()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            expandButton()
        }
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            expandButton()
        }    }
    
    func expandButton() {
        withAnimation(Animation.linear(duration: 0.5)) {
            self.submitScale = 1.35
        }
        withAnimation(Animation.linear(duration: 0.5).delay(0.5)) {
            self.submitScale = 1
        }
    }
    
    func resetSubmit() {
        Timer.scheduledTimer(withTimeInterval: trackerRotation * 0.95 + animationDuration * 3.5, repeats: false) { _ in
            toggleIsAnimating()
            self.taskDone.toggle()
        }
    }
    
    func toggleIsAnimating() {
        withAnimation(Animation.spring(response: animationDuration * 1.25, dampingFraction: 0.9, blendDuration: 1)){
            self.isAnimating.toggle()
        }
    }
}

struct SubmitBtn_Previews: PreviewProvider {
    static var previews: some View {
        SubmitBtn()
    }
}
