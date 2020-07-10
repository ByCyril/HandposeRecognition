//
//  GestureViewController.swift
//  Pandora
//
//  Created by Cyril Garcia on 7/9/20.
//  Copyright © 2020 Pandora Media Inc. All rights reserved.
//

import AVKit
import UIKit

final class GestureViewController: UIViewController, CameraViewDelegate, GestureRecognizerDelegate {
  
    var gestureRecognizer: GestureRecognizer?
    var cameraView: CameraView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView = CameraView()
        gestureRecognizer = GestureRecognizer(PlayPauseGesture())
        gestureRecognizer?.delegate = self
        
        cameraView?.delegate = self
        cameraView?.captureSession.startRunning()
        print("Ready")
    }
    
    @objc
    func startObservingGestures() {
        cameraView?.captureSession.startRunning()
    }
    
    func captureOutput(_ pixelBuffer: CMSampleBuffer) {
        gestureRecognizer?.classify(sampleBuffer: pixelBuffer)
    }
    
    func recognizedGesture(_ gestureType: GestureType) {
        print("Recognized Gesture",gestureType.rawValue)
    }
    
}
