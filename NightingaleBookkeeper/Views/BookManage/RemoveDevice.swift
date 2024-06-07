//
//  RemoveDevice.swift
//  NightingaleBookkeeper
//
//  Created by Peter Iacobelli on 6/7/24.
//

import SwiftUI

struct RemoveDevice: View {
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
                HStack(alignment: .center) {
                    Button(action: {
                        self.currentView = .DeviceManage
                    }) {
                        Image(systemName: "arrow.backward.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: geometry.size.height * 0.03)
                            .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 0)
                            .padding(.leading, geometry.size.width * 0.03)
                            .foregroundColor(Color.white)
                    }
                    
                    Text("Remove Registered Device")
                        .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                        .foregroundColor(Color.white)
                        .shadow(color: .gray.opacity(0.3), radius: 0, x: 0, y: 2)
                        .padding(.leading, geometry.size.width * 0.02)
                    Spacer()
                }
                .padding(.top, geometry.size.height * 0.02)
                
                Spacer()
            }
            .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 1.0)
            .background(gradient)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}
