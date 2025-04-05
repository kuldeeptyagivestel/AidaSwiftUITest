//
//  ErrorCode.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 18/05/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

/// Protocol defining the requirements for an error code.
public protocol ErrorCode {
    var description: LocalizationKey { get }  // Description of the error code
    var domain: ErrorDomain { get }           // Error domain associated with the error code
}

/**DeviceConnectionErrorCode to check connection to device or not.*/
public enum DeviceConnectionErrorCode: Int, ErrorCode {
    public typealias RawValue = Int
    public typealias rawValue = Int
    
    // Error cases
    case unknown = 0
    case bluetoothOff = 1
    case bluetoothUnauthorized = 2 //`noOpenAuthorized`:  bluetooth permission is not enabled. So we need to check this and correct this.
    case bluetoothNotSupported = 3
    case bluetoothTimeout = 4
    case deviceDisconnected = 5
    case deviceUnbound = 6
    
    // Error Domain
    public var domain: ErrorDomain {
        return .ido(code: self)
    }
    
    // Convert rawValue to DeviceConnectionErrorCode
    static func from(_ rawValue: Int) -> DeviceConnectionErrorCode {
        return DeviceConnectionErrorCode(rawValue: rawValue) ?? .unknown
    }
    
    // Description for localization
    public var description: LocalizationKey {
        let localizedKey: LocalizationKey
        
        switch self {
        case .unknown:
            localizedKey = .idoSuccess // Unknown error, can be customized as needed
        case .bluetoothOff:
            localizedKey = .device_turnon_bluetooth // Bluetooth is turned off
        case .bluetoothUnauthorized, .bluetoothNotSupported:
            localizedKey = .bluetooth_access_denied_Desc // Bluetooth unauthorized or not supported
        case .bluetoothTimeout:
            localizedKey = .idoBluetoothDisconnect // Bluetooth connection timeout
        case .deviceDisconnected:
            localizedKey = .idoBluetoothDisconnect // Device disconnected
        case .deviceUnbound:
            localizedKey = .watchV2connectionError // Device unbound
        }
        
        return localizedKey
    }
}

/// Enumeration representing the error codes specific to IDO.
public enum IDOErrorCode: Int, ErrorCode {
    public typealias RawValue = Int
    public typealias rawValue = Int
    
    case success = 0
    case unknown = 4
    case notFound = 5
    case notSupported = 6
    case invalidParameter = 7
    case invalidState = 8
    case invalidDataLength = 9
    case invalidFlags = 10
    case invalidData = 11
    case wrongDataSize = 12
    case timeout = 13
    case emptyData = 14 //null or nil
    case forbidden = 15
    case systemBusy = 17
    case batteryTooLow = 18
    case bluetoothDisconnect = 19
    case bluetoothDisconnectTimeout = 20
    case bluetoothDisconnectCurrentOTA = 21
    case bluetoothDisconnectDeviceSyncing = 22
    case unorganizedSpace = 24
    case spaceBeingOrganized = 25
    case bluetoothDisconnected = 1019
    case modelDataError = 1020
    case currentOTA = 1021
    case syncingDeviceError = 1022
    case wrongAuthCode = 1023
    case pairingCancelled = 1024
    case pairingUnknownTimeout = 1025
    case pairingReconnectionFailed = 1026
    case otaReconnectionFailed = 1027
    case fileNotExist = 1028
    case fileTransferFailed = 1029
    case wrongAlarmId = 1030
    case pairingTimeout = 1031
    case configError = 1032
    case dataMigrationError = 1033
    case bluetoothPairingError = 1034
    case deviceNotBound = 1035
    case gpsRunning = 1036
    case syncItemError = 1037
    case transferringFileError = 1038
    case methodDeprecated = 1039
    case wrongAlarmName = 1040
    case encryptedAuthCode = 1041
    case writeDataError = 1042
    case syncDataEmptyError = 1043
    case syncGPSDataEmptyError = 1044
    
    //Return Error code
    public var domain: ErrorDomain {
        return .ido(code: self)
    }
    
