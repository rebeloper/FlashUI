//
//  ViewModifiers.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI

struct RectangleImageViewModifier: ViewModifier {
    
    var size: CGSize
    var cornerRadius: CGFloat
    var didSelectImage: Bool
    
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: size.width, height: size.height)
            .background(Color.gray)
            .cornerRadius(cornerRadius)
    }
}

struct CircularImageViewModifier: ViewModifier {
    
    var width: CGFloat
    var didSelectImage: Bool
    
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: width, height: width)
            .background(Color.gray)
            .cornerRadius(width / 2)
    }
}
