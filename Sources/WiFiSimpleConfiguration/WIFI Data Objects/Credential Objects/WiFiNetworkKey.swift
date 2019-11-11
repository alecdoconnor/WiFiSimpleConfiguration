//
//  WiFiNetworkKey.swift
//  
//
//  Created by Alec on 11/11/19.
//

import Foundation

/// A Network Key, or password, to attach to the Credential
struct WiFiNetworkKey: WiFiDataObject {
    var value: String = ""
    
    /// Return a Data representation of the Data Object
    /// Used for serializing all objects together
    func dataRepresentation() -> Data {
        let container = WiFiDataContainer(identifier: .networkKey, contents: value.data(using: .utf8) ?? Data())
        return container.dataRepresentation()
    }
}
