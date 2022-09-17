//
//  HealthBiometricAuthorizer.swift
//  Health
//
//  Created by Kelvin Kosbab on 4/2/22.
//

import Foundation
import HealthKit
import Core

// MARK: - HealthBiometricAuthorizer

/// Responsible for providing APIs to determine the authorization status for health biometrics from HealthKit.
@available(macOS 13.0, *)
public struct HealthBiometricAuthorizer {
    
    let authorizor: HealthKitAuthorizor
    let logger: CoreLogger
    
    public init() {
        self.init(
            authorizor: HKHealthStore()
        )
    }
    
    public init(
        authorizor: HealthKitAuthorizor,
        logger: CoreLogger = Logger(subsystem: "HealthStore", category: "HealthBiometricAuthorizer")
    ) {
        self.authorizor = authorizor
        self.logger = logger
    }
    
    // MARK: - Get Authorization Status for Health Data
    
    /// Defines scenarios where the user would or would not not be prompted for authorization of health biometric data.
    public enum RequestStatusForAuthorization {
        
        /// Defines a scenario where the user would be prompted for authorization.
        case wouldPrompt
        
        /// Defines a scenario where the user would not be prompted for authorization.
        case wouldNotPrompt
    }
    
    /// Applications may call this method to determine whether the user would be prompted for authorization if
    /// the same collections of types are passed to requestAuthorizationToShareTypes:readTypes:completion:.
    ///
    /// This determination is performed asynchronously and its completion will be executed on an arbitrary
    /// background queue.
    ///
    /// - Returns a value indicating whether authorization should be requested or not.
    func getRequestStatusForAuthorization(
        biometrics: [CodableHealthBiometric]
    ) async throws -> RequestStatusForAuthorization {
        
        // Returns a Boolean value that indicates whether HealthKit is available on this device.
        //
        // - HealthKit is not available on iPad.
        guard self.authorizor.isHealthDataAvailable else {
            self.logger.info("Health data not available")
            return .wouldNotPrompt
        }
        
        // Prepare health data types to request status for.
        var typesToRead: Set<HKObjectType> = Set()
        for biometric in biometrics {
            typesToRead.insert(biometric.sampleType)
        }
        
        // Request authorization status
        let status  = try await self.authorizor.getRequestStatusForAuthorization(
            toShare: [],
            read: typesToRead
        )
        
        switch status {
        case .shouldRequest, .unknown:
            return .wouldPrompt
        case .unnecessary:
            return .wouldNotPrompt
        @unknown default:
            throw Error.unsupportedRequestStatusForAuthorizationStatus
        }
    }
    
    // MARK: - Request Authorization for Health Data
    
    /// Before attempting to execute queries or save objects, the application should first request authorization
    /// from the user to read and share every type of object for which the application may require access.
    ///
    /// The request is performed asynchronously and its completion will be executed on an arbitrary background
    /// queue after the user has responded.  If the user has already chosen whether to grant the application
    /// access to all of the types provided, then the completion will be called without prompting the user.
    ///
    /// The success parameter of the completion indicates whether prompting the user, if necessary, completed
    /// successfully and was not cancelled by the user.  It does NOT indicate whether the application was
    /// granted authorization.
    ///
    /// To customize the messages displayed on the authorization sheet, set the following keys in your app's
    /// Info.plist file. Set the NSHealthShareUsageDescription key to customize the message for reading data.
    /// Set the NSHealthUpdateUsageDescription key to customize the message for writing data.
    func requestAuthorization(
        biometrics: [CodableHealthBiometric]
    ) async throws {
        
        // Returns a Boolean value that indicates whether HealthKit is available on this device.
        //
        // - HealthKit is not available on iPad.
        guard self.authorizor.isHealthDataAvailable else {
            self.logger.info("Health data not available")
            return
        }

        // Prepare health data types to request.
        var typesToRead: Set<HKObjectType> = Set()
        for biometric in biometrics {
            typesToRead.insert(biometric.sampleType)
        }
        
        // Request authorization from HealthKit
        try await self.authorizor.requestAuthorization(
            toShare: [],
            read: typesToRead
        )
    }
    
    // MARK: - Error
    
    enum Error : Swift.Error {
        
        /// Thrown when a certain `HealthBiometric` is unable to be referenced and is unavailable.
        case biometricNotAvailable(_ biometric: CodableHealthBiometric)
        
        /// Thrown when there is a new and unhandled case in the `HKAuthorizationRequestStatus` type.
        case unsupportedRequestStatusForAuthorizationStatus
        
        /// An error thrown if the request for authoration failed.
        case failedToRequestAuthorization
    }
}
