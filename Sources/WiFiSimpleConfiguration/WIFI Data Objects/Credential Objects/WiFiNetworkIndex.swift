//
//  WiFiNetworkIndex.swift
//  
//
//  Created by Alec on 11/11/19.
//

import Foundation

/// An optional Network Index to attach to the Credential
struct WiFiNetworkIndex: WiFiDataObject {
    var value: UInt8 = 0x01 // Default Value
    
    /// Return a Data representation of the Data Object
    /// Used for serializing all objects together
    func dataRepresentation() -> Data {
        let container = WiFiDataContainer(identifier: .networkIndex, contents: Data([value]))
        return container.dataRepresentation()
    }
}
