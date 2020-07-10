//
//  PMCameraView.swift
//  Pandora
//
//  Created by Cyril Garcia on 7/9/20.
//  Copyright © 2020 Pandora Media Inc. All rights reserved.
//

import AVKit
import UIKit

protocol CameraViewDelegate: AnyObject {
    func captureOutput(_ pixelBuffer: CMSampleBuffer)
}

final class CameraView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var captureSession = AVCaptureSession()
    
    weak var delegate: CameraViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setupCaptureSession()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCaptureSession() {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            
            let output = AVCaptureVideoDataOutput()
            output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "video"))
            captureSession.addOutput(output)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        delegate?.captureOutput(sampleBuffer)
    }
}
