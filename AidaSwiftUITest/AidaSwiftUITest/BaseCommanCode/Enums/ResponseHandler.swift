//
//  Handlers.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 18/05/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

/// Enum representing the response of a task.
///
///     - progress: Indicates the progress of the task.
///     - success: Indicates that the task was successful.
///     - failure: Indicates that the task encountered an error.
public enum Response<T: Any> {
    case progress(progress: Double)
    case success(result: T?)
    case failure(error: AppError?)
}

/// Enum representing the response of a task.
///
///     - progress: Indicates the progress of the task.
///     - success: Indicates that the task was successful.
///     - failure: Indicates that the task encountered an error.
public enum CustomResponse<T: Any> {
    case started
    case cached(result: T?)
    case progress(progress: Double)
    case success(result: T?)
    case failure(error: CustomError?)
}

/// Enum representing different states of a synchronization process.
/// - `started`: Indicates the start of the synchronization process.
/// - `inProgress(progress)`: Represents that synchronization is in progress, with the associated progress as a percentage.
/// - `completed(result)`: Indicates successful completion of the synchronization with an associated result of type `T?`.
/// - `noChange`: Represents a state where no change is detected, and there's no need to refresh the UI.
/// - `failed(error)`: Indicates that the synchronization failed with an associated custom error of type `AppCustomError`.
/// The `description` property provides human-readable descriptions for each state,
/// useful for logging or displaying information to the user.
/// - Parameters:
///   - T: The type of result associated with the completion state.
public enum SyncState<T> {
    case started
    case inProgress(progress: Double)
    case completed(result: T?)
    case noChange
    case failed(error: AppCustomError?)

    /// A human-readable description for each synchronization state.
    var description: String {
        switch self {
        case .started:
            return "Sync Started"
        case .inProgress(let progress):
            return "Sync In Progress (\(Int(progress * 100))%)"
        case .completed:
            return "Sync Completed"
        case .noChange:
            return "No Change Detected"
        case .failed(let error):
            return "Sync Failed: \(error?.localizedDescription ?? "unkown Error occurred while print error.")"
        }
    }
}

//MARK: - HANDLERS
/// Typealias for a task handler closure.
///
/// The `ResponseHandler` closure is used to handle the response of a task.
/// It takes a single parameter `response` of type `Response<T>`.
/// The `Response` enum represents the different possible outcomes of a task,
/// such as progress, success, or failure.
///
/// Example Usage:
/// ```
/// let handler: ResponseHandler<User> = { response in
///     switch response {
///     case .progress(let progress):
///         // Handle task progress
///     case .success(let user):
///         // Handle successful task with user data
///     case .failure(let error):
///         // Handle task failure with error
///     }
/// }
/// ```
public typealias ResponseHandler<T: Any> = (_ response: Response<T>) -> ()

public typealias CustomResponseHandler<T: Any> = (_ response: CustomResponse<T>) -> ()

public typealias CompletionHandler<T: Any> = (_ result: T, AppCustomError?) -> ()

/**
 Typealias for a completion block used in asynchronous operations.

 - Parameters:
    - success: A boolean value indicating the success or failure of the operation.
    - result: An optional value representing the result of the operation.
    - error: An optional `AppError` object indicating the error encountered during the operation, if any.
 
  - Example Usage
    ```
     let completion: Completion<String> = { success, result, error in
         // Handle the completion with the expected String result
         if success {
             if let resultString = result {
                 // Process the resultString
             } else {
                 // Handle the case where the result is nil
             }
         } else {
             // Handle the error case
             if let error = error {
                 // Process the error
             }
         }
    }
    ```
*/
public typealias Completion<Result> = (_ success: Bool, _ result: Result?, _ error: AppError?) -> ()
