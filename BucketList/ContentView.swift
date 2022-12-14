//
//  ContentView.swift
//  BucketList
//
//  Created by Jacek Kosinski U on 17/09/2022.
//
import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
                
        }
        .onAppear(perform: authenticate)
        .padding()
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics
                                     , error:     &error) {
            let reason = "We unlock your data i get a bank credit on your name"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                if success {
                    // authenticate succesfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
