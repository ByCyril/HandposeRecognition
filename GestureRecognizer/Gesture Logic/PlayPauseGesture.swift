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
    
    internal var confidenceLevel: VNConfidence = 0.3
    let lsm = LeastSquareMethod()
    
    func process(with observation: VNRecognizedPointsObservation) -> GestureType? {
        
        do {
            let indexFinger = try observation.recognizedPoints(forGroupKey: .handLandmarkRegionKeyIndexFinger)
            let middleFinger = try observation.recognizedPoints(forGroupKey: .handLandmarkRegionKeyMiddleFinger)
            
            let indexFingerRecognizedPoints = [indexFinger[.handLandmarkKeyIndexTIP],
                                               indexFinger[.handLandmarkKeyIndexDIP],
                                               indexFinger[.handLandmarkKeyIndexPIP],
                                               indexFinger[.handLandmarkKeyIndexMCP]]
            
            let middleFingerRecognizedPoints = [middleFinger[.handLandmarkKeyMiddleTIP],
                                                middleFinger[.handLandmarkKeyMiddleDIP],
                                                middleFinger[.handLandmarkKeyMiddlePIP],
                                                middleFinger[.handLandmarkKeyMiddleMCP]]
            
            return handlePoints(indexFingerRecognizedPoints, middleFingerRecognizedPoints)
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    private func handlePoints(_ indexFingerRecognizedPoints: [VNRecognizedPoint?],_ middleFingerRecognizedPoints: [VNRecognizedPoint?]) -> GestureType {
        var indexFingerPoints = indexFingerRecognizedPoints.compactMap({ $0 })
        var middleFingerPoints = middleFingerRecognizedPoints.compactMap({ $0 })
        
        indexFingerPoints = indexFingerPoints.filter({ $0.confidence > confidenceLevel })
        middleFingerPoints = middleFingerPoints.filter({ $0.confidence > confidenceLevel })
        
//        let thumbPointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: thumbPoint)
        let indexFingerCGPoints = indexFingerPoints.map({ CGPoint(x: $0.location.x, y: 1 - $0.location.y )})
        let middleFingerCGPoints = middleFingerPoints.map({ CGPoint(x: $0.location.x, y: 1 - $0.location.y )})
        
        let slopeOfIndexFingerPoints = lsm.slope(indexFingerCGPoints)
        let slopeOfMiddleFingerPoints = lsm.slope(middleFingerCGPoints)
        
        print(slopeOfIndexFingerPoints, slopeOfMiddleFingerPoints)
        if slopeOfIndexFingerPoints.between(-0.5, 0.5) && slopeOfMiddleFingerPoints.between(-0.5, 0.5) {
            return .play
        }
        return .pause
    }
    
}
