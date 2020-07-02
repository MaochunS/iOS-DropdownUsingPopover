//
//  TriangleView.swift
//  DropdownUsingPopover
//
//  Created by Maochun Sun on 2020/7/2.
//  Copyright © 2020 Maochun. All rights reserved.
//

import UIKit

class TriangleView : UIView {
    
    var triangleColor = UIColor.blue

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = .white
       
    }
    

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.maxY))
        context.closePath()

        //context.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.60)
        context.setFillColor(triangleColor.cgColor)
        context.fillPath()
    }
}
