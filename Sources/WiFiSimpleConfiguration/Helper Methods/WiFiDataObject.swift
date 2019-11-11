//
//  WiFiDataObject.swift
//  
//
//  Created by Alec on 11/11/19.
//

import Foundation

protocol WiFiDataObject {
    /// Return a Data representation of the Data Object
    /// Used for serializing all objects together
    func dataRepresentation() -> Data
}
