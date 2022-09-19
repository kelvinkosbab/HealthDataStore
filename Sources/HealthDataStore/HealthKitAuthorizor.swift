//
//  HealthKitAuthorizor.swift
//  Health
//
//  Created by Kelvin Kosbab on 4/15/22.
//

import Foundation
import HealthKit
import Core

// MARK: - HealthKitAuthorizor

@available(macOS 13.0, *)
public protocol HealthKitAuthorizor : HealthKitSupported {
    
    /// Applications may call this method to determine whether the user would be prompted for authorization if
    /// the same collections of types are passed to requestAuthorizationToShareTypes:readTypes:completion:.
    /// This determination is performed asynchronously and its completion will be executed on an arbitrary
    /// background queue.
    func getRequestStatusForAuthorization(
        toShare typesToShare: Set<HKSampleType>,
        read typesToRead: Set<HKObjectType>
    ) async throws -> HKAuthorizationRequestStatus
    
    /// Before attempting to execute queries or save objects, the application should first request authorization
    /// from the user to read and share every type of object for which the application may require access.
    ///
    /// The request is performed asynchronously and its completion will be executed on an arbitrary background
    /// queue after the user has responded.  If the user has already chosen whether to grant the application
    /// access to all of the types provided, then the completion will be called without prompting the user.
    /// The success parameter of the completion indicates whether prompting the user, if necessary, completed
    /// successfully and was not cancelled by the user.  It does NOT indicate whether the application was
    /// granted authorization.
    ///
    /// To customize the messages displayed on the authorization sheet, set the following keys in your app's
    /// Info.plist file. Set the NSHealthShareUsageDescription key to customize the message for reading data.
    /// Set the NSHealthUpdateUsageDescription key to customize the message for writing data.
    ///
    /// - Warning: You must set the usage keys, or your app will crash when you request authorization.
    /// For projects created using Xcode 13 or later, set these keys in the Target Properties list on the app’s Info tab.
    /// For projects created with Xcode 12 or earlier, set these keys in the apps Info.plist file. For more
    /// information, see Information Property List.
    ///
    /// After users have set the permissions for your app, they can always change them using either the Settings or
    /// the Health app. Your app appears in the Health app’s Sources tab, even if the user didn’t allow permission to
    /// read or share data.
    func requestAuthorization(
        toShare typesToShare: Set<HKSampleType>,
        read typesToRead: Set<HKObjectType>
    ) async throws
}

extension HealthKitAuthorizor {
    
    internal func internalGetRequestStatusForAuthorization<TargetBiometric: Biometric>(
        toShare typesToShare: Set<TargetBiometric>,
        read typesToRead: Set<TargetBiometric>
    ) async throws -> HKAuthorizationRequestStatus {
        let toShare: Set<HKSampleType> = Set(try typesToShare.map { biometric in
            let biometric = try CodableHealthBiometric(identifier: biometric.healthKitIdentifier)
            return biometric.sampleType
        })
        let toRead: Set<HKSampleType> = Set(try typesToRead.map { biometric in
            let biometric = try CodableHealthBiometric(identifier: biometric.healthKitIdentifier)
            return biometric.sampleType
        })
        return try await self.getRequestStatusForAuthorization(toShare: toShare, read: toRead)
    }
    
    internal func internalRequestAuthorization<TargetBiometric: Biometric>(
        toShare typesToShare: Set<TargetBiometric>,
        read typesToRead: Set<TargetBiometric>
    ) async throws {
        let toShare: Set<HKSampleType> = Set(try typesToShare.map { biometric in
            let biometric = try CodableHealthBiometric(identifier: biometric.healthKitIdentifier)
            return biometric.sampleType
        })
        let toRead: Set<HKSampleType> = Set(try typesToRead.map { biometric in
            let biometric = try CodableHealthBiometric(identifier: biometric.healthKitIdentifier)
            return biometric.sampleType
        })
        return try await self.requestAuthorization(toShare: toShare, read: toRead)
    }
}

// MARK: - Error

/// Errors thrown when authorizing the status of a given biometric.
enum HealthKitAuthorizorError : Swift.Error {
    
    /// Thrown when a health data is not available on the device.
    case healthDataNotAvailable
    
    /// Thrown when there is a new and unhandled case in the `HKAuthorizationRequestStatus` type.
    case unsupportedRequestStatusForAuthorizationStatus
    
    /// An error thrown if the request for authoration failed.
    case failedToRequestAuthorization
}

// MARK: - HKHealthStore

@available(macOS 13.0, *)
extension HKHealthStore : HealthKitAuthorizor {
    
    public func getRequestStatusForAuthorization(
        toShare typesToShare: Set<HKSampleType>,
        read typesToRead: Set<HKObjectType>
    ) async throws -> HKAuthorizationRequestStatus {
        try await withCheckedThrowingContinuation { continuation in
            
            guard self.isHealthDataAvailable else {
                continuation.resume(throwing: HealthKitAuthorizorError.healthDataNotAvailable)
                return
            }
            
            self.getRequestStatusForAuthorization(
                toShare: typesToShare,
                read: typesToRead
            ) { status, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: status)
                }
            }
        }
    }
    
    public func requestAuthorization(
        toShare typesToShare: Set<HKSampleType>,
        read typesToRead: Set<HKObjectType>
    ) async throws {
        try await withCheckedThrowingVoidContinuation { continuation in
            
            guard self.isHealthDataAvailable else {
                continuation.resume(throwing: HealthKitAuthorizorError.healthDataNotAvailable)
                return
            }
            
            self.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if !success {
                    continuation.resume(throwing: HealthKitAuthorizorError.failedToRequestAuthorization)
                } else {
                    continuation.resume()
                }
            }
        }
    }

}
