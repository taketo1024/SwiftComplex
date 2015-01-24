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
    @IBOutlet weak var autoButton: UIButton!
    
    var map: ((Complex) -> Complex)?
    
    private var z: Complex = 0
    private var timer: NSTimer?
    private var touched = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        plane.scale = 1.0
        plane.pointSize = 10
        plane["1"] = 1
        plane["i"] = i
        
        z = Complex(r: 2, θ: M_PI / 3)
        self.update()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func update() {
        plane["z"] = z
        plane.colors["z"] = UIColor.redColor()
        plane["w"] = map?(z)
        plane.colors["w"] = UIColor.blueColor()
        plane.setNeedsDisplay()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = (touches.anyObject() as UITouch?)!
        let point = touch.locationInView(plane)
        
        if (plane.pointInside(point, withEvent: nil)) {
            z = plane.complexAtPoint(point)
            self.update()
        }
        
        touched = true
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = (touches.anyObject() as UITouch?)!
        let point = touch.locationInView(plane)
        
        if (plane.pointInside(point, withEvent: nil)) {
            z = plane.complexAtPoint(point)
            self.update()
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        touched = false
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        touched = false
    }
    
    @IBAction func autoButtonTapped() {
        autoButton.selected = !autoButton.selected;
        if(autoButton.selected) {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector:"timerFired", userInfo: nil, repeats: true)
            timer?.fire()
        } else {
            timer?.invalidate()
        }
    }
    
    func timerFired() {
        if(!touched) {
            z = Complex(r: abs(z), θ: arg(z) + M_PI / 60)
            self.update()
        }
    }
}

