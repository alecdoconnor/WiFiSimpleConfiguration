//
//  WiFiMacAddress.swift
//  
//
//  Created by Alec on 11/11/19.
//

import Foundation

/// An optional MAC address to attach to the Credential
struct WiFiMacAddress: WiFiDataObject {
    var address: Data = Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF])
    
    /// Return a Data representation of the Data Object
    /// Used for serializing all objects together
    func dataRepresentation() -> Data {
        let container = WiFiDataContainer(identifier: .macAddress, contents: address)
        return container.dataRepresentation()
    }
}
