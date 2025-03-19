//
//  CustomWatchfaceItem.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 23/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

public struct CustomWatchfaceItem: Hashable, Codable, Equatable, Identifiable {
    // MARK: - Properties
    ///custom_watchtype_createdAtTimestamp
    public private(set) var id: String = ""
    public private(set) var photoSourceType: Watchface.Custom.PhotoSourceType = .unknown
    ///time Color or TextColor
    public private(set) var timeColor: Watchface.Custom.TextColor = .default
    public private(set) var widgetIconColor: Watchface.Custom.TextColor = .default
    public private(set) var widgetNumColor: Watchface.Custom.TextColor = .default
    public private(set) var textLocation: Watchface.Custom.TextLocation = .default
    public private(set) var watchType: SmartWatchType = .v3
    public private(set) var isFavorite: Bool = false
    public private(set) var createdAt: Date = Date()
    public private(set) var updatedAt: Date = Date()
    public private(set) var setAsCurrentAt: Date = Date()
}

// MARK: - COMPUTED PROPERTY
extension CustomWatchfaceItem {
    ///Return file name without extension
    ///custom_watchtype_createdAtTimestamp : custom_v2max_6723732232323
    public var fileName: String {
        return id
    }
    
    ///Return file name with extension: custom_v2max_6723732232323.png
    public var fileNameWithExt: String {
        return "\(id).\(Watchface.MediaFormat.png.rawValue)"
    }
    
    public var localFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return documentsDirectory.appendingPathComponent(self.fileNameWithExt)
    }
    
    ///This will return final file url that will transfer to watch from temp directory.
    ///It will be the file name that supported by watch: Ex. FOR GTX12: ``custom1``, GT01 & ID207: ``wallpaper.z``
    public var watchSupportedFileURL: URL? {
        guard let wallpaperName = Watchface.Custom.DefaultWallpaper.name(for: watchType) else {
            return nil
        }
        
        return FileManager.default.temporaryDirectory.appendingPathComponent(wallpaperName.rawValue)
    }
}

// Format: custom_watchtype_createdAtTimestamp
// MARK: - INIT & GENERATE ID
extension CustomWatchfaceItem {
    ///#NOTE: ``Use this method create method
    ///This method will create new item with `default` settings and return.
    init(watchType: SmartWatchType, createDate: Date = Date()) {
        self.id = generateId(watchType: watchType, createDate: createDate)
        self.watchType = watchType
        self.createdAt = createDate
    }
    
    ///custom_watchtype_createdAtTimestamp
    private func generateId(watchType: SmartWatchType, createDate: Date) -> String {
        ///We use milliseconds for Higher Precision: Reduces the risk of collisions
        return "custom_\(watchType.codeName.localizedLowercase)_\(Int(createDate.timeIntervalSince1970 * 1000))"
    }
}

// MARK: - Update Properties Method
extension CustomWatchfaceItem {
    public mutating func update(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
    
    public mutating func update(photoSourceType: Watchface.Custom.PhotoSourceType) {
        self.photoSourceType = photoSourceType
        self.updatedAt = Date()
    }
    
    public mutating func update(setAsCurrentAt: Date = Date()) {
        self.setAsCurrentAt = setAsCurrentAt
        self.updatedAt = setAsCurrentAt
    }
    
    public mutating func update(timeColor: Watchface.Custom.TextColor) {
        self.timeColor = timeColor
        self.widgetIconColor = timeColor
        self.widgetNumColor = timeColor
        self.updatedAt = Date()
    }
    
    public mutating func update(textLocation: Watchface.Custom.TextLocation) {
        self.textLocation = textLocation
        self.updatedAt = Date()
    }
}
