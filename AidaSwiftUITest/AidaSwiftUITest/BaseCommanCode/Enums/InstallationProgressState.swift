//
//  InstallationProgressState.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 03/03/25.
//

import Foundation

//MARK: - PROGRESS PROTOCOL
public protocol ProgressState {
    var title: String { get }
    var subTitle: String { get }
    var icon: String { get }
}

//MARK: -
//MARK: - INSTALLATION PROGRESS STATE
public enum InstallationProgressState: Int, ProgressState, Codable, CaseIterable {
    case initializing               // Starting the installation process
    case checkingSpace              // Checking for sufficient storage space
    case insufficientSpace          // Insufficient space available
    case deletingExistingWatchface  // Deleting an existing watchface to free up space
    case downloadingWatchface       // Downloading the watchface from the cloud
    case transferringWatchfaceFile  // Transferring the watchface file to the device
    case activatingWatchface        // Setting the watchface as the current one
    case activated                  // Watchface is now active
    
    ///title
    public var title: String {
        let rawTitle: String
        switch self {
        case .initializing: rawTitle = .localized(.idoWFInitializing)
        case .checkingSpace: rawTitle = .localized(.idoWFCheckingSpace)
        case .insufficientSpace: rawTitle = .localized(.idoWFCleanupSpace)
        case .deletingExistingWatchface: rawTitle = .localized(.idoWFCleanupSpace)
        case .downloadingWatchface: rawTitle = .localized(.idoWFDownloading)
        case .transferringWatchfaceFile: rawTitle = .localized(.idoWFTransferring)
        case .activatingWatchface: rawTitle = .localized(.idoWFActivating)
        case .activated: rawTitle = .localized(.idoWFInstalled)
        }
        
        return rawTitle.replacingOccurrences(of: "\\.*$", with: "", options: .regularExpression)
    }
    
    //Subtitle
    public var subTitle: String {
        switch self {
        case .initializing: return "Preparing installation"
        case .checkingSpace: return "Checking available storage"
        case .insufficientSpace: return "Not enough space! Free up storage"
        case .deletingExistingWatchface: return "Removing old watchface"
        case .downloadingWatchface: return "Downloading new watchface"
        case .transferringWatchfaceFile: return "Sending file to your device"
        case .activatingWatchface: return "Finalizing installation"
        case .activated: return "Installation complete!"
        }
    }
    
    ///Icon if needed
    public var icon: String {
        switch self {
        case .initializing: return "🔄"
        case .checkingSpace: return "📦"
        case .insufficientSpace: return "⚠️"
        case .deletingExistingWatchface: return "🗑"
        case .downloadingWatchface: return "⬇️"
        case .transferringWatchfaceFile: return "📤"
        case .activatingWatchface: return "⚡"
        case .activated: return "✅"
        }
    }
}
