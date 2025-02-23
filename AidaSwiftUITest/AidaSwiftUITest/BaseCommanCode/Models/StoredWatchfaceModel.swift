//
//  WatchDialInfoItemModel.swift
//  AIDAApp
//
//  Created by Aradhya Tyagi on 02/12/24.
//  Copyright © 2024 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

// MARK: - Unified StoredWatchfaceModel
/// A struct representing the configuration for watch dial information, compatible with both V2 and V3 watches.
/// this is associated with `IDOWatchDialInfoModel.dialArray` and `IDOV3WatchDialInfoModel.dialArray`
/// ``Number of watchfaces that are already in the watch: V2 support: 4 Max, V2 MAX: 4 Max, V3: 6 Max
/**
 #IDOV3WatchDialInfoItemModel for v3
     fileName                  Watch face name                     str (unique identifier)
     operate                     Operation                                  0x00: Query the watch face in use 0x01: Set the watch face 0x02: Delete the watch face
     type                          Dial Type                                    1: Normal dial; 2: Wallpaper dial; 3: Cloud dial
     watchVersion           Dial version number                    Cloud watch face works
     sortNumber             Dial sequence number                int starts at 0
     size                          watch face file size                     int

 #IDOWatchDialInfoItemModel for v2
        fileName                    Watch face name                         str (unique identifier)
    operate                     Operation                                     0x00: Query the watch face in use 0x01: Set the watch face 0x02: Delete the watch face
 */
public struct StoredWatchfaceModel: Codable, Hashable {
    // MARK: - Instance Properties
    /// Unique identifier for the watch face that is in the watch
    ///FOR V2: fileName:  ``CLOUD: cw95.iwf, LOCAL: local_3, Custom: wallpaper.z
    ///FOR V2MAX: fileName:  ``CLOUD: watch123.iwf, watch166.iwf, LOCAL: local_1, Custom: wallpaper.z
    ///FOR V3: fileName:  ``CLOUD: wf_w19, wf_w65, LOCAL: local_1, Custom: custom1
    public private(set) var fileName: String
    /// Operation type: Query, Set, or Delete.
    public private(set) var operation: Watchface.OperationType = .query
    /// Dial type (only applicable for V3 watches).
    /// 1: Normal dial; 2: Wallpaper dial; 3: Cloud dial
    public private(set) var type: Watchface.Source = .unknown
    /// Dial version number (only applicable for V3 watches).
    public private(set) var watchVersion: Int = 0
    /// Dial sequence number (only applicable for V3 watches).
    public private(set) var sortNumber: Int = 0
    /// File size of the watch face (only applicable for V3 watches).
    public private(set) var size: Int = 0
    
    //MARK: COMPUTED PROPERTIES
    ///Return  Watchface file name without extension. for v2 and v2Max fileName is with extension like: , watch123.iwf
    ///FOR V2: fileName:  ``CLOUD: cw95, LOCAL: local_3, Custom: wallpaper
    ///FOR V2MAX: fileName:  ``CLOUD: watch123, watch166, LOCAL: local_1, Custom: wallpaper
    ///FOR V3: fileName:  ``CLOUD: wf_w19, wf_w65, LOCAL: local_1, Custom: custom1
    ///#RETURN: cw95, watch123, wallpaper, local_1, watch166
    public var fileNameWithoutExt: String {
        return fileName.fileName
    }
    
    // MARK: - Initializer
    /// Initializes a new instance of `StoredWatchfaceModel`.
    public init(fileName: String,
                operation: Watchface.OperationType,
                type: Watchface.Source = .unknown,
                watchVersion: Int = 0,
                sortNumber: Int = 0,
                size: Int = 0) {
        self.fileName = fileName
        self.operation = operation
        self.type = type
        self.watchVersion = watchVersion
        self.sortNumber = sortNumber
        self.size = size
    }
}

// MARK: - UPDATE METHODS
extension StoredWatchfaceModel {
    ///Update operation type for set or delete
    public mutating func update(operation: Watchface.OperationType) {
        self.operation = operation
    }
}
