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
    
    @State private var newDevType: String = ""
    @State private var newDevID: String = ""
    
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
                    
                    Text("Register New Device")
                        .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                        .foregroundColor(Color.white)
                        .shadow(color: .gray.opacity(0.3), radius: 0, x: 0, y: 2)
                        .padding(.leading, geometry.size.width * 0.02)
                    Spacer()
                }
                .padding(.top, geometry.size.height * 0.02)
                
                Spacer()
                
                VStack {
                    Text("Select New Device Type")
                        .font(.system(size: geometry.size.height * 0.02, weight: .semibold))
                        .foregroundColor(Color.white)
                        .shadow(color: .gray, radius: geometry.size.width * 0.05)
                    Menu {
                        ForEach(Array(["Apple Watch SE", "Fitbit Sense"]), id: \.self) { type in
                            Button(type) {
                                newDevType = type
                            }
                        }
                    } label: {
                        Text(newDevType == "" ? "Select Device Type" : newDevType)
                            .multilineTextAlignment(.center).foregroundColor(.black)
                            .frame(width: geometry.size.width * 0.6)
                            .padding(.vertical, geometry.size.width * 0.02)
                            .font(.system(size: geometry.size.height * 0.014, weight: .light))
                            .multilineTextAlignment(.center)
                            .background(Color(hex: 0xF6FCFE))
                            .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                            .cornerRadius(geometry.size.width * 0.01)
                            .overlay(
                                RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                    .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                            )
                            .shadow(color: .gray, radius: geometry.size.width * 0.004)
                    }
                    .accentColor(.black)
                }
                
                VStack {
                    Text("Enter a New Device ID")
                        .font(.system(size: geometry.size.height * 0.02, weight: .semibold))
                        .foregroundColor(Color.white)
                        .shadow(color: .gray, radius: geometry.size.width * 0.05)
                    
                    TextField("Enter a Device ID", text:  $newDevID)
                        .multilineTextAlignment(.center).foregroundColor(.black)
                        .autocorrectionDisabled(false)
                        .autocapitalization(.none)
                        .frame(width: geometry.size.width * 0.6)
                        .padding(.vertical, geometry.size.width * 0.02)
                        .font(.system(size: geometry.size.height * 0.014, weight: .light))
                        .multilineTextAlignment(.center)
                        .background(Color(hex: 0xF6FCFE))
                        .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                        .cornerRadius(geometry.size.width * 0.01)
                        .overlay(
                            RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                        )
                        .shadow(color: .gray, radius: geometry.size.width * 0.004)

                }
                .padding(.top, geometry.size.height * 0.02)
                
                
                VStack {
                    HStack {
                        VStack(alignment: .trailing) {
                            Text(newDevType != "" ? "Device Type: " : "")
                                .font(.system(size: geometry.size.height * 0.016, weight: .heavy))
                                .foregroundColor(Color.black)
                            
                            Text(newDevID != "" ? "Device ID: " : "")
                                .font(.system(size: geometry.size.height * 0.016, weight: .heavy))
                                .foregroundColor(Color.black)
                                .padding(.top, geometry.size.height * 0.002)
                                
                        }
                        VStack(alignment: .leading) {
                            Text(newDevType)
                                .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                                .foregroundColor(Color.black)
                                .italic()
                            
                            Text(newDevID)
                                .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                                .foregroundColor(Color.black)
                                .italic()
                                .padding(.top, geometry.size.height * 0.002)
                        }
                    }
                    
                    WatchView(devType: "AppleWatch")
                    
                }
                .frame(width: geometry.size.width * 0.44, height: geometry.size.height * 0.32)
                .padding(.vertical, geometry.size.height * 0.015)
                .padding(.horizontal, geometry.size.width * 0.005)
                .background(Color(hex: 0xF6FCFE).opacity(0.8))
                .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                .cornerRadius(geometry.size.width * 0.01)
                .overlay(
                    RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                        .stroke(Color(hex: 0xDFE6E9).opacity(0.6), lineWidth: geometry.size.width * 0.004)
                )
                .shadow(color: .gray, radius: geometry.size.width * 0.004)
                .padding(.top, geometry.size.height * 0.05)
                
                
               
                Button(action: {
                    registerDevice()
                }) {
                    HStack {
                        Text("Register New Device")
                            .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                            .foregroundColor(Color(hex: 0xF5F5F5))
                    }
                    .frame(width: geometry.size.width * 0.6)
                    .padding(.vertical, geometry.size.height * 0.016)
                    .background(Color(hex: 0x3C537A))
                    .cornerRadius(geometry.size.width * 0.01)
                    .shadow(color: .gray, radius: geometry.size.width * 0.004)
                }
                .padding(.top, geometry.size.height * 0.1)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: geometry.size.height * 0.012))
                        .padding(.top, geometry.size.height * 0.02)
                }
                
                
                
                Spacer()
                
            }
            .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 1.0)
            .background(gradient)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    private func registerDevice() {
        guard !newDevType.isEmpty, !newDevID.isEmpty else {
            self.errorMessage = "All fields are required."
            return
        }
        
        guard let token = loadTokenFromKeychain() else {
            return
        }

        let requestBody: [String: Any] = [
            "organizationID": authenticatedOrgID,
            "devType": newDevType,
            "devID": newDevID,
        ]

        let url = URL(string: "https://nightingale-web-api.vercel.app/nightingale/api/add-device")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "An error occurred: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received from the server."
                }
                return
            }

            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.currentView = .DeviceManage
                }
            } else {
                DispatchQueue.main.async {
                    if let responseBody = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let message = responseBody["message"] as? String {
                        self.errorMessage = message
                    } else {
                        self.errorMessage = "An unknown error occurred."
                    }
                }
            }
        }
        .resume()
    }
}
