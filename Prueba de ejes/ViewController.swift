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
        nodo.geometry?.firstMaterial?.diffuse.contents = UIColor .blue
        
        let x = arc4random()  % 3
        let y = arc4random()  % 4
        let z = arc4random()  % 5
        
        nodo.position = SCNVector3Make (Float(x), Float(y), Float(z))
        self.arkitView.scene.rootNode.addChildNode(nodo)
    }
}
