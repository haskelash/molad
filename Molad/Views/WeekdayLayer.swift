//
//  WeekdayLayer.swift
//  Molad
//
//  Created by Haskel Ash on 5/29/17.
//  Copyright © 2017 HaskelAsh. All rights reserved.
//

import UIKit

class WeekdayLayer: CALayer {
    private var current = 0
    private let textWheel = TextWheel()
    private let outlineLayer = CAShapeLayer()

    func draw() {
        textWheel.frame = bounds
        addSublayer(textWheel)
        textWheel.setNeedsDisplay()

        func wedgePath(startRatio: CGFloat = 0.3,
                       endRatio: CGFloat = 0.6,
                       wedgeAngle: CGFloat = -.pi/6) -> CGPath {
            let path = CGMutablePath()
            let wedgeStart: CGFloat = startRatio * bounds.width/2
            let wedgeEnd: CGFloat = endRatio * bounds.width/2

            //start at r = wedgeStart, ø = wedgeAngle
            path.move(to: CGPoint(x: bounds.midX + wedgeStart*cos(wedgeAngle),
                                  y: bounds.midY + wedgeStart*sin(wedgeAngle)))

            //add line to r = wedgeEnd, ø = wedgeAngle
            path.addLine(to: CGPoint(x: bounds.midX + wedgeEnd*cos(wedgeAngle),
                                     y: bounds.midY + wedgeEnd*sin(wedgeAngle)))

            //add arc to r = wedgeEnd, ø = -wedgeAngle
            path.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: wedgeEnd,
                        startAngle: wedgeAngle, endAngle: -wedgeAngle, clockwise: false)

            //add line to r = wedgeStart, ø = -wedgeAngle
            path.addLine(to: CGPoint(x: bounds.midX + wedgeStart*cos(-wedgeAngle),
                                     y: bounds.midY + wedgeStart*sin(-wedgeAngle)))

            //add arc to r = wedgeStart, ø = wedgeAngle
            path.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: wedgeStart,
                        startAngle: -wedgeAngle, endAngle: wedgeAngle, clockwise: true)

            return path
        }

        //draw mask wedge
        let maskLayer = CAShapeLayer()
        maskLayer.path = wedgePath()
        maskLayer.fillColor = UIColor.black.cgColor
        mask = maskLayer

        //draw black outline around mask
        outlineLayer.path = wedgePath()
        outlineLayer.lineWidth = 4
        outlineLayer.fillColor = UIColor.clear.cgColor
        outlineLayer.strokeColor = UIColor.black.cgColor
        addSublayer(outlineLayer)
    }

    func rotate() {
        let desired = (self.current + 1) % 7
        UIView.animate(withDuration: 1.5) {
            self.textWheel.transform = CATransform3DMakeRotation(
                CGFloat.pi*2.0*CGFloat(desired)/7, 0, 0, -1)
        }
        self.current = (self.current + 1) % 7
    }

    private class TextWheel: CALayer {
        override func draw(in ctx: CGContext) {
            //flip context for text
            ctx.translateBy(x: 0, y: bounds.height)
            ctx.scaleBy(x: 1.0, y: -1.0)

            let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            let dayFont = UIFont(name: "Helvetica Light", size: 12)
            let dayAttrs = [NSFontAttributeName: dayFont,
                            NSForegroundColorAttributeName: UIColor.black] as CFDictionary

            //draw weekday text rotated at 1/7 of a cirlce intervals
            for day in days {
                let dayStr = day as CFString
                let text = CFAttributedStringCreate(nil, dayStr, dayAttrs)!
                let line = CTLineCreateWithAttributedString(text)
                let lineBounds = CTLineGetBoundsWithOptions(line, .useOpticalBounds)

                ctx.setTextDrawingMode(.stroke)
                let textX = (bounds.maxX - 150 - lineBounds.midX)
                let textY = (bounds.midY - lineBounds.midY)
                ctx.textPosition = CGPoint(x: textX, y: textY)
                CTLineDraw(line, ctx)

                ctx.translateBy(x: bounds.midX, y: bounds.midY)
                ctx.rotate(by: -.pi*2/7)
                ctx.translateBy(x: -bounds.midX, y: -bounds.midY)
            }

            //done with text, flip context back
            ctx.translateBy(x: 0, y: bounds.height)
            ctx.scaleBy(x: 1.0, y: -1.0)
        }
    }
}
