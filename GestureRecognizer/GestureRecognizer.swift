//
//  GestureRecognizer.swift
//  Pandora
//
//  Created by Cyril Garcia on 7/9/20.
//  Copyright © 2020 Pandora Media Inc. All rights reserved.
//

import UIKit
import Vision

protocol GestureRecognizerDelegate: AnyObject {
    func recognizedGesture(_ gestureType: GestureType)
}

final class GestureRecognizer: NSObject {
    
    weak var delegate: GestureRecognizerDelegate?
    
    private var handPoseRequest = VNDetectHumanHandPoseRequest()
    private var gesturesToRecognize: [GestureType]?
    
    init(gesturesToRecognize: [GestureType]) {
        super.init()
        self.gesturesToRecognize = gesturesToRecognize
        handPoseRequest.maximumHandCount = 1
    }
    
    func classify(sampleBuffer: CMSampleBuffer) {
        let handler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up, options: [:])
        
        do {
            try handler.perform([handPoseRequest])
            
            guard let observation = handPoseRequest.results?.first as? VNRecognizedPointsObservation else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.handlePose(observation)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handlePose(_ observation: VNRecognizedPointsObservation) {
        if let gesture = PlayPauseGesture().process(with: observation) {
            delegate?.recognizedGesture(gesture)
        } else {
            delegate?.recognizedGesture(.none)
        }
        
    }
    
    
}
