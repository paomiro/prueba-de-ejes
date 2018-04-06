//
//  ViewController.swift
//  Prueba de ejes
//
//  Created by Paola Miranda on 03/12/17.
//  Copyright © 2017 Paola Miranda. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    let colores = [UIColor.black, UIColor.blue, UIColor.red, UIColor.green, UIColor.brown, UIColor.cyan, UIColor.gray, UIColor.purple, UIColor.darkGray, UIColor.lightGray, UIColor.magenta, UIColor.orange, UIColor.white, UIColor.yellow, UIColor.clear]

    var randomColor: UIColor {
        let numeroDeColores = UInt32(colores.count)
        let indice = Int(arc4random() % numeroDeColores)
        return colores[indice]
    }

    @IBOutlet weak var arkitView: ARSCNView!
    
    let configuracion = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arkitView.debugOptions = []
        self.arkitView.session.run(configuracion)
    }

    @IBAction func agregarCaja(_ sender: Any) {
        let nodo = SCNNode()
        nodo.geometry = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0.03)
        nodo.geometry?.firstMaterial?.diffuse.contents = randomColor

        let x = arc4random() % 3
        let y = arc4random() % 4
        let z = arc4random() % 5
        
        nodo.position = SCNVector3Make (Float(x), Float(y), Float(z))
        self.arkitView.scene.rootNode.addChildNode(nodo)
    }
}
