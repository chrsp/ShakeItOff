//
//  UIDevice+Extension.swift
//  ShakeItOff
//
//  Created by Charles Prado on 12/01/2023.
//

import UIKit
import AudioToolbox

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
