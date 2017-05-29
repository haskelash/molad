//
//  ClockTextMethods.swift
//  Molad
//
//  Created by Haskel Ash on 5/29/17.
//  Copyright © 2017 HaskelAsh. All rights reserved.
//

import UIKit

extension ClockView {
    internal func drawChalakim(rect: CGRect, ctx: CGContext, radius: CGFloat) {
        //flip context for text
        ctx.translateBy(x: 0, y: rect.height)
        ctx.scaleBy(x: 1.0, y: -1.0)

        //chalakim text
        let chalakimPoints = pointsAroundCircle(rect: rect,
                                                radius: radius*0.82,
                                                ticks: 24,
                                                adjustment: .pi/2)
        let chalakimFont = UIFont(name: "Helvetica Light", size: 8)
        let chalakimAttrs = [NSFontAttributeName: chalakimFont,
                             NSForegroundColorAttributeName: UIColor.black] as CFDictionary

        for (i, point) in chalakimPoints.enumerated() {
            let chalakimStr = "\(i == 0 ? 1080 : i*45)" as CFString
            let text = CFAttributedStringCreate(nil, chalakimStr, chalakimAttrs)!
            let line = CTLineCreateWithAttributedString(text)
            let lineBounds = CTLineGetBoundsWithOptions(line, .useOpticalBounds)

            ctx.setLineWidth(0.5)
            ctx.setTextDrawingMode(.stroke)
            let textX = (point.x - lineBounds.midX)
            let textY = (point.y - lineBounds.midY)
            ctx.textPosition = CGPoint(x: textX, y: textY)

            CTLineDraw(line, ctx)
        }

        //done with text, flip context back
        ctx.translateBy(x: 0, y: rect.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
    }

    internal func drawHours(rect: CGRect, ctx: CGContext, radius: CGFloat) {
        //flip context for text
        ctx.translateBy(x: 0, y: rect.height)
        ctx.scaleBy(x: 1.0, y: -1.0)

        //hours text
        let hourPoints = pointsAroundCircle(rect: rect,
                                            radius: radius*0.68,
                                            ticks: 24,
                                            adjustment: .pi/2)
        let hoursFont = UIFont(name: "Helvetica Light", size: 8)
        let hoursAttrs = [NSFontAttributeName: hoursFont,
                          NSForegroundColorAttributeName: UIColor.black] as CFDictionary

        for (i, point) in hourPoints.enumerated() {
            let hoursStr = "\(i == 0 ? 24 : i)" as CFString
            let text = CFAttributedStringCreate(nil, hoursStr, hoursAttrs)!
            let line = CTLineCreateWithAttributedString(text)
            let lineBounds = CTLineGetBoundsWithOptions(line, .useOpticalBounds)

            ctx.setLineWidth(1)
            ctx.setTextDrawingMode(.stroke)
            let textX = (point.x - lineBounds.midX)
            let textY = (point.y - lineBounds.midY)
            ctx.textPosition = CGPoint(x: textX, y: textY)

            CTLineDraw(line, ctx)
        }

        //done with text, flip context back
        ctx.translateBy(x: 0, y: rect.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
    }
}
