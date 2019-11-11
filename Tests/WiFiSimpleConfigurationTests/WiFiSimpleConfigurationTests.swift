import XCTest
@testable import WiFiSimpleConfiguration

extension Data {
    func toHexString() -> String {
        var hex: String = self.map({ String(format: "%02X ", $0) }).reduce("", +)
        if hex.count > 0 {
            hex = String(hex.dropLast())
        }
        return hex
    }
}

extension String {
    func hexToData() -> Data {
        let bytes = self.split(separator: " ").compactMap { UInt8(String($0), radix: 16) }
        return Data(bytes)
    }
}

final class WiFiSimpleConfigurationTests: XCTestCase {
    
    func testEncodeWiFi() {
        
        let networkIndex = WiFiNetworkIndex() // Network Index can be left with default value
        let ssid = WiFiSSID(value: "SSID")
        let authType = WiFiAuthType.wpa2Personal
        let encryptionType = WiFiEncryptionType.aes
        let networkKey = WiFiNetworkKey(value: "PASSWORD")
        let macAddress = WiFiMacAddress() // MAC Address can be left with default value
        
        let encodedCredentials = WiFiCredential(networkIndex:   networkIndex,
                                                ssid:           ssid,
                                                authType:       authType,
                                                encryptionType: encryptionType,
                                                networkKey:     networkKey,
                                                macAddress:     macAddress)
        
        print(encodedCredentials.dataRepresentation().toHexString())
        
        XCTAssertEqual(encodedCredentials.dataRepresentation().toHexString(),
                       "10 0E 00 2F 10 26 00 01 01 10 45 00 04 53 53 49 44 10 03 00 02 00 20 10 0F 00 02 00 08 10 27 00 08 50 41 53 53 57 4F 52 44 10 20 00 06 FF FF FF FF FF FF")
        
    }
    func testDecodeWiFi() {
        let byteString = "10 0E 00 2F 10 26 00 01 01 10 45 00 04 53 53 49 44 10 03 00 02 00 20 10 0F 00 02 00 08 10 27 00 08 50 41 53 53 57 4F 52 44 10 20 00 06 FF FF FF FF FF FF"
        let payload = byteString.hexToData()
        let decodedCredentials = WiFiCredential(parse: payload)
        
        XCTAssertEqual(decodedCredentials.networkIndex.value,               WiFiNetworkIndex().value)
        XCTAssertEqual(decodedCredentials.ssid.value,                       WiFiSSID(value: "SSID").value)
        XCTAssertEqual(decodedCredentials.authType,                         WiFiAuthType.wpa2Personal)
        XCTAssertEqual(decodedCredentials.encryptionType,                   WiFiEncryptionType.aes)
        XCTAssertEqual(decodedCredentials.networkKey.value,                 WiFiNetworkKey(value: "PASSWORD").value)
        XCTAssertEqual(decodedCredentials.macAddress.address.toHexString(), WiFiMacAddress().address.toHexString())
    }

    static var allTests = [
        ("testEncodeWiFi", testEncodeWiFi),
        ("testDecodeWiFi", testDecodeWiFi)
    ]
}
