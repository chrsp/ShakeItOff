//
//  ViewController.swift
//  ShakeItOff
//
//  Created by Charles Prado on 11/01/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var percentageLabel: UILabel!
    let motionLoadingController: MotionLoadingController = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionLoadingController.delegate = self
        motionLoadingController.start()
    }
    
    @IBAction func didPressReset(_ sender: Any) {
        self.percentageLabel.text = "0%"
    }
}

extension ViewController: MotionLoadingDelegate {
    func didIncrementProgress(in progressIncrement: Int) {
        if let text = self.percentageLabel.text,
           let percentage = Int(text.replacingOccurrences(of: "%", with: "")),
           percentage < 100 {
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            var newValue = percentage + progressIncrement
            newValue = newValue > 100 ? 100 : newValue
            
            if newValue == 100 {
                UIDevice.vibrate()
            }
            
            self.percentageLabel.text = "\(newValue)%"
        }
    }
}
