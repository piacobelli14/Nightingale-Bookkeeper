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
    @State private var selectedDeviceID: String = ""
    @State private var isLoggedOut: Bool = false
    
    var body: some View {
        Group {
            switch currentView {
            case .LoginAuth:
                LoginAuth(currentView: $currentView, authenticatedUsername: $authenticatedUsername, authenticatedOrgID: $authenticatedOrgID)
                    .onAppear {
                        deleteTokenFromKeychain()
                        authenticatedUsername = ""
                        authenticatedOrgID = ""
                        selectedDeviceID = ""
                    }
            case .ResetAuth:
                ResetAuth(currentView: $currentView)
                    .onAppear { checkToken() }
            case .DeviceManage:
                DeviceManage(currentView: $currentView, authenticatedUsername: $authenticatedUsername, authenticatedOrgID: $authenticatedOrgID, selectedDeviceID: $selectedDeviceID)
                    .onAppear { checkToken() }
            case .AddDevice:
                AddDevice(currentView: $currentView, authenticatedUsername: $authenticatedUsername, authenticatedOrgID: $authenticatedOrgID, selectedDeviceID: $selectedDeviceID)
                    .onAppear { checkToken() }
            case .RemoveDevice:
                RemoveDevice(currentView: $currentView, authenticatedUsername: $authenticatedUsername, authenticatedOrgID: $authenticatedOrgID, selectedDeviceID: $selectedDeviceID)
                    .onAppear { checkToken() }
            }
        }
        .onAppear {
            initializeView()
        }
        .onChange(of: currentView) { newView in
            checkToken()
        }
    }

    func checkToken() {
        if let token = loadTokenFromKeychain() {
            if isTokenExpired(token: token) {
                deleteTokenFromKeychain()
                isLoggedOut = true
                currentView = .LoginAuth
            }
        } else {
            isLoggedOut = true
            currentView = .LoginAuth
        }
    }
    
    func initializeView() {
        if let token = loadTokenFromKeychain(), !isTokenExpired(token: token) {
            currentView = .DeviceManage
        } else {
            currentView = .LoginAuth
        }
    }
}

