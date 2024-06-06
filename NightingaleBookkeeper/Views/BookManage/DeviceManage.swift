//
//  BookManage.swift
//  NightingaleBookkeeper
//
//  Created by Peter Iacobelli on 6/6/24.
//

import SwiftUI

struct DeviceManage: View {
    @Binding var currentView: AppView
    @Binding var authenticatedUsername: String
    @Binding var authenticatedOrgID: String
    
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0x222832), Color(hex: 0x33435F)]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    @State private var errorMessage: String? = nil
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Image("nslogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geometry.size.height * 0.07)
                        .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 0)
                        .padding(.leading, geometry.size.width * 0.01)
                    
                    VStack(alignment: .leading) {
                        Text("Bookkeeper")
                            .font(.system(size: geometry.size.height * 0.03, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(color: .gray.opacity(0.3), radius: 0, x: 0, y: 2)
                        
                        Text("from Nightingale Health")
                            .font(.system(size: geometry.size.height * 0.01, weight: .bold))
                            .foregroundColor(.white)
                            .opacity(0.8)
                            .shadow(color: .gray.opacity(0.3), radius: 0, x: 0, y: 2)
                            .padding(.vertical, 0)
                    }
                    
                    Spacer()
                }
                .frame(width: geometry.size.width * 1.0)
                .padding(.top, geometry.size.height * 0.05)
                .edgesIgnoringSafeArea(.all)
                .background(
                    VStack {
                        Spacer()
                        Rectangle()
                            .frame(height: geometry.size.height * 0.001)
                            .foregroundColor(.gray)
                    }
                )
            }
            .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 1.0)
            .background(gradient)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

