//
//  RotatingCircle.swift
//  WhoAreU
//
//  Created by Jadson on 27/12/22.
//

import SwiftUI

struct RotatingCircle: View {
    
    // MARK:- variables
    @State var isAnimating: Bool = false
    @State var rotationAngle: Angle = .degrees(0)
    @State var circleScale: CGFloat = 0.5
    @State var xOffset: CGFloat = 30
    @State var yOffSet: CGFloat = 0
    @State var opacity: Double = 1
    
    let trackerRotation: Double
    let timerInterval: TimeInterval
    
    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 20)
            .offset(x: xOffset, y: yOffSet)
            .rotationEffect(rotationAngle)
            .scaleEffect(circleScale)
            .opacity(opacity)
            .onAppear() {
                withAnimation(Animation.easeOut(duration: 0.2)) {
                    self.circleScale = 1
                    self.xOffset = 45
                }
                withAnimation(Animation.linear(duration: timerInterval)) {
                    self.rotationAngle = getRotationAngle()
                }
                Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: false) { _ in
                    withAnimation(Animation.easeOut(duration: 0.2)) {
                        self.circleScale = 0.25
                        self.xOffset = 60
                        self.yOffSet = -40
                    }
                }
                Timer.scheduledTimer(withTimeInterval: timerInterval + 0.05, repeats: false) { _ in
                    withAnimation(Animation.default) {
                        self.opacity = 0
                    }
                }
            }
    }
    
    // MARK:- functions
    func getRotationAngle() -> Angle {
        return .degrees(360 * self.trackerRotation)
    }
}


struct RotatingCircle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            RotatingCircle(trackerRotation: 2.4, timerInterval:  2.4 * 0.91)
        }
    }
}



struct Tick: Shape {
    let scaleFactor: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let cX = rect.midX + 4
        let cY = rect.midY - 3
        
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.move(to: CGPoint(x: cX - (42 * scaleFactor), y: cY - (4 * scaleFactor)))
        path.addLine(to: CGPoint(x: cX - (scaleFactor * 18), y: cY + (scaleFactor * 28)))
        path.addLine(to: CGPoint(x: cX + (scaleFactor * 40), y: cY - (scaleFactor * 36)))
        return path
    }
}

struct Tick_Previews: PreviewProvider {
    static var previews: some View {
        Tick(scaleFactor: 1)
    }
}

struct HapticManager {
    
    enum NotificationFeedbackType {
        case success, info, failure
    }
    
    enum ImpactFeedbackType {
        case light, medium, heavy
    }
    
    // MARK:- functions
    func makeNotifiationFeedback(mode: NotificationFeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        
        if (mode == .success) {
            generator.notificationOccurred(.success)
        } else if (mode == .failure) {
            generator.notificationOccurred(.error)
        } else {
            generator.notificationOccurred(.warning)
        }
    }
    
    func makeSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    func makeImpactFeedback(mode: ImpactFeedbackType) {
        var generator: UIImpactFeedbackGenerator
        if (mode == .light) {
            generator = UIImpactFeedbackGenerator(style: .light)
        } else if (mode == .medium) {
            generator = UIImpactFeedbackGenerator(style: .medium)
        } else {
            generator = UIImpactFeedbackGenerator(style: .heavy)
        }
        generator.prepare()
        generator.impactOccurred()
    }
}


