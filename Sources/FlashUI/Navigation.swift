//
//  Navigation.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI

public typealias ActiveView = Int
public typealias Segues = VStack

/// Creates a segue. Please use `LazyView(build:_)` for `view` if you do not want to load the view imediately (useful in Lists)
public struct Segue<Destination: View>: View {
    
    @Binding public var activeView: ActiveView?
    public var push: ActiveView
    public var view: Destination
    
    public var body: some View {
        NavigationLink(destination: view, tag: push, selection: $activeView) {
            EmptyView()
        }
    }
}

/// Creates an active segue. Please use `LazyView(build:_)` for `view` if you do not want to load the view imediately (useful in Lists)
public struct ActiveSegue<Destination: View>: View {
    
    @Binding public var isActive: Bool
    public var view: Destination
    
    public var body: some View {
        NavigationLink(destination: view, isActive: $isActive) {
            EmptyView()
        }
    }
}


