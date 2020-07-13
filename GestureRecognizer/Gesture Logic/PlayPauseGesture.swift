//
//  ThumbsUpGesture.swift
//  GestureRecognizer
//
//  Created by Cyril Garcia on 7/9/20.
//

import UIKit
import Vision

extension Float {
    func between(_ a: Float,_ b: Float) -> Bool {
        return self >= a && self <= b
    }
}

final class PlayPauseGesture: Gesture {
    
    internal var confidenceLevel: VNConfidence = 0.7
    let lsm = LeastSquareMethod()
    
    func process(with observation: VNRecognizedPointsObservation) -> GestureType? {
        
        do {
            let first = try observation.recognizedPoints(forGroupKey: .handLandmarkRegionKeyIndexFinger)
            let second = try observation.recognizedPoints(forGroupKey: .handLandmarkRegionKeyMiddleFinger)
            let third = try observation.recognizedPoints(forGroupKey: .handLandmarkRegionKeyRingFinger)
            let fourth = try observation.recognizedPoints(forGroupKey: .handLandmarkRegionKeyLittleFinger)
            
            let firstLineSlope = slope(first[.handLandmarkKeyIndexTIP], first[.handLandmarkKeyIndexMCP])
            let secondLineSlope = slope(second[.handLandmarkKeyMiddleTIP], second[.handLandmarkKeyMiddleMCP])
            let thirdLineSlope = slope(third[.handLandmarkKeyRingTIP], third[.handLandmarkKeyRingMCP])
            let fourthLineSlope = slope(fourth[.handLandmarkKeyLittleTIP], fourth[.handLandmarkKeyLittleMCP])
            
            let slopes = [firstLineSlope, secondLineSlope, thirdLineSlope, fourthLineSlope]
            
            var results = [Bool]()
            
            for case let slope? in slopes {
                results.append(slope.between(-1.5, 1.5))
            }
            
            if results.filter({ $0 == true }).count >= 2 {
                return .trigger
            }
            
            return nil
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func slope(_ pointA: VNRecognizedPoint?,_ pointB: VNRecognizedPoint?) -> Float? {
        if let pointA = pointA, let pointB = pointB {
            if pointA.confidence >= confidenceLevel && pointB.confidence >= confidenceLevel {
                return lsm.slope([pointA.location, pointB.location])
            }
        }
        return nil
    }
    
}
