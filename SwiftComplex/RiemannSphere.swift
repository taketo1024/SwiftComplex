//
//  RiemannSphere.swift
//  SwiftComplex
//
//  Created by Taketo Sano on 2015/03/06.
//  Copyright (c) 2015年 yahoo japan. All rights reserved.
//

import UIKit
import SceneKit

class RiemannSphere: SCNView {
    var points: [String: Complex] = [:]
    var colors: [String: UIColor] = [:]
    
    private var sphere: SCNSphere!
    private var sphereNode: SCNNode!
    
    subscript(name: String) -> Complex? {
        get {
            return points[name]
        }
        set(value) {
            points[name] = value
        }
    }
    
    override func awakeFromNib() {
        self.scene = SCNScene()
        self.autoenablesDefaultLighting = true
        self.backgroundColor = UIColor.blackColor()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 4)
        scene?.rootNode.addChildNode(cameraNode)
        
        sphere = SCNSphere(radius: 1)
        sphere.segmentCount = 48;
        
//        sphere.firstMaterial?.diffuse.contents = UIColor.whiteColor()
//        sphere.firstMaterial?.diffuse.contents = plane.layer
        sphere.firstMaterial?.diffuse.contents = UIImage(named: "test")
        
        func load(name: String) -> String {
            let url = NSBundle.mainBundle().URLForResource(name, withExtension: nil)
            let src = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: nil)
            return src!
        }
        
        sphere.firstMaterial?.shaderModifiers = [
            SCNShaderModifierEntryPointGeometry: load("RiemannSphere.vert"),
            SCNShaderModifierEntryPointFragment: load("RiemannSphere.frag")
        ]
        
        sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x: 0, y: 0, z: 0)
        scene?.rootNode.addChildNode(sphereNode)
    }
    
    func update() {
        let names = points.keys
        for name in names {
            if sphereNode.childNodeWithName(name, recursively: false) == nil {
                self.addPointNode(name)
            }
            
            let n = sphereNode.childNodeWithName(name, recursively: false)
            n?.position = positionForPoint(points[name]!)
        }
        
        // TODO remove deleted points
    }
    
    private func addPointNode(name: String) {
        let s = SCNSphere(radius: sphere.radius / 20)
        s.firstMaterial?.diffuse.contents = colors[name] ?? UIColor.darkGrayColor()
        
        let n = SCNNode(geometry: s)
        n.name = name
        n.position = SCNVector3(x: 0, y: 0, z: 1)
        sphereNode.addChildNode(n)
    }
    
    private func positionForPoint(z: Complex) -> SCNVector3 {
        if(z == 0) {
            return SCNVector3(x: 0, y: -1, z: 0)
        } else {
            let azi = -arg(z)
            let pol = 2 * atan(1 / abs(z))
            let R = Double(sphere.radius)
            return SCNVector3(x: Float(R * sin(pol) * cos(azi)),
                y: Float(R * cos(pol)),
                z: Float(R * sin(pol) * sin(azi)))
        }
    }
}
