import SwiftUI
import Foundation

struct DeviceManage: View {
    @Binding var currentView: AppView
    @Binding var authenticatedUsername: String
    @Binding var authenticatedOrgID: String
    @Binding var selectedDeviceID: String
    @State private var errorMessage: String? = nil
    @State private var isLoading: Bool = false
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0x222832), Color(hex: 0x33435F)]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    @State private var deviceInfo: [WatchData] = []
    @State private var selectedDeviceLog: [DeviceLogData] = []
    @State private var watchCells: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
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
                
                if isLoading {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                } else {
                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: watchCells, spacing: geometry.size.width * 0.03) {
                                ForEach(deviceInfo, id: \.devID) { device in
                                    deviceCell(for: device, geometry: geometry)
                                }
                            }
                        }
                        .opacity(selectedDeviceID.isEmpty ? 1.0 : 0.2)
                        if !selectedDeviceID.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Device Assignment Log")
                                    .font(.system(size: geometry.size.height * 0.03, weight: .bold))
                                    .foregroundColor(Color.white)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
                                
                                ScrollView {
                                    LazyVStack {
                                        if selectedDeviceLog.count > 0 {
                                            ForEach(selectedDeviceLog, id: \.swapTime) { log in
                                                VStack(alignment: .leading) {
                                                    HStack {
                                                        Text("Device:")
                                                            .font(.system(size: geometry.size.height * 0.02, weight: .bold))
                                                            .foregroundColor(Color.white)
                                                        
                                                        Text("\(log.devID)")
                                                            .font(.system(size: geometry.size.height * 0.018, weight: .semibold))
                                                            .italic()
                                                            .foregroundColor(Color.white)
                                                    }
                                                    .padding(.vertical, geometry.size.height * 0.001)
                                                    
                                                    HStack {
                                                        Text("Assigned To:")
                                                            .font(.system(size: geometry.size.height * 0.02, weight: .bold))
                                                            .foregroundColor(Color.white)
                                                        
                                                        Text("\(log.assignedTo != "Device Removed" ? "Pt #\(log.assignedTo)" : "Device Removed")")
                                                            .font(.system(size: geometry.size.height * 0.018, weight: .semibold))
                                                            .italic()
                                                            .foregroundColor(Color.white)
                                                        Spacer()
                                                    }
                                                    .padding(.vertical, geometry.size.height * 0.001)
                                                    
                                                    HStack {
                                                        Text("Swap Time: ")
                                                            .font(.system(size: geometry.size.height * 0.02, weight: .bold))
                                                            .foregroundColor(Color.white)
                                                        
                                                        Text("\(formatDate(log.swapTime))")
                                                            .font(.system(size: geometry.size.height * 0.018, weight: .semibold))
                                                            .italic()
                                                            .foregroundColor(Color.white)
                                                        Spacer()
                                                    }
                                                    .padding(.vertical, geometry.size.height * 0.001)
                                                }
                                                .padding(.vertical, geometry.size.height * 0.02)
                                                .background(Color(hex: 0x222222))
                                                Divider()
                                                    .background(Color.white)
                                                
                                            }
                                        } else {
                                            Spacer()
                                            HStack {
                                                Text("No previous assignment info.")
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                                                    .foregroundColor(Color.white)
                                                
                                                Spacer()
                                            }
                                            Spacer()
                                            
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    selectedDeviceID = ""
                                    selectedDeviceLog = []
                                }) {
                                    Text("Close")
                                        .font(.system(size: geometry.size.height * 0.02, weight: .bold))
                                        .foregroundColor(Color(hex: 0x222222))
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(geometry.size.width * 0.01)
                                        .shadow(color: .gray, radius: 5, x: 0, y: 0)
                                }
                            }
                            .padding()
                            .frame(height: geometry.size.height * 0.6)
                            .frame(width: geometry.size.width * 0.8)
                            .background(Color(hex: 0x222222))
                            .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                            .cornerRadius(geometry.size.width * 0.01)
                            .overlay(
                                RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                    .stroke(Color(hex: 0xDFE6E9).opacity(0.6), lineWidth: geometry.size.width * 0.004)
                            )
                            .shadow(color: .gray, radius: geometry.size.width * 0.004)
                        }
                    }
                    .frame(height: geometry.size.height * 0.80)
                    .frame(width: geometry.size.width * 0.96)
                    .padding(.top, geometry.size.height * 0.02)
                }
                Spacer()
                
                HStack(alignment: .center) {
                    HStack {
                        VStack {
                            Button(action: {
                                self.currentView = .AddDevice
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
                                self.currentView = .RemoveDevice
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
                                self.authenticatedOrgID = ""
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
            .onAppear {
                getDeviceInfo()
            }
        }
    }
    private func formatDate(_ isoDateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: isoDateString) else {
            return "Invalid date"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    private func deviceCell(for device: WatchData, geometry: GeometryProxy) -> some View {
        Button(action: {
            selectedDeviceID = device.devID
            getSelectedDeviceInfo()
        }) {
            VStack {
                HStack {
                    VStack(alignment: .trailing) {
                        Text("Device Type: ")
                            .font(.system(size: geometry.size.height * 0.016, weight: .heavy))
                            .foregroundColor(Color.black)
                        
                        Text("Device ID: ")
                            .font(.system(size: geometry.size.height * 0.016, weight: .heavy))
                            .foregroundColor(Color.black)
                            .padding(.top, geometry.size.height * 0.002)
                    }
                    VStack(alignment: .leading) {
                        Text(device.devType)
                            .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                            .foregroundColor(Color.black)
                            .italic()
                        
                        Text(device.devID)
                            .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                            .foregroundColor(Color.black)
                            .italic()
                            .padding(.top, geometry.size.height * 0.002)
                    }
                }
                
                WatchView(devType: "AppleWatch")
                
                VStack {
                    HStack {
                        Spacer()
                        Text(device.assignedTo != "None" ? "In Use: " : "Available")
                            .font(.system(size: geometry.size.height * 0.014, weight: .heavy))
                        Text(device.assignedTo != "None" ? device.assignedTo : "")
                            .font(.system(size: geometry.size.height * 0.014, weight: .regular))
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
                    
                    let batteryStatusText = Int(device.devBattery) ?? 0 < 20 ? "Not Charged: " : "Charged: "
                    let batteryStatusPrimaryColor = Int(device.devBattery) ?? 0 < 20 ? Color(hex: 0xE54B4B).opacity(1) : Color(hex: 0x6BC17D).opacity(1)
                    let batteryStatusSecondaryColor = Int(device.devBattery) ?? 0 < 20 ? Color(hex: 0xE54B4B).opacity(0.1) : Color(hex: 0x5BBA6F).opacity(0.1)
                    HStack {
                        Spacer()
                        Text(batteryStatusText)
                            .font(.system(size: geometry.size.height * 0.014, weight: .heavy))
                        Text("\(device.devBattery)%")
                            .font(.system(size: geometry.size.height * 0.014, weight: .regular))
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
            .frame(width: geometry.size.width * 0.44, height: geometry.size.height * 0.32)
            .padding(.vertical, geometry.size.height * 0.03)
            .padding(.horizontal, geometry.size.width * 0.005)
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
    
    private func getDeviceInfo() {
        guard let token = loadTokenFromKeychain() else {
          
            return
        }
        
        isLoading = true
        
        let requestBody: [String: Any] = [
            "organizationID": authenticatedOrgID
        ]
        
        let url = URL(string: "https://nightingale-health.duckdns.org/nightingale/api/get-devices")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            self.errorMessage = "JSON serialization error: \(error.localizedDescription)"
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received from the server"
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response from the server"
                }
                return
            }
            
            if response.statusCode == 200 {
                do {
                    DispatchQueue.main.async {
                        isLoading = false
                    }
                    
                    let decodedResponse = try JSONDecoder().decode(DeviceInfoResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.deviceInfo = decodedResponse.data
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "JSON decoding error: \(error.localizedDescription)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error with status code: \(response.statusCode)"
                }
            }
        }
        .resume()
    }
    
    private func getSelectedDeviceInfo() {
        guard let token = loadTokenFromKeychain() else {
            return
        }
        
        let requestBody: [String: Any] = [
            "organizationID": authenticatedOrgID,
            "devID": selectedDeviceID
        ]
        
        let url = URL(string: "https://nightingale-health.duckdns.org/nightingale/api/get-selected-device-log")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            self.errorMessage = "JSON serialization error: \(error.localizedDescription)"
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received from the server"
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response from the server"
                }
                return
            }
            
            if response.statusCode == 200 {
                do {
                    let decodedResponse = try JSONDecoder().decode(DeviceLogResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.selectedDeviceLog = decodedResponse.data
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "JSON decoding error: \(error.localizedDescription)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error with status code: \(response.statusCode)"
                }
            }
        }
        .resume()
    }
}
