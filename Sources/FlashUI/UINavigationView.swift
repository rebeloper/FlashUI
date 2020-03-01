//
//  File.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI
import UIKit

public struct UINavigationView: UIViewControllerRepresentable {
    
    public var root: UIViewController
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<UINavigationView>) -> UINavigationController {
        return UINavigationController(rootViewController: root)
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: UIViewControllerRepresentableContext<UINavigationView>) {
    }
}
