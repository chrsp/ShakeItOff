//
//  MotionLoadingController.swift
//  ShakeItOff
//
//  Created by Charles Prado on 11/01/2023.
//

import Foundation
import CoreMotion

protocol MotionLoadingDelegate: AnyObject {
    func didIncrementProgress(in progressIncrement: Int)
}

class MotionLoadingController {
    
    weak var delegate: MotionLoadingDelegate?
    
    private let manager: CMMotionManager = .init()
    private var lastComputedData: CMAccelerometerData? = nil
    
    func start() {
        manager.accelerometerUpdateInterval = 0.1
        
        manager.startAccelerometerUpdates(to: .main) { data, error in
            guard let data = data else { return }
            
            let current3dPoint = Point3D(
                x: data.acceleration.x,
                y: data.acceleration.y,
                z: data.acceleration.z
            )
            
            var delta: CGFloat = 0.0
            
            if let lastComputedData = self.lastComputedData {
                let last3dPoint = Point3D(
                    x: lastComputedData.acceleration.x,
                    y: lastComputedData.acceleration.y,
                    z: lastComputedData.acceleration.z
                )
                
                delta = current3dPoint.distance(from: last3dPoint)
            }
            
            self.lastComputedData = data
            
            guard delta > 2 else {
                return
            }
            
            self.delegate?.didIncrementProgress(in: Int(delta))
        }
    }

}
