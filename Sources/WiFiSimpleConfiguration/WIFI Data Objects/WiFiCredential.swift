//
//  WiFiCredential.swift
//  
//
//  Created by Alec on 11/11/19.
//

import Foundation

/// Container for a single WiFi connection's credential
/// - Contains: Network Index, SSID, Authentication Type, Encryption Type, Network Key, and MAC Address
struct WiFiCredential: WiFiDataObject {
    /// - Parameter networkIndex: Optional Network Index used for connections
    var networkIndex: WiFiNetworkIndex = WiFiNetworkIndex()
    /// - Parameter ssid: Name of a network
    var ssid: WiFiSSID = WiFiSSID()
    /// - Parameter authType: Authentication used for connections
    var authType: WiFiAuthType = WiFiAuthType.open
    /// - Parameter encryptionType: Encryption used for connections
    var encryptionType: WiFiEncryptionType = WiFiEncryptionType.none
    /// - Parameter networkKey: Network Key (or password) used for connections
    var networkKey: WiFiNetworkKey = WiFiNetworkKey()
    /// - Parameter macAddress: Optional MAC Address used for connections
    var macAddress: WiFiMacAddress = WiFiMacAddress()
    
    /// When dealing with a Data NFC record, this is the string-representation of the type of a WiFi record
    static let mimeType: String = "application/vnd.wfa.wsc"
    
    /// Optional override for enabling DEBUG mode on `WiFiCredential.getString()`
    static let DEBUG: Bool = false
    
    /// Initializer for automatically creating a WiFi Credential from a list of bytes
    init(parse data: Data) {
        // Create a local copy of data
        var data = data
        // The data should have a main container for the credential
        guard let credential = WiFiDataContainer(parse: &data) else {
            print("Invalid data object, must include a \"Credential\" container to begin parsing")
            return
        }
        // Initial data can be overwritten with the contents of the credential
        data = credential.contents
        
        // Parse through the credentials to ensure we have all required values
        while data.count > 0 {
            guard let container = WiFiDataContainer(parse: &data) else { continue }
            
            switch container.identifier {
            case .authentication:
                guard let newAuthType = WiFiAuthType(rawValue: container.contents.last ?? 0xFF) else {
                    assertionFailure("Unknown authentication type")
                    continue
                }
                self.authType = newAuthType
            case .credential:
                // There should not be another credential outside of the initial one
                continue
            case .encryption:
                guard let newEncryptionType = WiFiEncryptionType(rawValue: container.contents.last ?? 0xFF) else {
                    assertionFailure("Unknown encryption type")
                    continue
                }
                self.encryptionType = newEncryptionType
            case .macAddress:
                self.macAddress = WiFiMacAddress(address: container.contents)
            case .networkIndex:
                self.networkIndex = WiFiNetworkIndex(value: container.contents.first ?? 0x01)
            case .networkKey:
                self.networkKey = WiFiNetworkKey(value: String(data: container.contents, encoding: .utf8) ?? "")
            case .ssid:
                self.ssid = WiFiSSID(value: String(data: container.contents, encoding: .utf8) ?? "")
            }
        }
    }
    
    /// Initializer for manually creating a WiFi Credential
    /// - Parameter networkIndex: Optional Network Index used for connections
    /// - Parameter ssid: Name of a network
    /// - Parameter authType: Authentication used for connections
    /// - Parameter encryptionType: Encryption used for connections
    /// - Parameter networkKey: Network Key (or password) used for connections
    /// - Parameter macAddress: Optional MAC Address used for connections
    init(networkIndex: WiFiNetworkIndex,
         ssid: WiFiSSID,
         authType: WiFiAuthType,
         encryptionType: WiFiEncryptionType,
         networkKey: WiFiNetworkKey,
         macAddress: WiFiMacAddress) {
        
        self.networkIndex = networkIndex
        self.ssid = ssid
        self.authType = authType
        self.encryptionType = encryptionType
        self.networkKey = networkKey
        self.macAddress = macAddress
    }
    
    /// Return a Data representation of the Data Object
    /// Used for serializing all objects together
    func dataRepresentation() -> Data {
        let objects: [WiFiDataObject] = [networkIndex, ssid, authType, encryptionType, networkKey, macAddress]
        let objectData = objects.map {$0.dataRepresentation()}.reduce(Data(), +)
        let container = WiFiDataContainer(identifier: .credential, contents: objectData)
        return container.dataRepresentation()
    }
    
    func stringRepresentation() -> String {
        if Self.DEBUG {
            // Return all data points in a String
            return "Index: \(networkIndex.value)\nSSID: \(ssid.value)\nAuthentication: \(authType.getString())\nEncryption: \(encryptionType.getString())\nNetwork Key: \(networkKey.value)\nMAC Address: \(macAddress.address)"
        } else {
            // Return all relevant data points in a String
            var string = "SSID: \(ssid.value)\nAuthentication: \(authType.getString())"
            string += (authType != .open) ? "\nNetwork Key: \(networkKey.value)" : ""
            return string
        }
    }
}
