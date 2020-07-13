//
//  Gestures.swift
//  Pandora
//
//  Created by Cyril Garcia on 7/9/20.
//  Copyright © 2020 Pandora Media Inc. All rights reserved.
//

import UIKit
import Vision

enum GestureType: String {
    case trigger
}

protocol Gesture: AnyObject {
    var confidenceLevel: VNConfidence { get set }
    func process(with observation: VNRecognizedPointsObservation) -> GestureType?
}
