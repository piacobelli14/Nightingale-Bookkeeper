//
//  WatchManager.swift
//  NightingaleBookkeeper
//
//  Created by Peter Iacobelli on 6/6/24.
//

import SwiftUI
import SceneKit

struct WatchView: UIViewRepresentable {
    let devType: String

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        
        sceneView.scene = SCNScene(named: devType)
        sceneView.backgroundColor = UIColor.clear
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true

        let rootNode = sceneView.scene?.rootNode

        rootNode?.scale = SCNVector3(3.5, 3.5, 3.5)

        rootNode?.eulerAngles.y = 1 * .pi / 1.26
        rootNode?.eulerAngles.x = 1 * .pi / 0.5
        rootNode?.eulerAngles.z = -1 * .pi / 0.5

        rootNode?.position = SCNVector3(-2.8, 0, 0)

        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.light?.castsShadow = true
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        rootNode?.addChildNode(lightNode)

        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) { }
}