    ///Convert IDO Error code to IDOErrorCode
    static func from(_ rawValue: Int) -> IDOErrorCode {
        return IDOErrorCode(rawValue: rawValue) ?? .unknown
    }
    
    ///Return LocalizationKey associated with error
    public var description: LocalizationKey {
        let localizedKey: LocalizationKey
        switch self {
        case .success:
            localizedKey = .idoSuccess
        case .unknown:
            localizedKey = .idoUnknown
        case .notFound:
            localizedKey = .idoNotFound
        case .notSupported:
            localizedKey = .idoNotSupported
        case .invalidParameter:
            localizedKey = .idoInvalidParameter
        case .invalidState:
            localizedKey = .idoInvalidState
        case .invalidDataLength:
            localizedKey = .idoInvalidDataLength
        case .invalidFlags:
            localizedKey = .idoInvalidFlags
        case .invalidData:
            localizedKey = .idoInvalidData
        case .wrongDataSize:
            localizedKey = .idoWrongDataSize
        case .timeout:
            localizedKey = .idoTimeout
        case .emptyData:
            localizedKey = .idoEmptyData
        case .forbidden:
            localizedKey = .idoForbidden
        case .systemBusy:
            localizedKey = .idoSystemBusy
        case .batteryTooLow:
            localizedKey = .idoBatteryTooLow
        case .bluetoothDisconnect:
            localizedKey = .idoBluetoothDisconnect
        case .bluetoothDisconnectTimeout:
            localizedKey = .idoBluetoothDisconnect
        case .bluetoothDisconnectCurrentOTA:
            localizedKey = .idoBluetoothDisconnectCurrentOTA
        case .bluetoothDisconnectDeviceSyncing:
            localizedKey = .idoBluetoothDisconnectDeviceSyncing
        case .unorganizedSpace:
            localizedKey = .idoUnorganizedSpace
        case .spaceBeingOrganized:
            localizedKey = .idoSpaceBeingOrganized
        case .bluetoothDisconnected:
            localizedKey = .device_activate_bluetooth
        case .modelDataError:
            localizedKey = .idoModelDataError
        case .currentOTA:
            localizedKey = .idoCurrentOTA
        case .syncingDeviceError:
            localizedKey = .idoSyncingDeviceError
        case .wrongAuthCode:
            localizedKey = .idoWrongAuthCode
        case .pairingCancelled:
            localizedKey = .idoPairingCancelled
        case .pairingUnknownTimeout:
            localizedKey = .idoPairingUnknownTimeout
        case .pairingReconnectionFailed:
            localizedKey = .idoPairingReconnectionFailed
        case .otaReconnectionFailed:
            localizedKey = .idoOTAReconnectionFailed
        case .fileNotExist:
            localizedKey = .idoFileNotExist
        case .fileTransferFailed:
            localizedKey = .idoFileTransferFailed
        case .wrongAlarmId:
            localizedKey = .idoWrongAlarmId
        case .pairingTimeout:
            localizedKey = .idoPairingTimeout
        case .configError:
            localizedKey = .idoConfigError
        case .dataMigrationError:
            localizedKey = .idoDataMigrationError
        case .bluetoothPairingError:
            localizedKey = .idoBluetoothPairingError
        case .deviceNotBound:
            localizedKey = .idoDeviceNotBound
        case .gpsRunning:
            localizedKey = .idoGPSRunning
        case .syncItemError:
            localizedKey = .idoSyncItemError
        case .transferringFileError:
            localizedKey = .idoTransferringFileError
        case .methodDeprecated:
            localizedKey = .idoMethodDeprecated
        case .wrongAlarmName:
            localizedKey = .idoWrongAlarmName
        case .encryptedAuthCode:
            localizedKey = .idoEncryptedAuthCode
        case .writeDataError:
            localizedKey = .idoWriteDataError
        case .syncDataEmptyError:
            localizedKey = .idoSyncDataEmptyError
        case .syncGPSDataEmptyError:
            localizedKey = .idoSyncGPSDataEmptyError
        }
        
        return localizedKey
    }
}
