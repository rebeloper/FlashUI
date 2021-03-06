//
//  UINavigationView.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI
import UIKit

public struct UINavigationView: UIViewControllerRepresentable {
    
    public init(root: UIViewController) {
        self.rootViewController = root
    }
    
    private var rootViewController: UIViewController
    
    public typealias Context = UIViewControllerRepresentableContext<UINavigationView>
    
    public func makeUIViewController(context: Context) -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController)
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
