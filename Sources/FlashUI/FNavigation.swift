//
//  FNavigation.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI

typealias FActiveView = Int

struct Segue<Destination: View>: View {
    
    @Binding var activeView: FActiveView?
    var tag: FActiveView
    var destination: () -> Destination
    
    var body: some View {
        NavigationLink(destination: destination(), tag: tag, selection: self.$activeView) {
            EmptyView()
        }
    }
}

/*
 
 HOW TO USE:
 
 We are in the OnboardingView and we want to navigate to SignInView when we tap on a button
 
 0. Create an FNavigationSetup file with:
    
    import SwiftUI
 
 1. Create an FView
 
    This is actually a tag that is an Int
 
 struct FViews {
    static let signIn = 1
 }
 
 2. Create a Segue for a View
 
    This is actually a View which has an activeView Binging -> @Binding var activeView: FActiveView?
    It is taged by the View you created in Step 1 -> FViews.signIn
    It has a destination View - the View where you want to navigate -> SignInView()
 
 struct OnboardingViewSegues: View {
     @Binding var activeView: FActiveView?
     var body: some View {
         VStack {
             Segue(activeView: $activeView, tag: FViews.signIn) {
                 SignInView()
             }
         }
     }
 }
 
 3. Use it on the View
 
    Make sure you are inside a NavigationView
    Note: once you have instantiated a NavigationView you don't have to do it in the upcoming "navigated to" Views (SwiftUI stuff)
    
    a). create an activeView -> @State private var activeView: FActiveView?
    b). add the Segue with this activeView to the View hierarchy (inside the VStack) -> OnboardingViewSegues(activeView: $activeView)
    c). when you want to navigate change the activeView -> self.activeView = FViews.signIn
 
 struct OnboardingView: View {
     
     @State private var activeView: FActiveView?
     
     var body: some View {
         NavigationView {
             VStack {
                 OnboardingViewSegues(activeView: $activeView)
                 
                 Button(action: {
                     self.activeView = FViews.signIn
                 }, label: {
                     ButtonView(title: "Sign in")
                 })
             }
         }
     }
 }

 --------------------------------------------------------------
 
 OPTIONS:
 
 You can pass along dependencies too:
 
 struct AuthorProductSessionsViewSegues: View {
     @Binding var activeView: FActiveView?
     
     var profile: Profile
     var session: Session
     var sessionCount: Int
     var height: CGFloat
     
     var product: Product
     
     var body: some View {
         VStack {
             Segue(activeView: $activeView, tag: FViews.authorSession) {
                 AuthorSessionView(profile: self.profile, session: self.session, sessionCount: self.sessionCount, height: self.height)
             }
             
             Segue(activeView: $activeView, tag: FViews.authorEditProduct) {
                 AuthorEditProductView(product: self.product)
             }
         }
     }
 }
 
 In this case the AuthorProductSessionsView will have this Segue:
 
 AuthorProductSessionsViewSegues(activeView: self.$activeView,
    profile: profile,
    session: selectedSession,
    sessionCount: sessionCount,
    height: 100,
    product: product)
 
 ... with these States declared in the AuthorProductSessionsView (the parent view):
 
 @State var profile: Profile = Profile()
 @State var selectedSession: Session = Session()
 @State var sessionCount: Int = 0
 @State var height: CGFloat = 0
 @State var product: Product = Product()
 
 Also make sure that we can inject the specific depenedencies into AuthorSessionView and AuthorEditProductView
*/

