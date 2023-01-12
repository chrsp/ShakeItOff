//
//  Point3D.swift
//  ShakeItOff
//
//  Created by Charles Prado on 11/01/2023.
//
import Foundation

struct Point3D {
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    
    func distance(from: Point3D) -> CGFloat {
        return sqrt(
            (self.x - from.x) * (self.x - from.x) +
            (self.y - from.y) * (self.y - from.y) +
            (self.z - from.z) * (self.z - from.z)
        )
    }
}
