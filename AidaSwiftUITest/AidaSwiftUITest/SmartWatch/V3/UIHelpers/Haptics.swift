//
//  Haptics.swift
//  Arc
//
//  Created by Kuldeep Tyagi on 13/09/23.
//

import UIKit

//Generate Haptics
func generateHaptics() {
    let impactMed = UIImpactFeedbackGenerator(style: .rigid)
    impactMed.impactOccurred()
}
