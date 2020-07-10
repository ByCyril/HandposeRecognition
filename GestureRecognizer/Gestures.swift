//
//  Gestures.swift
//  Pandora
//
//  Created by Cyril Garcia on 7/9/20.
//  Copyright © 2020 Pandora Media Inc. All rights reserved.
//

import UIKit
import Vision

struct ObservedGesture {
    var confidenceLevel: Float
    var gestureType: GestureType
}

enum GestureType: String {
    case play
    case pause
    case none
}

protocol Gesture: AnyObject {
    var confidenceLevel: VNConfidence { get set }
    func process(with observation: VNRecognizedPointsObservation) -> GestureType?
}

protocol GestureDelegate: AnyObject {
    func gestureDidFinish(classification: GestureType)
}
