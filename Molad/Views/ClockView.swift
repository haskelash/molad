//
//  ClockView.swift
//  Molad
//
//  Created by Haskel Ash on 4/2/17.
//  Copyright © 2017 HaskelAsh. All rights reserved.
//

import UIKit

@IBDesignable class ClockView: UIControl {

    internal var chalakim: Int {
        var chalakimAngleAdusted = chalakimAngle + (.pi/2)
        chalakimAngleAdusted.formTruncatingRemainder(dividingBy: .pi*2)
        if chalakimAngleAdusted == 0 { return 0 }

        //adusted angle is > 0 and < 360
        var testAngle: CGFloat = 0
        var counter = -1
        while testAngle < chalakimAngleAdusted {
            testAngle += .pi*2/1080
            counter += 1
        }
        return counter % 1080
    }

    internal var hours: Int {
        var hoursAngleAdusted = hoursAngle + (.pi/2)
        hoursAngleAdusted.formTruncatingRemainder(dividingBy: .pi*2)
        if hoursAngleAdusted == 0 { return 0 }

        //adusted angle is > 0 and < 360
        var testAngle: CGFloat = 0
        var counter = -1
        while testAngle < hoursAngleAdusted {
            testAngle += .pi*2/24
            counter += 1
        }
        return counter % 24
    }

    private var chalakimAngle: CGFloat = -.pi/2 {
        didSet {
            while chalakimAngle < 0 {
                chalakimAngle += .pi*2
            }
            while chalakimAngle > .pi*2 {
                chalakimAngle -= .pi*2
            }
            setNeedsDisplay()
        }
    }

    private var hoursAngle: CGFloat = 0 {
        didSet {
            while hoursAngle < 0 {
                hoursAngle += .pi*2
            }
            while hoursAngle > .pi*2 {
                hoursAngle -= .pi*2
            }
        }
    }

    private var prevDragAngle: CGFloat = 0
    private var prevDragPoint = CGPoint(x: 0, y: 0)
    private var chalakimHand = CAShapeLayer()
    private var hourHand = CAShapeLayer()

    @IBAction func drag(gr: UIPanGestureRecognizer) {
        let point = gr.location(in: self)
        let diffFromCenter = CGPoint(x: point.x-bounds.midX, y: point.y-bounds.midY)

        //skip if right on center
        guard diffFromCenter != .zero else { return }

        //get angle of drag point
        var newAngle = atan(diffFromCenter.y/diffFromCenter.x)
        if diffFromCenter.x < 0 {
            //arcTan onlty returns -90 to 90, so need to adjust for 90 to 270
            newAngle += .pi
        }

        if gr.state == .changed {
            //get angle of rotation from last drag point
            let angleDiff = prevDragAngle - newAngle

            //decrement chalakim by angle of rotation
            chalakimAngle -= angleDiff

            //adjust angle of rotation for hours hand if it crossed the threshold
            var newAngleAdusted = newAngle
            if prevDragPoint.x < bounds.midX && prevDragAngle > 0 && newAngle < 0 {
                //crossing from 270 to -90
                while newAngleAdusted < prevDragAngle {
                    newAngleAdusted += (.pi*2)
                }
            } else if point.x < bounds.midX && prevDragAngle < 0 && newAngle > 0 {
                //crossing from -90 to 270
                while newAngleAdusted > prevDragAngle {
                    newAngleAdusted -= (.pi*2)
                }
            }

            //decrement hours by 1/24 of angle of rotation
            let hoursDiff = (prevDragAngle - newAngleAdusted)/24
            let oldHoursAngle = hoursAngle
            hoursAngle -= hoursDiff

            //if hours hand crossed over 0 in either direction, send a special action
            if oldHoursAngle > 265*(.pi)/180 && oldHoursAngle <= 270*(.pi)/180
                && hoursAngle >= 270*(.pi)/180 && hoursAngle < 275*(.pi)/180 {
                sendActions(for: .crossLeftToRight)
            } else if oldHoursAngle >= 270*(.pi)/180 && oldHoursAngle < 275*(.pi)/180
                && hoursAngle > 265*(.pi)/180 && hoursAngle <= 270*(.pi)/180 {
                sendActions(for: .crossRightToLeft)
            } else {
                //send regular target action
                sendActions(for: .valueChanged)
            }
        }

        prevDragAngle = newAngle
        prevDragPoint = point
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayers()
    }

    private func setUpLayers() {
        hourHand.strokeColor = UIColor.black.cgColor
        hourHand.lineWidth = 4
        layer.addSublayer(hourHand)

        chalakimHand.strokeColor = UIColor.red.cgColor
        chalakimHand.lineWidth = 2
        layer.addSublayer(chalakimHand)
    }

    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        let border: CGFloat = 5
        let diameter = min(rect.size.width, rect.size.height) - border
        let radius = diameter / 2

        drawClock(rect: rect, ctx: ctx, radius: radius, border: border)
        drawTicks(rect: rect, ctx: ctx, radius: radius, border: border)
        drawChalakim(rect: rect, ctx: ctx, radius: radius)
        drawHours(rect: rect, ctx: ctx, radius: radius)
        drawHands(rect: rect, ctx: ctx, radius: radius)
    }

    internal func pointsAroundCircle(rect: CGRect,
                            radius: CGFloat,
                            ticks: Int,
                            adjustment: CGFloat = 0) -> [CGPoint] {
        let anglePerTick = .pi*2/CGFloat(ticks)
        var points = [CGPoint]()
        for i in stride(from: ticks, to: 0, by: -1) {
            let x = rect.midX + radius*cos(anglePerTick*CGFloat(i) + adjustment)
            let y = rect.midY + radius*sin(anglePerTick*CGFloat(i) + adjustment)
            points.append(CGPoint(x: x, y: y))
        }
        return points
    }


    private func drawHands(rect: CGRect, ctx: CGContext, radius: CGFloat) {
        //chalakim hand
        let handPath = CGMutablePath()
        handPath.move(to: CGPoint(x: rect.midX + -0.1*radius*cos(chalakimAngle),
                                  y: rect.midY + -0.1*radius*sin(chalakimAngle)))
        handPath.addLine(to: CGPoint(x: rect.midX + 0.76*radius*cos(chalakimAngle),
                                     y: rect.midY + 0.76*radius*sin(chalakimAngle)))
        chalakimHand.path = handPath

        //hour hand
        let hourHandPath = CGMutablePath()
        hourHandPath.move(to: CGPoint(x: rect.midX, y: rect.midY))
        hourHandPath.addLine(to: CGPoint(x: rect.midX + 0.6*radius*cos(hoursAngle),
                                         y: rect.midY + 0.6*radius*sin(hoursAngle)))
        hourHand.path = hourHandPath
    }
}
