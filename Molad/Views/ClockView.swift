//
//  ClockView.swift
//  Molad
//
//  Created by Haskel Ash on 4/2/17.
//  Copyright © 2017 HaskelAsh. All rights reserved.
//

import UIKit

@IBDesignable class ClockView: UIView {
    private func drawClock(rect: CGRect, ctx: CGContext,
                   radius: CGFloat, border: CGFloat) {

        let center = CGPoint(x: rect.midX, y: rect.midY)

        //clock circle
        ctx.addArc(center: center, radius: radius,
                   startAngle: 0, endAngle: .pi*2, clockwise: true)

        ctx.setFillColor(UIColor.white.cgColor)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.setLineWidth(border)
        ctx.drawPath(using: .fillStroke)

        //center circle
        ctx.addArc(center: center, radius: 5,
                   startAngle: 0, endAngle: .pi*2, clockwise: true)
        ctx.setFillColor(UIColor.black.cgColor)
        ctx.drawPath(using: .fill)
    }

    private func drawTicks(rect: CGRect, ctx: CGContext,
                   radius: CGFloat, border: CGFloat) {
        let tickStartPoints = pointsAroundCircle(rect: rect,
                                                 radius: radius,
                                                 ticks: 48)
        let path = CGMutablePath()
        for (i, point) in tickStartPoints.enumerated() {
            let fraction: CGFloat = i % 2 == 0 ? 0.08 : 0.05
            let tickEndX = point.x + fraction*(rect.midX - point.x)
            let tickEndY = point.y + fraction*(rect.midY - point.y)
            path.move(to: point)
            path.addLine(to: CGPoint(x: tickEndX, y: tickEndY))
            ctx.addPath(path)
        }
        ctx.setLineWidth(border/2)
        ctx.strokePath()
    }
}
