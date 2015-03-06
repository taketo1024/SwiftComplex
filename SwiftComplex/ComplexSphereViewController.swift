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
    
    override func viewDidLoad() {
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.blackColor()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 4)
        scene.rootNode.addChildNode(cameraNode)
        
        /*
        let floor = SCNFloor()
        floor.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.5)
        floor.firstMaterial?.lightingModelName = SCNLightingModelConstant
        floor.reflectivity = 0.15
        floor.reflectionFalloffEnd = 15
        
        let floorNode = SCNNode(geometry: floor)
        scene.rootNode.addChildNode(floorNode)
        */
        
        let sphere = SCNSphere(radius: 1)
        sphere.firstMaterial?.diffuse.contents = UIColor.whiteColor()
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x: 0, y: 0, z: 0)
        scene.rootNode.addChildNode(sphereNode)
    }
}
