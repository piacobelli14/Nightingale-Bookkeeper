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
    
    var body: some View {
        switch currentView {
        case .DeviceManage:
            DeviceManage(currentView: $currentView, authenticatedUsername: $authenticatedUsername, authenticatedOrgID: $authenticatedOrgID, selectedDeviceID: $selectedDeviceID)
        case .AddDevice:
            AddDevice(currentView: $currentView, authenticatedUsername: $authenticatedUsername, authenticatedOrgID: $authenticatedOrgID, selectedDeviceID: $selectedDeviceID)
        case .RemoveDevice:
            RemoveDevice(currentView: $currentView, authenticatedUsername: $authenticatedUsername, authenticatedOrgID: $authenticatedOrgID, selectedDeviceID: $selectedDeviceID)
        case .LoginAuth:
            LoginAuth(currentView: $currentView, authenticatedUsername: $authenticatedUsername, authenticatedOrgID: $authenticatedOrgID)
        case .ResetAuth:
            ResetAuth(currentView: $currentView)
        }
    }
}

