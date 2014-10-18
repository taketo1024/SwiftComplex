//
//  DetailViewController.swift
//  SwiftComplex
//
//  Created by Taketo Sano on 2014/10/18.
//  
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var plane: ComplexPlane!
    
    var map: ((Complex) -> Complex)?
    
    private var z: Complex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        plane.scale = 2.0
        plane["1"] = (Complex(1), nil)
        plane["i"] = (i, nil)
        
        z = Complex(r: 2, θ: M_PI / 3)
        self.update()
    }
    
    func update() {
        plane["z"] = (z, UIColor.redColor())
        plane["w"] = (map?(z), UIColor.blueColor())
        plane.setNeedsDisplay()
    }
}

