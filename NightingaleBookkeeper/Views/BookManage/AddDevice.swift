//
//  AddDevice.swift
//  NightingaleBookkeeper
//
//  Created by Peter Iacobelli on 6/7/24.
//

import SwiftUI

struct AddDevice: View {
    @Binding var currentView: AppView
    @Binding var authenticatedUsername: String
    @Binding var authenticatedOrgID: String
    @Binding var selectedDeviceID: String
    @State private var errorMessage: String? = nil
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0x222832), Color(hex: 0x33435F)]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
            }
            .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 1.0)
            .background(gradient)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}
