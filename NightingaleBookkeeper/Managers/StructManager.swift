//
//  StructManager.swift
//  NightingaleBookkeeper
//
//  Created by Peter Iacobelli on 6/11/24.
//

import Foundation

struct LoginResponse: Codable {
    let userid: String
    let orgid: String
    let token: String
}

struct DeviceInfoResponse: Codable {
    let message: String
    let data: [WatchData]
}

struct DeviceLogResponse: Codable {
    let message: String
    let data: [DeviceLogData]
}

struct WatchData: Codable {
    let devID: String
    let devType: String
    let orgID: String
    let assignedTo: String
    let devBattery: String
}

struct DeviceLogData: Codable {
    let devID: String
    let assignedTo: String
    let swapTime: String
}
