//
//  ContentView.swift
//  NightingaleBookkeeper
//
//  Created by Peter Iacobelli on 6/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentView: AppView = .LoginAuth
    @State private var authenticatedUsername: String = ""
    @State private var authenticatedOrgID: String = ""
    
    var body: some View {
        switch currentView {
        case .LoginAuth:
            LoginAuth(currentView: $currentView, authenticatedUsername: $authenticatedUsername, authenticatedOrgID: $authenticatedOrgID)
        }
    }
}

