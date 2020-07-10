//
//  LeastSquareMethod.swift
//  GestureRecognizer
//
//  Created by Cyril Garcia on 7/10/20.
//

import UIKit

final class LeastSquareMethod {
    func slope(_ X: [Float],_ Y: [Float]) -> Float {
        let meanX = X.reduce(0, +) / Float(X.count)
        let meanY = Y.reduce(0, +) / Float(Y.count)
        
        var sumTop: Float = 0
        var sumBottom: Float = 0
        
        for i in 0..<X.count {
            let x = X[i]
            let y = Y[i]
            
            sumTop += (x - meanX) * (y - meanY)
        }
        
        for x in X {
            sumBottom += pow(x - meanX, 2)
        }
        
        return sumTop / sumBottom
    }
    
    func slope(_ points: [CGPoint]) -> Float {
        var X = [Float]()
        var Y = [Float]()
        
        for point in points {
            X.append(Float(point.x))
            Y.append(Float(point.y))
        }
        
        return slope(X, Y)
    }
}
