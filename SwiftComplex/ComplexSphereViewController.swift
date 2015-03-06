//
//  ComplexSphereViewController.swift
//  SwiftComplex
//
//  Created by Taketo Sano on 2015/03/06.
//  Copyright (c) 2015年 yahoo japan. All rights reserved.
//

import UIKit
import SceneKit

let pi = Float(M_PI)

class ComplexSphereViewController: UIViewController {
    @IBOutlet var sphere: RiemannSphere!
    
    var map: ((Complex) -> Complex)?
    
    private var z: Complex = Complex(r: 1, θ: 0)
    private var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sphere.playing = true
        sphere.allowsCameraControl = true
        sphere.colors["z"] = UIColor.redColor()
        sphere.colors["w"] = UIColor.blueColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.autoButtonTapped()
    }
    
    func update() {
        sphere["z"] = z
        sphere["w"] = map?(z)
        sphere.plane.setNeedsDisplay()
    }
    
    @IBAction func autoButtonTapped() {
        if(timer == nil) {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector:"timerFired", userInfo: nil, repeats: true)
            timer?.fire()
        } else {
            timer?.invalidate()
        }
    }
    
    func timerFired() {
        z = Complex(r: abs(z), θ: arg(z) + M_PI / 60)
        self.update()
    }
}

