//
//  WiFiSSID.swift
//  
//
//  Created by Alec on 11/11/19.
//

import Foundation

/// An SSID to attach to the Credential
struct WiFiSSID: WiFiDataObject {
    var value: String = ""
    
    /// Return a Data representation of the Data Object
    /// Used for serializing all objects together
    func dataRepresentation() -> Data {
        let container = WiFiDataContainer(identifier: .ssid, contents: value.data(using: .utf8) ?? Data())
        return container.dataRepresentation()
    }
}
