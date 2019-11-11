//
//  WiFiDataIdentifier.swift
//  
//
//  Created by Alec on 11/11/19.
//

import Foundation

/// An Identifier to organize the different types of Data groups
/// Identifiers are stored as three bytes in the format, [0x10, 0x__, 0x00], where the second byte is relevant, and the others signify the start and end of the identifier
/// - Note: Following the identifier is a single byte containing the size of data to follow. Directly after is the actual data, in the exact amount of bytes just determined.
enum WiFiDataIdentifier: UInt8 {
    
    /// - Parameter credential: Container for a single WiFi connection's credential
    /// - Contains: Network Index, SSID, Authentication Type, Encryption Type, Network Key, and MAC Address
    case credential = 0x0E
    
    /// - Parameter networkIndex: Optional Network Index used for connections
    case networkIndex = 0x26
    /// - Parameter ssid: Name of a network
    case ssid = 0x45
    /// - Parameter authType: Authentication used for connections
    case authentication = 0x03
    /// - Parameter encryptionType: Encryption used for connections
    case encryption = 0x0F
    /// - Parameter networkKey: Network Key (or password) used for connections
    case networkKey = 0x27
    /// - Parameter macAddress: Optional MAC Address used for connections
    case macAddress = 0x20
    
    // TODO: Add parameter for WPA/WPA2 Enterprise Username
    // Reference the data identifiers in the Wi-Fi Protected Setup Specification by the Wi-Fi Alliance, Page 86 of Version 1.0h
    // Currently, I am unsure of what value is meant to be used for EAP credentials and will ship as-is
    // NOTE: Theoretically, it would not be safe to share WPA/WPA2 Enterprise Wi-Fi Credentials
    
    /// Initializer for automatically reading a Data Identifier from a list of three (3) bytes
    /// Follows the format: [0x10, 0x__, 0x00]
    init?(from data: Data) {
        guard data.count == 3 else { return nil }
        guard data[0] == 0x10 else { return nil }
        let identifyingByte = data[1]
        guard data[2] == 0x00 else { return nil }
        guard let identifier = WiFiDataIdentifier(rawValue: identifyingByte) else { return nil }
        self = identifier
    }
    
    /// Return a Data representation of the Data Object
    /// Used for serializing all objects together
    func dataRepresentation() -> Data {
        let data = Data([0x10, self.rawValue, 0x00])
        return data
    }
}
