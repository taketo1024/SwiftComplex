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
    var plane: ComplexPlane!
    
    var points: [String: Complex] {
        get {
            return plane.points
        } set(value) {
            plane.points = value
        }
    }
    
    var colors: [String: UIColor] {
        get {
            return plane.colors
        } set(value) {
            plane.colors = value
        }
    }
    
    subscript(name: String) -> Complex? {
        get {
            return plane[name]
        }
        set(value) {
            plane[name] = value
        }
    }
    
    override func awakeFromNib() {
        plane = ComplexPlane(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        plane.backgroundColor = UIColor.whiteColor()
        
        self.scene = SCNScene()
        self.autoenablesDefaultLighting = true
        self.backgroundColor = UIColor.blackColor()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 4)
        scene?.rootNode.addChildNode(cameraNode)
        
        let sphere = SCNSphere(radius: 1)
        sphere.firstMaterial?.diffuse.contents = UIColor.whiteColor()
        sphere.firstMaterial?.diffuse.contents = plane.layer
        
        func load(name: String) -> String {
            let url = NSBundle.mainBundle().URLForResource(name, withExtension: nil)
            let src = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: nil)
            return src!
        }
        
        sphere.firstMaterial?.shaderModifiers = [
            SCNShaderModifierEntryPointGeometry: load("RiemannSphere.vert"),
            SCNShaderModifierEntryPointFragment: load("RiemannSphere.frag")
        ]
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x: 0, y: 0, z: 0)
        sphereNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: pi/2)
        scene?.rootNode.addChildNode(sphereNode)
    }
}
