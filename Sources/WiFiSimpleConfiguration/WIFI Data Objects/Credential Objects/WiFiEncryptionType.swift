//
//  WiFiEncryptionType.swift
//  
//
//  Created by Alec on 11/11/19.
//

import Foundation


/// The WiFi Encryption Type to attach to the Credential
/// - Note: Will match a specific `WiFiAuthType`.
enum WiFiEncryptionType: UInt8, WiFiDataObject, CaseIterable {
    /// None: Used with the Open Authentication Type, requires no password
    /// - Security: None
    case none = 0x01
    
    /// AES: Used with the WPA2 Authentication Type, requires password
    /// - Security: Strong
    case aes = 0x08
    
    /// TKIP: Used with the WPA Authentication Type, requires password
    /// - Security: Weak
    case tkip = 0x04
    
    /// WEP: Used with the Shared Authentication Type, requires password
    /// - Security: Very Weak
    case wep = 0x02
    
    
    func getString() -> String {
        switch self {
        case .none:
            return "None"
        case .wep:
            return "WEP"
        case .tkip:
            return "TKIP"
        case .aes:
            return "AES"
        }
    }
    
    /// Return a Data representation of the Data Object
    /// Used for serializing all objects together
    func dataRepresentation() -> Data {
        let container = WiFiDataContainer(identifier: .encryption, contents: Data([0x00, self.rawValue]))
        return container.dataRepresentation()
    }
}
