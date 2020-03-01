//
//  File.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI

public struct LazyView<Content: View>: View {
    
    public let build: () -> Content
    
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    public var body: Content {
        build()
    }
}
