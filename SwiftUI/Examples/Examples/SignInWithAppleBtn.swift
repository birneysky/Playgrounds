//
//  SignInWithAppleBtn.swift
//  Examples
//
//  Created by birneysky on 2020/3/18.
//  Copyright © 2020 Grocery. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleBtn: View {
    var body: some View {
        SignInWithAppleView()
        .frame(width: 200, height: 50)
    }
}

/// https://medium.com/better-programming/swiftui-sign-in-with-apple-c1e70ccb2a71
struct SignInWithAppleView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<SignInWithAppleView>) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline)
        button.cornerRadius = 10
        return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: UIViewRepresentableContext<SignInWithAppleView>) {
        
    }
    
    typealias UIViewType = ASAuthorizationAppleIDButton
    
    
    
}

struct SignInWithAppleBtn_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleBtn()
    }
}
