//
//  SwipeGesture.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI
import UIKit

public struct SwipeGesture: UIViewRepresentable {
    
    init(
        up: @escaping Action = {},
        left: @escaping Action = {},
        right: @escaping Action = {},
        down: @escaping Action = {}) {
        self.actions = Actions(up: up, left: left, right: right, down: down)
    }

    private let actions: Actions

    public typealias Context = UIViewRepresentableContext<SwipeGesture>

    public func makeUIView(context: Context) -> UIView {
        let coord = context.coordinator
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.addSwipeGesture(.up, target: coord, action: #selector(coord.swipeUp))
        view.addSwipeGesture(.left, target: coord, action: #selector(coord.swipeLeft))
        view.addSwipeGesture(.right, target: coord, action: #selector(coord.swipeRight))
        view.addSwipeGesture(.down, target: coord, action: #selector(coord.swipeDown))
        return view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {}
}

public extension SwipeGesture {
    
    typealias Action = () -> Void
    
    struct Actions {
        
        init(
            up: @escaping Action = {},
            left: @escaping Action = {},
            right: @escaping Action = {},
            down: @escaping Action = {}) {
            self.up = up
            self.left = left
            self.right = right
            self.down = down
        }
        
        let up: Action
        let left: Action
        let right: Action
        let down: Action
    }
}

public extension SwipeGesture {
    
    class Coordinator: NSObject {
        
        public init(gesture: SwipeGesture) {
            self.gesture = gesture
        }
        
        private let gesture: SwipeGesture
        
        @objc public func swipeLeft() { gesture.actions.left() }
        @objc public func swipeRight() { gesture.actions.right() }
        @objc public func swipeUp() { gesture.actions.up() }
        @objc public func swipeDown() { gesture.actions.down() }
    }
    
    func makeCoordinator() -> SwipeGesture.Coordinator {
        Coordinator(gesture: self)
    }
}

public extension UIView {
    
    public func addSwipeGesture(
        _ direction: UISwipeGestureRecognizer.Direction,
        target: Any?,
        action: Selector) {
        let swipe = UISwipeGestureRecognizer(target: target, action: action)
        swipe.direction = direction
        addGestureRecognizer(swipe)
    }
}

public extension View {
    
    public func onSwipeGesture(
        up: @escaping SwipeGesture.Action = {},
        left: @escaping SwipeGesture.Action = {},
        right: @escaping SwipeGesture.Action = {},
        down: @escaping SwipeGesture.Action = {}) -> some View {
        let gesture = SwipeGesture(up: up, left: left, right: right, down: down)
        return overlay(gesture)
    }
}
