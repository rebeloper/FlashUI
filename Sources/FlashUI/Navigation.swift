//
//  Navigation.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI

public typealias ActiveView = Int

public struct Segue<Destination: View>: View {
    
    @Binding public var activeView: ActiveView?
    public var push: ActiveView
    public var view: Destination
    
    public var body: some View {
        NavigationLink(destination: LazyView(self.view), tag: push, selection: self.$activeView) {
            EmptyView()
        }
    }
}

