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

    var tuplaRandom: (Float, Float, Float) {
        let indice = Int(arc4random() % 2)
        return (
            Float(arc4random() % 3) * Float(signoMultiplicador[indice]),
            Float(arc4random() % 4) * Float(signoMultiplicador[indice]),
            Float(arc4random() % 5) * Float(signoMultiplicador[indice])
        )
    }

    var signoMultiplicador = [-1, 1]

    var grupoDeElementos: [SCNNode] = []

    @IBOutlet weak var arkitView: ARSCNView!
    
    let configuracion = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arkitView.debugOptions = []
        self.arkitView.session.run(configuracion)
    }

    @IBAction func agregarCaja(_ sender: Any) {
        let nodo = SCNNode()
        nodo.geometry = SCNBox(width: 0.6, height: 0.6, length: 0.5, chamferRadius: 0.03)
        nodo.geometry?.firstMaterial?.diffuse.contents = randomColor
        nodo.position = SCNVector3Make(tuplaRandom.0, tuplaRandom.1, tuplaRandom.2)
        self.arkitView.scene.rootNode.addChildNode(nodo)
        grupoDeElementos.append(nodo)
    }

    @IBAction func agregarCirculo(_ sender: Any) {
        let nodo = SCNNode()
        nodo.geometry = SCNSphere(radius: 0.25)
        nodo.geometry?.firstMaterial?.diffuse.contents = randomColor
        nodo.position = SCNVector3Make(tuplaRandom.0, tuplaRandom.1, tuplaRandom.2)
        self.arkitView.scene.rootNode.addChildNode(nodo)
        grupoDeElementos.append(nodo)
    }

    @IBAction func agregarCono(_ sender: Any) {
        let nodo = SCNNode()
        nodo.geometry = SCNCone(topRadius: 0.2, bottomRadius: 0.1, height: 0.5)
        nodo.geometry?.firstMaterial?.diffuse.contents = randomColor
        nodo.position = SCNVector3Make(tuplaRandom.0, tuplaRandom.1, tuplaRandom.2)
        self.arkitView.scene.rootNode.addChildNode(nodo)
        grupoDeElementos.append(nodo)
    }
    
    @IBAction func borrarTodo(_ sender: Any) {
        for elemento in grupoDeElementos {
            elemento.removeFromParentNode()
        }
    }

    @IBAction func agregarPlano(_ sender: Any) {
        // create a new scene
        // let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene(named: "art.scnassets/te5.scn")!

        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)

        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)

        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)

        // retrieve the ship node
        let ship = scene.rootNode.childNode(withName: "Plane", recursively: false)!

        // animate the 3d object
        ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))

        self.arkitView.scene = scene

        // allows the user to manipulate the camera
        self.arkitView.allowsCameraControl = true

        // show statistics such as fps and timing information
        self.arkitView.showsStatistics = true
    }

}
