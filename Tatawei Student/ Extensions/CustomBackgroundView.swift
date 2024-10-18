//
//  CustomBackgroundView.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 08/10/2024.
//

import UIKit

class CustomBackgroundView: UIView {
    var fillColor: UIColor!
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let width = rect.size.width
        let height = rect.size.height
        
        
        //Draw the middle part of the shape.
        let rect = CGRect(x: 0.02247*width, y: 0.22407*height, width: 0.97526*width, height: 0.7070*height)
        let rectanglePath = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 15, height: 15))
        path.append(rectanglePath)
        
        // Draw the bottom of the shape.
        path.move(to: CGPoint(x: 0.82169*width, y: 0.89645*height + 5))
        path.addCurve(to: CGPoint(x: 0.8427*width, y: 0.89645*height + 5), controlPoint1: CGPoint(x: 0.82929*width, y: 0.89619*height + 5), controlPoint2: CGPoint(x: 0.83639*width, y: 0.89622*height + 5))
        path.addLine(to: CGPoint(x: 0.82169*width, y: 0.89645*height + 5))
        path.addCurve(to: CGPoint(x: 0.71107*width, y: 0.9284*height + 5), controlPoint1: CGPoint(x: 0.78501*width, y: 0.89771*height + 5), controlPoint2: CGPoint(x: 0.7368*width, y: 0.90563*height + 5))
        path.addLine(to: CGPoint(x: 0.71064*width, y: 0.92879*height + 5))
        path.addCurve(to: CGPoint(x: 0.63689*width, y: 0.9668*height + 5), controlPoint1: CGPoint(x: 0.69086*width, y: 0.9463*height + 5), controlPoint2: CGPoint(x: 0.66769*width, y: 0.9668*height + 5))
        path.addLine(to: CGPoint(x: 0.34816*width, y: 0.9668*height + 5))
        path.addCurve(to: CGPoint(x: 0.26328*width, y: 0.92237*height + 5), controlPoint1: CGPoint(x: 0.31377*width, y: 0.9668*height + 5), controlPoint2: CGPoint(x: 0.28664*width, y: 0.94101*height + 5))
        path.addCurve(to: CGPoint(x: 0.1573*width, y: 0.89645*height + 5), controlPoint1: CGPoint(x: 0.24518*width, y: 0.90793*height + 5), controlPoint2: CGPoint(x: 0.2127*width, y: 0.89645*height + 5))
        path.addLine(to: CGPoint(x: 0.82169*width, y: 0.89645*height + 5))
        path.close()
        
        //Draw the top of the shape.
        path.move(to: CGPoint(x: 0.97753*width + 3.5, y: 0.0415*height))
        path.addLine(to: CGPoint(x: 0.97753*width + 3.5, y: 0.29202*height))
        path.addCurve(to: CGPoint(x: 0.95196*width + 3.5, y: 0.31114*height), controlPoint1: CGPoint(x: 0.97753*width + 3.5, y: 0.30249*height), controlPoint2: CGPoint(x: 0.96613*width + 3.5, y: 0.31102*height))
        path.addLine(to: CGPoint(x: 0.07378*width + 3.5, y: 0.31904*height))
        path.addCurve(to: CGPoint(x: 0.02247*width + 3.5, y: 0.2816*height), controlPoint1: CGPoint(x: 0.04554*width + 3.5, y: 0.31929*height), controlPoint2: CGPoint(x: 0.02247*width + 3.5, y: 0.30246*height))
        path.addCurve(to: CGPoint(x: 0.02699*width, y: 0.26845*height), controlPoint1: CGPoint(x: 0.02247*width + 3.5, y: 0.27713*height), controlPoint2: CGPoint(x: 0.02358*width + 3.5, y: 0.27262*height))
        path.addCurve(to: CGPoint(x: 0.44468*width + 3.5, y: 0), controlPoint1: CGPoint(x: 0.13847*width + 3.5, y: 0.05255*height), controlPoint2: CGPoint(x: 0.35144*width + 3.5, y: -0.00056*height))
        path.addLine(to: CGPoint(x: 0.92135*width + 3.5, y: 0))
        path.addCurve(to: CGPoint(x: 0.97753*width + 3.5, y: 0.0415*height), controlPoint1: CGPoint(x: 0.95238*width + 3.5, y: 0), controlPoint2: CGPoint(x: 0.97753*width + 3.5, y: 0.01858*height))
        path.close()

        // Set the fill color
        fillColor.setFill()
        // Fill the path
        path.fill()
        let layer = self.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 0, height: 5)

        




        
    }
}
