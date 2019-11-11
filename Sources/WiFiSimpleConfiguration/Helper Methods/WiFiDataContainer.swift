//
//  WiFiDataContainer.swift
//  
//
//  Created by Alec on 11/11/19.
//

import Foundation

/// Partitions of data in a WiFi record are organized with an identifier, then a byte count, then the contents of the data
/// - Identifier Example: Data([0x10, 0x45, 0x00]), where only the middle byte actually differs
/// - Byte Count: the length of the data to be shared; this must fit in one byte, so it must be <= 255 (0xFF)
/// - Data: Raw data, may be converted to a String, or may be a unique but pre-defined byte
class WiFiDataContainer {
    
    /// Usually a 3-byte Data set identifying the kind of data stored inside
    /// - Follows the format: [0x10, Unique Byte, 0x00]
    let identifier: WiFiDataIdentifier
    /// The contents of the data to be stored
    var contents: Data
    
    /// Initializer for manually creating a Data Container
    init(identifier: WiFiDataIdentifier, contents: Data) {
        self.identifier = identifier
        self.contents = contents
    }
    
    /// Initializer for automatically creating a Data Container from a list of bytes
    init?(parse data: inout Data) {
        
        // STEP 1
        // Ensure a valid Identifier
        let identifyingBytes = Data(data.prefix(3))
        guard let calculatedIdentifier = WiFiDataIdentifier(from: identifyingBytes) else {
            assertionFailure("Initial identifying bytes not valid")
            return nil
        }
        self.identifier = calculatedIdentifier
        data.removeFirst(3) // Remove the read bytes and continue
        
        // STEP 2
        // Review the data count (one byte <= 0xFF)
        guard let dataCount = data.first else {
            assertionFailure("No data available to decode")
            return nil
        }
        data.removeFirst() // Remove the read bytes and continue
        
        // STEP 3
        // Use the data count to store the relevant data
        self.contents = data.prefix(Int(dataCount))
        data.removeFirst(self.contents.count) // Remove the stored bytes and continue
        
        // STEP 4
        // Check for remaining data
        if data.count > 0 {
            //There is more data, so parsing should continue with a new container
        }
    }
    
    /// A computed value with the exportable formatting of the data.
    /// - This follows the format (ID + Byte Count + Data)
    func dataRepresentation() -> Data {
        // Ensure contents of data won't overflow the size byte. A byte must be <= 255 (0xFF)
        guard contents.count <= 0xFF else {
            assertionFailure("Contents too large to be encoded.")
            return Data()
        }
        // Contents will fit in one byte, generate Data
        // Data = [identifier (can be multiple bytes)] + [single byte for size of data] + [contents of data]
        var data = identifier.dataRepresentation() // Initialize with copy of identifier
        data.append(UInt8(contents.count)) // Add the single byte containing the contents' size
        data.append(contentsOf: contents) // Finally, add the contents
        return data
    }
}
