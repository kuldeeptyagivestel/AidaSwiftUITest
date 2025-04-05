//
//  InstallationProgressState.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 03/03/25.
//

import Foundation

//MARK: - PROGRESS STATE PROTOCOL
public protocol ProgressState: Equatable, CaseIterable {
    var title: String { get }
    var subTitle: String { get }
    var icon: String { get }
    var progress: Double? { get }  // Optional for states with progress tracking
}

//MARK: - GENERALIZED INSTALLATION STATE ENUM
public enum InstallationProgressState: ProgressState {
    case started
    case initializing
    case checkingSpace
    case insufficientSpace
    case deletingExistingData
    case downloading(progress: Double)  // For watchface, firmware, etc.
    case downloadComplete
    case transferring(progress: Double) // For watchface, firmware, etc.
    case transferringComplete
    case installing(progress: Double)   // For watchface, firmware, etc.
    case installationComplete
    case activating                    // Activating watchface, firmware, etc.
    case completed
    case failed(error: AppCustomError)   // Failure state for better error handling
    
    public var title: String {
        switch self {
        case .started: return .localized(.starting)
        case .initializing: return .localized(.preparingInstallation)
        case .checkingSpace: return .localized(.checkingAvailableStorage)
        case .insufficientSpace: return .localized(.notEnoughSpace)
        case .deletingExistingData: return .localized(.cleaningUpSpace)
        case .downloading: return .localized(.downloadingFile)
        case .downloadComplete: return .localized(.downloadComplete)
        case .transferring: return .localized(.transferring)
        case .transferringComplete: return .localized(.transferComplete)
        case .installing: return .localized(.installing)
        case .installationComplete: return .localized(.installationFinished)
        case .activating: return .localized(.activating)
        case .completed: return .localized(.installationSuccessful)
        case .failed: return .localized(.installationFailed)
        }
    }

    public var subTitle: String {
        switch self {
        case .started: return .localized(.initiatingProcess)
        case .initializing: return .localized(.gettingReadyToInstall)
        case .checkingSpace: return .localized(.verifyingAvailableStorage)
        case .insufficientSpace: return .localized(.insufficientSpace)
        case .deletingExistingData: return .localized(.clearingOutdatedFiles)
        case .downloading(let progress): return String(format: .localized(.downloadingProgress), Int(progress * 100))
        case .downloadComplete: return .localized(.downloadSuccessful)
        case .transferring(let progress): return String(format: .localized(.transferringProgress), Int(progress * 100))
        case .transferringComplete: return .localized(.transferSuccessful)
        case .installing(let progress): return String(format: .localized(.installingProgress), Int(progress * 100))
        case .installationComplete: return .localized(.installationComplete)
        case .activating: return .localized(.activatingDevice)
        case .completed: return .localized(.allSetEnjoy)
        case .failed: return .localized(.failedWithError)
        }
    }

    public var icon: String {
        switch self {
        case .started: return "🚀"
        case .initializing: return "🔄"
        case .checkingSpace: return "📦"
        case .insufficientSpace: return "⚠️"
        case .deletingExistingData: return "🗑"
        case .downloading: return "⬇️"
        case .downloadComplete: return "✅"
        case .transferring: return "📤"
        case .transferringComplete: return "✅"
        case .installing: return "⚙️"
        case .installationComplete: return "✅"
        case .activating: return "⚡"
        case .completed: return "🎯"
        case .failed: return "❌"
        }
    }

    public var progress: Double? {
        switch self {
        case .downloading(let progress), .transferring(let progress), .installing(let progress):
            return progress
        default: return nil
        }
    }
}

//MARK: - CASE ITERABLE PROTOCOL
extension InstallationProgressState {
    public static var allCases: [InstallationProgressState] = [
        .started,
        .initializing,
        .checkingSpace,
        .insufficientSpace,
        .deletingExistingData,
        .downloading(progress: 0),       // Placeholder for progress cases
        .downloadComplete,
        .transferring(progress: 0),      // Placeholder for progress cases
        .transferringComplete,
        .installing(progress: 0),        // Placeholder for progress cases
        .installationComplete,
        .activating,
        .completed,
        .failed(error: .unknown(type: .recoverable, reason: .localized(.unknown_error)))    // Placeholder for error cases
    ]
}

//MARK: - EQUATABLE PROTOCOL
extension InstallationProgressState {
    public static func == (lhs: InstallationProgressState, rhs: InstallationProgressState) -> Bool {
        switch (lhs, rhs) {
        case (.started, .started),
             (.initializing, .initializing),
             (.checkingSpace, .checkingSpace),
             (.insufficientSpace, .insufficientSpace),
             (.deletingExistingData, .deletingExistingData),
             (.downloadComplete, .downloadComplete),
             (.transferringComplete, .transferringComplete),
             (.installationComplete, .installationComplete),
             (.activating, .activating),
             (.completed, .completed):
            return true

        case (.downloading(let lhsProgress), .downloading(let rhsProgress)),
             (.transferring(let lhsProgress), .transferring(let rhsProgress)),
             (.installing(let lhsProgress), .installing(let rhsProgress)):
            return lhsProgress == rhsProgress

        case (.failed, .failed):
            return true

        default:
            return false
        }
    }
}
