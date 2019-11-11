# WiFiSimpleConfiguration

Encode and decode Wi-Fi records using the Wi-Fi Alliance Specifications' **Wi-Fi Simple Configuration**

- *Note*: Learn more about the specifications by checking out some of the [docs](https://ndeflib.readthedocs.io/en/stable/records/wifi.html).



## Usage

Everything is performed using the `WiFiCredential` object which has convenience methods to encode and decode credentials.
### Encoding

Pass relevant Wi-Fi Data Objects into the `WiFiCredential` initializer:

```
let networkIndex = WiFiNetworkIndex() // Network Index can be left with default value
let ssid = WiFiSSID(value: "SSID")
let authType = WiFiAuthType.wpa2Personal
let encryptionType = WiFiEncryptionType.aes
let networkKey = WiFiNetworkKey(value: "PASSWORD")
let macAddress = WiFiMacAddress() // MAC Address can be left with default value
```
```
let credentials = WiFiCredential(networkIndex:   networkIndex,
                                        ssid:           ssid,
                                        authType:       authType,
                                        encryptionType: encryptionType,
                                        networkKey:     networkKey,
                                        macAddress:     macAddress)
```

Access the data for this object using the `dataRepresentation()` method:

```
let payload: Data = credentials.dataRepresentation()
...
```

### Decoding

Pass a `Data` object that stores a Wi-Fi record into the `WiFiCredential` parsing initializer:

```
let payload: Data = ...
let decodedCredentials = WiFiCredential(parse: payload)
```


## Purpose

The Wi-Fi Simple Configuration specification is all but simple. It is a very powerful specification with little documentation online.
I want to make it easier for developers to work with this specification without having to spend days researching the specification, and that's what this package aims to do.

### Smart NFC

The initial purpose of this framework was to power the WiFi records in my recent app, Smart NFC. It is a powerful app that can read, write, and interact with all kinds of WiFi tags and records.

Feel free to check out it out!
[Download Smart NFC on the App Store](https://apps.apple.com/us/app/smart-nfc/id1470146079)
