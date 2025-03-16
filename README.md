# NetStatusPackage

**NetStatusPackage** is a Swift package that helps you monitor the network connection status in your iOS application. It uses `NWPathMonitor` from the `Network` framework to provide real-time network status updates and gives you access to information such as connection status, available interfaces, and whether the network is expensive (e.g., cellular data).

## Features

- Monitor network connectivity in real time.
- Detect available network interfaces (Wi-Fi, Cellular, etc.).
- Detect if the network is expensive (cellular data).
- Callbacks for network status changes.

## Installation

You can add **NetStatusPackage** to your project using Swift Package Manager (SPM). 

### Steps to Add NetStatusPackage to Your Project:

1. Open your Xcode project.
2. Go to **File** > **Swift Packages** > **Add Package Dependency**.
3. Enter the URL of the repository:  
   `https://github.com/dev-sjagtap/NetStatusPackage`
4. Select the version (or branch) you want to use, and then click **Next**.
5. Choose the appropriate target to add the package to.

## Usage

### Importing the Package

To use the `NetStatus` class, import the package in your Swift file:

```swift
import NetStatusPackage

let networkStatus = NetStatus.shared
networkStatus.startMonitoring()

networkStatus.netStatusChangeHandler = {
    if networkStatus.isConnected {
        print("Network is connected")
    } else {
        print("Network is not connected")
    }
}

if networkStatus.isConnected {
    print("Network is connected")
}

if let interfaceType = networkStatus.interfaceType {
    print("Network is using: \(interfaceType)")
}

if networkStatus.isExpensive {
    print("The network connection is expensive (cellular data).")
}
