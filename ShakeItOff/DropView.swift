//
//  DropView.swift
//  ShakeItOff
//
//  Created by Charles Prado on 13/01/2023.
//

import UIKit

class DropView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: .zero)
        
        path.lineWidth = 4.0
        UIColor.blue.setStroke()
        path.addLine(to: .init(x: 0, y: 80))
        
        path.addArc(
            withCenter: .init(x: 120, y: 120),
            radius: 120,
            startAngle: .pi,
            endAngle: .pi * 2,
            clockwise: false
        )
        
        path.addLine(to: .init(x: 80, y: 0))
        
        path.stroke()
    }
    
    private func drawShape() {
        
    }
}

import SwiftUI

struct DropViewPreviews_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            // Return whatever controller you want to preview
            let vc = DropView()
            return vc
        }
    }
}
