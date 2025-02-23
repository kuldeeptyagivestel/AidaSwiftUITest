//
//  CloudStorageURLService.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

//MARK: -
//MARK: - Private CloudStorageURLService
// Service class for login and signup, forgot password services.
public class CloudStorageURLService: NSObject {
    // Default base URL for CRM Cognito
    #if TEST
    private var baseURL: String = CloudStorageDefaultURL.test
    #else
    private var baseURL: String = CloudStorageDefaultURL.prod
    #endif
    
    public static let shared = CloudStorageURLService()
    
    // Define the allowed character set globally if possible. Create a character set that excludes "/"
    private let allowedCharacterSet = CharacterSet.urlPathAllowed.subtracting(CharacterSet(charactersIn: "/"))
    
    //MARK: Lifecycle methods
    override init() {
        super.init()
    }
    
    deinit {

    }
}

extension CloudStorageURLService {
    public func initialize() {
        ///Dummy method to initialise the object.
    }
    
    /// Generates a file URL String dynamically using the extracted baseURL.
    public func generateURLPath(for filePath: String) -> String? {
        // Perform encoding once using the pre-defined allowedCharacterSet
        guard !filePath.isEmpty, let encodedPath = filePath.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else {
            print("filePath is invalidfilePath is invalid. ")
            return nil
        }
            
        return "\(baseURL)/o/\(encodedPath)?alt=media"
    }
    
    /// Generates a file URL dynamically using the extracted baseURL.
    public func generateURL(for filePath: String) -> URL? {
        // Perform encoding using the pre-defined allowedCharacterSet
        guard let path = generateURLPath(for: filePath) else {
            print("filePath is invalid.")
            return nil
        }

        //Create the complete URL string and Return the URL directly using the string constructor
        return URL(string: path)
    }
}
