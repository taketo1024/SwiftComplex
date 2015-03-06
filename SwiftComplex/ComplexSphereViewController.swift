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
    @IBOutlet var sceneView: SCNView!
    
    var map: ((Complex) -> Complex)?
    
    private var plane = ComplexPlane(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
    private var z: Complex = Complex(r: 1, θ: 0)
    private var timer: NSTimer?
    
    override func viewDidLoad() {
        plane.backgroundColor = UIColor.whiteColor()

        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.blackColor()
        sceneView.playing = true
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 4)
        scene.rootNode.addChildNode(cameraNode)
        
        let sphere = SCNSphere(radius: 1)
        sphere.firstMaterial?.diffuse.contents = UIColor.whiteColor()
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x: 0, y: 0, z: 0)
        sphereNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: pi/2)
        scene.rootNode.addChildNode(sphereNode)
        
        self.view.addSubview(plane)
        
        sphere.firstMaterial?.diffuse.contents = plane.layer
        // UIImage(named: "earth_diffuse_4k")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.autoButtonTapped()
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
    
    func update() {
        plane["z"] = z
        plane.colors["z"] = UIColor.redColor()
        
        let w = map?(z)
        plane["w"] = w
        plane.colors["w"] = UIColor.blueColor()
        plane.setNeedsDisplay()
        
        println("w: \(w)")
    }
}

