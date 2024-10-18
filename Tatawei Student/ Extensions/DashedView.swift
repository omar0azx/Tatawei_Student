//
//  DashedView.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 08/10/2024.
//

import UIKit

class DashedView: UIView {

    @IBInspectable var perDashLength: CGFloat = 2
        @IBInspectable var spaceBetweenDash: CGFloat = 2
        @IBInspectable var dashColor: UIColor = UIColor.lightGray


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath()
        
        let p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
        path.move(to: p0)
        
        let p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
        path.addLine(to: p1)
        
        path.lineWidth = 2 
        
        let dashes: [CGFloat] = [perDashLength, spaceBetweenDash]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        
        path.lineCapStyle = .butt
        dashColor.set()
        path.stroke()
    }

        private var width : CGFloat {
            return self.bounds.width
        }

        private var height : CGFloat {
            return self.bounds.height
        }
    }
