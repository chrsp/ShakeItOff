//
//  ViewController.swift
//  ShakeItOff
//
//  Created by Charles Prado on 11/01/2023.
//

import UIKit
import CoreMotion

struct ThreeDPoint {
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
}

class ViewController: UIViewController {
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    private let manager: CMMotionManager = .init()
    private var lastComputedData: CMAccelerometerData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.accelerometerUpdateInterval = 0.1
        
        manager.startAccelerometerUpdates(to: .main) { data, error in
            guard let data = data else { return }
            
            let current3dPoint = ThreeDPoint(
                x: data.acceleration.x,
                y: data.acceleration.y,
                z: data.acceleration.z
            )
            
            var delta: CGFloat = 0.0
            
            if let lastComputedData = self.lastComputedData {
                let last3dPoint = ThreeDPoint(
                    x: lastComputedData.acceleration.x,
                    y: lastComputedData.acceleration.y,
                    z: lastComputedData.acceleration.z
                )
                
                delta = self.getThreeDPointDistance(from: current3dPoint, to: last3dPoint)
            }
            
            // accepts only positive values
            delta = delta
            
            self.lastComputedData = data
            
            guard delta > 2 else {
                return
            }
            
            if let text = self.percentageLabel.text,
               let percentage = Int(text.replacingOccurrences(of: "%", with: "")),
               percentage < 100 {
                let newValue = percentage + Int(delta)
                self.percentageLabel.text = "\(newValue < 100 ? newValue : 100)%"
            }
            print(delta)
        }
    }
    
    private func getThreeDPointDistanceSquared(from: ThreeDPoint, to: ThreeDPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y) + (from.z - to.z) * (from.z - to.z)
    }
    
    private func getThreeDPointDistance(from: ThreeDPoint, to: ThreeDPoint) -> CGFloat {
        return sqrt(getThreeDPointDistanceSquared(from: from, to: to))
    }
}

