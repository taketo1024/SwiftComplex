//
//  Complex.swift
//  SwiftComplex
//
//  Created by Taketo Sano on 2014/10/18.
//  
//

import Foundation

struct Complex: Equatable, IntegerLiteralConvertible, FloatLiteralConvertible, Printable {
    let x: Double
    let y: Double
    
    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
    
    init(_ x: Double) {
        self.x = x
        self.y = 0
    }
    
    init(integerLiteral x: IntegerLiteralType) {
        self.x = Double(x)
        self.y = 0
    }
    
    init(floatLiteral x: FloatLiteralType) {
        self.x = x
        self.y = 0
    }
    
    init(r: Double, θ: Double) {
        self.x = r * cos(θ)
        self.y = r * sin(θ)
    }
    
    var description: String {
        var output = "\(round(x * 100) / 10) "
        output += (y >= 0 ? "+" : "-")
        output += " \(round(abs(y) * 100) / 100)i"
        return output
    }
}

func == (z: Complex, w: Complex) -> Bool {
    return z.x == w.x && z.y == w.y
}

func Re(a: Complex) -> Double {
    return a.x
}

func Im(a: Complex) -> Double {
    return a.y
}

prefix func ~(a: Complex) -> Complex {
    return Complex(a.x, -a.y);
}

func + (z: Complex, w: Complex) -> Complex {
    return Complex(z.x + w.x, z.y + w.y)
}

func - (z: Complex, w: Complex) -> Complex {
    return Complex(z.x - w.x, z.y - w.y)
}

prefix func -(z: Complex) -> Complex {
    return Complex(-z.x, -z.y);
}

func * (a: Double, z: Complex) -> Complex {
    return Complex(a * z.x, a * z.y)
}

func * (z: Complex, w: Complex) -> Complex {
    return Complex(z.x * w.x - z.y * w.y, z.x * w.y + z.y * w.x)
}

func / (z: Complex, w: Complex) -> Complex {
    let w_inv = (1 / (w.x * w.x + w.y * w.y) ) * Complex(w.x, -w.y)
    return z * w_inv
}

func abs(z: Complex) -> Double {
    return sqrt(z.x * z.x + z.y * z.y)
}

func arg(z: Complex) -> Double {
    let r = abs(z)
    if(r == 0) {
        return 0
    }
    
    let t = acos(z.x / r)
    return (z.y >= 0) ? t : 2 * M_PI - t
}

func exp(z: Complex) -> Complex {
    return Complex(exp(z.x) * cos(z.y), exp(z.x) * sin(z.y))
}

let i = Complex(0, 1)
