//
//  File.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI
import UIKit

public struct UINavigationView: UIViewControllerRepresentable {
    
    private var rootViewController: UIViewController
    
    init(root: UIViewController) {
        self.rootViewController = root
    }
    
    public typealias Context = UIViewControllerRepresentableContext<UINavigationView>
    
    public func makeUIViewController(context: Context) -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController)
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
