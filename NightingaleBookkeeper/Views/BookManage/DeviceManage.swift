//
//  BookManage.swift
//  NightingaleBookkeeper
//
//  Created by Peter Iacobelli on 6/6/24.
//

import SwiftUI
import SceneKit

struct WatchData: Codable {
    let devType: String
    let devID: String
    let assignedTo: String
    let lastAssigned: String
    let battery: String
}


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
    
    @State private var deviceInfo: [WatchData] = []
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
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
                
                Spacer()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: geometry.size.width * 0.05) {
                        ForEach(deviceInfo, id: \.devID) { device in
                            deviceCell(for: device, geometry: geometry)
                        }
                    }
                }
                .frame(height: geometry.size.height * 0.82)
                .frame(width: geometry.size.width * 1.0)
                
                Spacer()
                
                HStack(alignment: .center) {
                    HStack {
                        VStack {
                            Button(action: {
                                self.authenticatedUsername = ""
                                self.currentView = .LoginAuth
                            }) {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: geometry.size.height * 0.022)
                                    .foregroundColor(Color.white)
                                    .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 0)
                            }
                            
                            Text("Add")
                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                .foregroundColor(Color.white)
                                .opacity(0.6)
                        }
                        .padding(.leading, geometry.size.width * 0.03)
                        
                        VStack {
                            Button(action: {
                                self.authenticatedUsername = ""
                                self.currentView = .LoginAuth
                            }) {
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: geometry.size.height * 0.022)
                                    .foregroundColor(Color.white)
                                    .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 0)
                            }
                            
                            Text("Remove")
                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                .foregroundColor(Color.white)
                                .opacity(0.6)
                        }
                        .padding(.leading, geometry.size.width * 0.03)
                    }
                    .padding(.top, geometry.size.height * 0.02)
                    .padding(.bottom, geometry.size.height * 0.01)
                    
                    Spacer()
                    
                    HStack {
                        VStack {
                            Button(action: {
                                self.authenticatedUsername = ""
                                self.currentView = .LoginAuth
                            }) {
                                Image(systemName: "lock")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: geometry.size.height * 0.022)
                                    .foregroundColor(Color.white)
                                    .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 0)
                            }
                            
                            Text("Logout")
                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                .foregroundColor(Color.white)
                                .opacity(0.6)
                        }
                        .padding(.trailing, geometry.size.width * 0.03)
                    }
                    .padding(.top, geometry.size.height * 0.02)
                    .padding(.bottom, geometry.size.height * 0.01)
                    
                }
                .frame(width: geometry.size.width * 1.0)
                .edgesIgnoringSafeArea(.all)
                .background(Color(hex: 0x504F51))
                .background(
                    VStack {
                        Rectangle()
                            .frame(height: geometry.size.height * 0.001)
                            .foregroundColor(.gray)
                        Spacer()
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
    private func deviceCell(for device: WatchData, geometry: GeometryProxy) -> some View {
        VStack {
            HStack {
                VStack(alignment: .trailing) {
                    Text("Device Type: ")
                        .font(.system(size: geometry.size.height * 0.012, weight: .heavy))
                        .foregroundColor(Color.black)
                    
                    Text("Device ID: ")
                        .font(.system(size: geometry.size.height * 0.012, weight: .heavy))
                        .foregroundColor(Color.black)
                        .padding(.top, geometry.size.height * 0.002)
                        
                }
                VStack(alignment: .leading) {
                    Text(device.devType)
                        .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                        .foregroundColor(Color.black)
                        .italic()
                    
                    Text(device.devID)
                        .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                        .foregroundColor(Color.black)
                        .italic()
                        .padding(.top, geometry.size.height * 0.002)
                }
            }
            
            WatchView(devType: device.devType)

            
            VStack {
                HStack {
                    Spacer()
                    Text(device.assignedTo != "None" ? "In Use: " : "Available")
                        .font(.system(size: geometry.size.height * 0.01, weight: .heavy))
                    Text(device.assignedTo != "None" ? device.assignedTo : "")
                        .font(.system(size: geometry.size.height * 0.01, weight: .regular))
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.3)
                .padding(.vertical, geometry.size.height * 0.01)
                .background(device.assignedTo != "None" ? Color(hex: 0x5BBA6F).opacity(0.1) : Color(hex: 0xBD9B19).opacity(0.1))
                .foregroundColor(device.assignedTo != "None" ? Color(hex: 0x6BC17D).opacity(1) : Color(hex: 0xBD9B19))
                .overlay(
                    RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                        .stroke(device.assignedTo != "None" ? Color(hex: 0x6BC17D).opacity(1) : Color(hex: 0xBD9B19), lineWidth: geometry.size.width * 0.004)
                )
                
                let batteryStatusText = Int(device.battery) ?? 0 < 20 ? "Not Charged: " : "Charged: "
                let batteryStatusPrimaryColor = Int(device.battery) ?? 0 < 20 ? Color(hex: 0xE54B4B).opacity(1) : Color(hex: 0x6BC17D).opacity(1)
                let batteryStatusSecondaryColor = Int(device.battery) ?? 0 < 20 ? Color(hex: 0xE54B4B).opacity(0.1) : Color(hex: 0x5BBA6F).opacity(0.1)
                HStack {
                    Spacer()
                    Text(batteryStatusText)
                        .font(.system(size: geometry.size.height * 0.01, weight: .heavy))
                    Text("\(device.battery)%")
                        .font(.system(size: geometry.size.height * 0.01, weight: .regular))
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.3)
                .padding(.vertical, geometry.size.height * 0.01)
                .background(batteryStatusSecondaryColor)
                .foregroundColor(batteryStatusPrimaryColor)
                .overlay(
                    RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                        .stroke(batteryStatusPrimaryColor, lineWidth: geometry.size.width * 0.004)
                )
            }
        }
        .frame(width: geometry.size.width * 0.38, height: geometry.size.height * 0.28)
        .padding(geometry.size.height * 0.014)
        .padding(.vertical, geometry.size.height * 0.005)
        .background(Color(hex: 0xF6FCFE).opacity(0.8))
        .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
        .cornerRadius(geometry.size.width * 0.01)
        .overlay(
            RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                .stroke(Color(hex: 0xDFE6E9).opacity(0.6), lineWidth: geometry.size.width * 0.004)
        )
        .shadow(color: .gray, radius: geometry.size.width * 0.004)
    }
}

