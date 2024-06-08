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
    
    @State private var removeDevID: String = ""
    @State private var removeDevType: String = ""
    @State private var validationCheck: Bool = false
    
    @State private var watchDataList: [WatchData] = []
    @State private var devIDs: [String] = []
    
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
                
                VStack {
                    Text("Select A Device To Remove")
                        .font(.system(size: geometry.size.height * 0.02, weight: .semibold))
                        .foregroundColor(Color.white)
                        .shadow(color: .gray, radius: geometry.size.width * 0.05)
                    Menu {
                        ForEach(devIDs, id: \.self) { devID in
                            Button(devID) {
                                removeDevID = devID
                                if let device = watchDataList.first(where: { $0.devID == devID }) {
                                    removeDevType = device.devType
                                }
                            }
                        }
                    } label: {
                        Text(removeDevID == "" ? "Select Device ID" : removeDevID)
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
                    HStack {
                        VStack(alignment: .trailing) {
                            Text(removeDevType != "" ? "Device Type: " : "")
                                .font(.system(size: geometry.size.height * 0.016, weight: .heavy))
                                .foregroundColor(Color.black)
                            
                            Text(removeDevID != "" ? "Device ID: " : "")
                                .font(.system(size: geometry.size.height * 0.016, weight: .heavy))
                                .foregroundColor(Color.black)
                                .padding(.top, geometry.size.height * 0.002)
                                
                        }
                        VStack(alignment: .leading) {
                            Text(removeDevType)
                                .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                                .foregroundColor(Color.black)
                                .italic()
                            
                            Text(removeDevID)
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
                
                
                HStack {
                    Image(systemName: validationCheck ? "checkmark.square.fill" : "square")
                        .frame(width: geometry.size.width * 0.025)
                        .foregroundColor(.white)
                        .font(.system(size: geometry.size.height * 0.025))
                        .onTapGesture {
                            validationCheck.toggle()
                        }
                    
                    Text("I understand that all of this device's information will be permanently deleted. This change can not be undone.")
                        .font(.system(size: geometry.size.height * 0.01, weight: .semibold))
                        .foregroundColor(Color.white)
                        .opacity(0.9)
                        .padding(.leading, geometry.size.width * 0.02)
                        .multilineTextAlignment(.leading)
                }
                .padding(.top, geometry.size.height * 0.085)
                .frame(width: geometry.size.width * 0.6)
                
                Button(action: {
                    if validationCheck {
                        
                    }
                }) {
                    HStack {
                        Text("Remove Device")
                            .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                            .foregroundColor(Color(hex: 0xF5F5F5))
                    }
                    .frame(width: geometry.size.width * 0.6)
                    .padding(geometry.size.height * 0.016)
                    .background(Color(hex: 0x3C537A))
                    .cornerRadius(geometry.size.width * 0.01)
                    .shadow(color: .gray, radius: geometry.size.width * 0.004)
                }
                .padding(.top, geometry.size.height * 0.02)
                
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
            .onAppear {
                getAvailableDeviceInfo()
            }
        }
    }

    private func getAvailableDeviceInfo() {
        let url = URL(string: "http://172.20.10.2:5000/get-devices")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "orgID": authenticatedOrgID
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            self.errorMessage = "JSON serialization error: \(error.localizedDescription)"
            print(self.errorMessage)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    print(self.errorMessage)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received from the server"
                    print(self.errorMessage)
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response from the server"
                    print(self.errorMessage)
                }
                return
            }
            
            if response.statusCode == 200 {
                do {
                    let decodedResponse = try JSONDecoder().decode(DeviceInfoResponse.self, from: data)
                    DispatchQueue.main.async {
                        // Set watchDataList to filter devices where assignedTo is "None"
                        self.watchDataList = decodedResponse.data.filter { $0.assignedTo == "None" }
                        // Set devIDs from filtered watchDataList
                        self.devIDs = self.watchDataList.map { $0.devID }
                        print(self.devIDs)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "JSON decoding error: \(error.localizedDescription)"
                        print(self.errorMessage)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error with status code: \(response.statusCode)"
                    print(self.errorMessage)
                }
            }
        }
        .resume()
    }
}
