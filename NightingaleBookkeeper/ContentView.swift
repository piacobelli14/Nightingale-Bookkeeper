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
            } else {
                decodeToken(token: token)
            }
        } else {
            isLoggedOut = true
            currentView = .LoginAuth
        }
    }
    
    func initializeView() {
        if let token = loadTokenFromKeychain(), !isTokenExpired(token: token) {
            decodeToken(token: token)
            currentView = .DeviceManage
        } else {
            currentView = .LoginAuth
        }
    }

    func decodeToken(token: String) {
        let parts = token.split(separator: ".")
        guard parts.count == 3 else {
            return
        }

        let payload = parts[1]
        var base64String = String(payload)
        
        while base64String.count % 4 != 0 {
            base64String.append("=")
        }

        guard let decodedData = Data(base64Encoded: base64String) else {
            return
        }

        guard let json = try? JSONSerialization.jsonObject(with: decodedData, options: []),
              let dict = json as? [String: Any] else {
            return
        }

        if let username = dict["username"] as? String {
            authenticatedUsername = username
        }

        if let orgID = dict["orgid"] as? String {
            authenticatedOrgID = orgID
        }

        if let exp = dict["exp"] as? TimeInterval {
            let expirationDate = Date(timeIntervalSince1970: exp)
            let isExpired = Date() > expirationDate
        }
    }
}
