//
//  WiFiAuthType.swift
//  
//
//  Created by Alec on 11/11/19.
//

import Foundation

/// The WiFi Authentication Type to attach to the Credential
enum WiFiAuthType: UInt8, WiFiDataObject, CaseIterable {
    
    /// Open: No password or encryption available
    case open = 0x01
    
    /// WPA2 Personal: Requires password and typically uses
    /// - Encryption: Advanced Encryption Standard (AES) encryption
    /// - A replacement for WPA Personal, providing a higher level of security
    case wpa2Personal = 0x20
    
    /// WPA2 Enterprise:
    /// - Encryption: Advanced Encryption Standard (AES) encryption
    /// - A replacement for WPA Enterprise, providing a higher level of security
    case wpa2Enterprise = 0x10
    
    /// WPA Personal
    /// - Encryption: Temporal Key Integrity Protocol (TKIP) encryption
    /// - A replacement for Shared/WEP WiFi networks
    case wpaPersonal = 0x02
    
    /// WPA Enterprise
    /// - Encryption: Temporal Key Integrity Protocol (TKIP) encryption
    /// - A replacement for Shared/WEP WiFi networks
    case wpaEnterprise = 0x08
    
    /// Shared: Weakest standard form of authentication for WiFi, rarely used
    /// - Encryption: Wired Equivalent Privacy (WEP)
    case shared = 0x04
    
    
    /// Return a readable String of the Authentication Type
    func getString() -> String {
        switch self {
        case .open:
            return "Open"
        case .shared:
            return "Shared"
        case .wpaPersonal:
            return "WPA PSK (Personal)"
        case .wpa2Personal:
            return "WPA2 PSK (Personal)"
        case .wpaEnterprise:
            return "WPA EAP (Enterprise)"
        case .wpa2Enterprise:
            return "WPA2 EAP (Enterprise)"
        }
    }
    
    /// Return a Data representation of the Data Object
    /// Used for serializing all objects together
    func dataRepresentation() -> Data {
        let container = WiFiDataContainer(identifier: .authentication, contents: Data([0x00, self.rawValue]))
        return container.dataRepresentation()
    }
}
