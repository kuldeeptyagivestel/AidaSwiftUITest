//
//  CloudWatchfaceItem.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 14/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

public struct CloudWatchfaceItem: Hashable, Codable, Equatable, Identifiable {
    // MARK: Properties
    public private(set) var id: String = ""
    private var titleLocalized: [String: String] = [:]
    private var descLocalized: [String: String] = [:]
    public private(set) var source: Watchface.Source = .cloud
    public private(set) var smartWatchType: SmartWatchType = .v3
    public private(set) var animationType: Watchface.AnimationType = .static
    public private(set) var mediaFormat: Watchface.MediaFormat = .png
    public private(set) var fileRelativeUrl: String? = ""
    public private(set) var previewRelativeUrl: String = ""
    public private(set) var updatedAt: Date = Date()
    public private(set) var rating: Float = 0.0
    public private(set) var price: Float = 0.0
    public private(set) var currency: String = "$"
    public private(set) var categories: [String] = []
    public private(set) var tags: [String] = []
    public private(set) var isDownloaded: Bool = false
}

//MARK: - INIT Method
extension CloudWatchfaceItem {
    public init(
        id: String,
        titleLocalized: [String: String],
        descLocalized: [String: String],
        source: Watchface.Source,
        smartWatchType: SmartWatchType,
        animationType: Watchface.AnimationType,
        mediaFormat: Watchface.MediaFormat,
        fileRelativeUrl: String,
        previewRelativeUrl: String,
        updatedAt: Date,
        rating: Float,
        price: Float,
        currency: String,
        categories: [String],
        tags: [String],
        isDownloaded: Bool
    ) {
        self.id = id
        self.titleLocalized = titleLocalized
        self.descLocalized = descLocalized
        self.source = source
        self.smartWatchType = smartWatchType
        self.animationType = animationType
        self.mediaFormat = mediaFormat
        self.fileRelativeUrl = fileRelativeUrl
        self.previewRelativeUrl = previewRelativeUrl
        self.updatedAt = updatedAt
        self.rating = rating
        self.price = price
        self.currency = currency
        self.categories = categories
        self.tags = tags
        self.isDownloaded = isDownloaded
    }
}

//MARK: - COMPUTED PROPERTIES
extension CloudWatchfaceItem {
    //https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w41.gif?alt=media
    public var cloudPreviewURL: URL? {
        guard let url = CloudStorageURLService.shared.generateURL(for: previewRelativeUrl) else {
            return nil
        }
        return url
    }
    
    //https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w41.zip?alt=media
    public var cloudFileURL: URL? {
        guard let fileRelativeUrl, !fileRelativeUrl.isEmpty,
              let url = CloudStorageURLService.shared.generateURL(for: fileRelativeUrl) else {
            return nil
        }
        return url
    }
    
    ///Return Watchface Name that same as come from watch without extension.
    ///``watchface/id207/prod/files/w118.zip -> w118``
    ///``watchface/gtx12/prod/files/wf_w10.watch -> wf_w10``
    ///``watchface/gtx12/prod/images/local_1 -> local_1`` For local wf, there is no file so we extract name from image url
    public var watchfaceName: String {
        //For local watchfaces, fileRelativeUrl will be nil or empty so we need
        guard let fileRelativeUrl, !fileRelativeUrl.isEmpty else {
            return previewRelativeUrl.fileName
        }
        
        return fileRelativeUrl.fileName
    }
    
    ///Return Watchface Name that same as come from watch with extension.
    ///``watchface/id207/prod/files/w118.zip -> w118.zip``
    ///``watchface/gtx12/prod/files/wf_w10.watch -> wf_w10.watch``
    ///``watchface/gtx12/prod/images/local_1 -> local_1`` For local wf, there is no file so we extract name from image url. `No extension`
    public var watchfaceNameWithExt: String {
        //For local watchfaces, fileRelativeUrl will be nil or empty so we need
        guard let fileRelativeUrl, !fileRelativeUrl.isEmpty else {
            return watchfaceName
        }
        
        //"wf_w10.watch"
        return fileRelativeUrl.fileNameWithExtension
    }
    
    ///It will create Local file path for this watchface to download the watchface file.
    ///``watchface_gtx12_prod_files_wf_w10_watch.watch
    ///``watchface_id207_prod_files_w118_zip.zip
    public var localFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first,
                let localFileName = self.localFileNameWithExt else {
            return nil
        }
        
        return documentsDirectory.appendingPathComponent(localFileName)
    }
    
    ///It will create Local file path for this watchface to download the watchface file.
    ///It will be the file name that supported by watch: Ex. FOR GTX12: ``watchface_gtx12_prod_files_wf_w53_gif.watch -> wf_w53.watch``
    public var watchSupportedFileURL: URL? {
        guard let fileRelativeUrl, !fileRelativeUrl.isEmpty else {
            return nil
        }
        
        return FileManager.default.temporaryDirectory.appendingPathComponent(URL(fileURLWithPath: fileRelativeUrl).lastPathComponent)
    }
}

//MARK: - Computed Property
extension CloudWatchfaceItem {
    //MARK: -
    ///FOR GTX12 ``watchface/gtx12/prod/files/wf_w10.watch -> watchface_gtx12_prod_files_wf_w10_watch
    ///FOR ID207: ``watchface/id207/prod/files/w118.zip -> watchface_id207_prod_files_w118_zip``
    ///FOR GT01: ``watchface/gt01/prod/files/cw15.zip -> watchface_gt01_prod_files_cw15_zip``
    ///FOR GT01: ``watchface/gt01/prod/files/w170.zip -> watchface_gt01_prod_files_w170_zip``
    ///FOR GT01: ``watchface/gt01/prod/files/gt51.zip -> watchface_gt01_prod_files_gt51_zip``
    ///Return Downloaded watchface file name with file extension.
    public var localFileNameWithExt: String? {
        /// Use `localFileName` to get the sanitized file name without the extension.
        guard let fileRelativeUrl, !fileRelativeUrl.isEmpty, let baseName = localFileName else { return nil }
        
        /// Extract the file extension.
        let fileExtension = fileRelativeUrl.fileExtension
        
        /// Append the file extension if it exists.
        return fileExtension.isEmpty ? baseName : "\(baseName).\(fileExtension)"
    }
    
    public var localFileName: String? {
        ///For local watchfaces, `fileRelativeUrl` will be empty or nil.
        guard let fileRelativeUrl, !fileRelativeUrl.isEmpty else { return nil }
        
        // Define the character replacements for sanitization
        let sanitized = fileRelativeUrl
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "%", with: "_")
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: "?", with: "_")
            .replacingOccurrences(of: "&", with: "_")
            .replacingOccurrences(of: "=", with: "_")
            .replacingOccurrences(of: "#", with: "_")
        
        // Truncate to the last 100 characters if sanitized string is too long
        let maxLength = 100 // Maximum length for the ID
        if sanitized.count > maxLength {
            return String(sanitized.suffix(maxLength))
        }
        
        // Return the sanitized string for shorter paths
        return sanitized
    }
    
    /// Returns the file extension from `fileRelativeUrl`, if any.
    /// FOR GTX12: `watchface/gtx12/prod/images/wf_w10.watch -> watch`
    /// FOR ID207: `watchface/id207/prod/images/w118.zip -> zip`
    public var fileExtension: String? {
        /// For local watchfaces, `fileRelativeUrl` will be empty or nil.
        guard let fileRelativeUrl, !fileRelativeUrl.isEmpty else { return nil }

        // Extract and return the file extension
        return fileRelativeUrl.fileExtension
    }
}

//MARK: - Update Properties Method
extension CloudWatchfaceItem {
    public mutating func update(isDownloaded: Bool) {
        self.isDownloaded = true
    }
}

// MARK: - Firebase Model to Item
extension CloudWatchfaceItem {
    init(_ fromFirebaseModel: FirebaseWatchface) {
        self.id = fromFirebaseModel.id
        self.titleLocalized = fromFirebaseModel.titleLocalized
        self.descLocalized = fromFirebaseModel.descLocalized
        self.source = fromFirebaseModel.source
        self.smartWatchType = fromFirebaseModel.smartWatchType
        self.animationType = fromFirebaseModel.animationType
        self.mediaFormat = fromFirebaseModel.mediaFormat
        self.fileRelativeUrl = fromFirebaseModel.fileRelativeUrl
        self.previewRelativeUrl = fromFirebaseModel.previewRelativeUrl
        self.updatedAt = fromFirebaseModel.updatedAt
        self.rating = fromFirebaseModel.rating
        self.price = fromFirebaseModel.price
        self.currency = fromFirebaseModel.currency
        self.categories = fromFirebaseModel.categories
        self.tags = fromFirebaseModel.tags
        self.isDownloaded = false // Default value for Firebase models
    }
}

// MARK: - LOCALIZATION EXTENSION
extension CloudWatchfaceItem {
    /// Get localized title based on user's language preference.
    public var localizedTitle: String {
        return localizedTitle()
    }
    
    /// Get localized title based on user's language preference.
    public var localizedDesc: String {
        return localizedDesc()
    }
    
    /// Get localized title based on user's language preference.
    public func localizedTitle(for language: LocalizedLanguage = LocalizedLanguage.userLocale) -> String {
        return titleLocalized[language.designator] ?? titleLocalized[LocalizedLanguage.english.designator] ?? ""
    }

    /// Get localized description based on user's language preference.
    public func localizedDesc(for language: LocalizedLanguage = LocalizedLanguage.userLocale) -> String {
        return descLocalized[language.designator] ?? descLocalized[LocalizedLanguage.english.designator] ?? ""
    }
}

// MARK: - LOCALIZATION EXTENSION
extension CloudWatchfaceItem {
    // Method to set the dictionary
    private func toLocalisedString(dictionary: [String: String]) -> String {
        if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
            return String(data: jsonData, encoding: .utf8) ?? ""
        }
        
        return ""
    }
    
    // Method to get the dictionary
    private func toLocalisedDict(textJSON: String) -> [String: String] {
        if let data = textJSON.data(using: .utf8),
           let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
            return dictionary
        }
        return [:]
    }
}

// MARK: -
// MARK: - WatchfaceDetailsItem
/// Combines metadata of a watchface available in the cloud with details of the installed watchface on the device.
public struct WatchfaceDetailsItem {
    public private(set) var installedWatchfaceModel: StoredWatchfaceModel?
    public private(set) var cloudWatchface: CloudWatchfaceItem
    
    ///Update localFilePath after downloading the file.
    public mutating func update(isDownloaded: Bool) {
        self.cloudWatchface.update(isDownloaded: isDownloaded)
    }
}

//MARK: -
//MARK: - MOCKING
extension CloudWatchfaceItem {
    // Method to read CloudWatchfaces.json and return models
    public static var mock: [CloudWatchfaceItem] {
        let watchfaces = FirebaseWatchface.mock.map { fbWatchface in
            CloudWatchfaceItem(fbWatchface)
        }
        
        return watchfaces
    }
    
    // Method to read CloudWatchfaces.json and return model
    public static var mockModel: CloudWatchfaceItem {
        if let model = FirebaseWatchface.mock.first.map({ CloudWatchfaceItem($0) }) {
            return model
        }
        return CloudWatchfaceItem(id: "v3_wf_w41")
    }
}

//MARK: -
//MARK: - UNIT TESTS
extension CloudWatchfaceItem {
    public func test() {
        let cloudPreviewURL             = self.cloudPreviewURL
        let cloudFileURL                = self.cloudFileURL
        let watchfaceName               = self.watchfaceName
        let watchfaceNameWithExt        = self.watchfaceNameWithExt
        let localFileURL                = self.localFileURL
        let watchSupportedFileURL       = self.watchSupportedFileURL
        let localFileNameWithExt        = self.localFileNameWithExt
        let localFileName               = self.localFileName
        let fileExtension               = self.fileExtension
        
        Swift.print("\nℹ️____________PRINT_\(id.capitalized)______________🛠️")
        Swift.print("\(id): CloudPreviewURL          : \( cloudPreviewURL?.absoluteString          ?? "" )")
        Swift.print("\(id): CloudFileURL             : \( cloudFileURL?.absoluteString             ?? "" )")
        Swift.print("\(id): watchfaceName            : \( watchfaceName                                  )")
        Swift.print("\(id): watchfaceNameWithExt     : \( watchfaceNameWithExt                           )")
        Swift.print("\(id): localFileURL             : \( localFileURL?.absoluteString             ?? "" )")
        Swift.print("\(id): watchSupportedFileURL    : \( watchSupportedFileURL?.absoluteString    ?? "" )")
        Swift.print("\(id): localFileNameWithExt     : \( localFileNameWithExt                     ?? "" )")
        Swift.print("\(id): localFileName            : \( localFileName                            ?? "" )")
        Swift.print("\(id): fileExtension            : \( fileExtension                            ?? "" )")
        Swift.print("ℹ️____________PRINT_\(id.capitalized)______________🛠️\n")
    }
    
//    CloudWatchfaceProvider.watchface(for: "v3_local_1")?.test()
//    CloudWatchfaceProvider.watchface(for: "v3_wf_w1")?.test()
//    CloudWatchfaceProvider.watchface(for: "v2Max_local_1")?.test()
//    CloudWatchfaceProvider.watchface(for: "v2Max_w1")?.test()
//    CloudWatchfaceProvider.watchface(for: "v2Max_w67")?.test()
//    
//    CloudWatchfaceProvider.watchface(for: "v2_local_1")?.test()
//    CloudWatchfaceProvider.watchface(for: "v2_cw03")?.test()
//    CloudWatchfaceProvider.watchface(for: "v2_cw99")?.test()
//    CloudWatchfaceProvider.watchface(for: "v2_w100")?.test()
//    CloudWatchfaceProvider.watchface(for: "v2_gt33")?.test()
    
    /*
     ℹ️____________PRINT_V3_Local_1______________🛠️
     v3_local_1: CloudPreviewURL          : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Flocal_1.png?alt=media
     v3_local_1: CloudFileURL             :
     v3_local_1: watchfaceName            : local_1
     v3_local_1: watchfaceNameWithExt     : local_1
     v3_local_1: localFileURL             :
     v3_local_1: watchSupportedFileURL    :
     v3_local_1: localFileNameWithExt     :
     v3_local_1: localFileName            :
     v3_local_1: fileExtension            :
     ℹ️____________PRINT_V3_Local_1______________🛠️


     ℹ️____________PRINT_V3_Wf_W1______________🛠️
     v3_wf_w1: CloudPreviewURL          : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w1.png?alt=media
     v3_wf_w1: CloudFileURL             : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Ffiles%2Fwf_w1.watch?alt=media
     v3_wf_w1: watchfaceName            : wf_w1
     v3_wf_w1: watchfaceNameWithExt     : wf_w1.watch
     v3_wf_w1: localFileURL             : file:///var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/Documents/watchface_gtx12_prod_files_wf_w1_watch.watch
     v3_wf_w1: watchSupportedFileURL    : file:///private/var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/tmp/wf_w1.watch
     v3_wf_w1: localFileNameWithExt     : watchface_gtx12_prod_files_wf_w1_watch.watch
     v3_wf_w1: localFileName            : watchface_gtx12_prod_files_wf_w1_watch
     v3_wf_w1: fileExtension            : watch
     ℹ️____________PRINT_V3_Wf_W1______________🛠️


     ℹ️____________PRINT_V2Max_Local_1______________🛠️
     v2Max_local_1: CloudPreviewURL          : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fid207%2Fprod%2Fimages%2Flocal_1.png?alt=media
     v2Max_local_1: CloudFileURL             :
     v2Max_local_1: watchfaceName            : local_1
     v2Max_local_1: watchfaceNameWithExt     : local_1
     v2Max_local_1: localFileURL             :
     v2Max_local_1: watchSupportedFileURL    :
     v2Max_local_1: localFileNameWithExt     :
     v2Max_local_1: localFileName            :
     v2Max_local_1: fileExtension            :
     ℹ️____________PRINT_V2Max_Local_1______________🛠️


     ℹ️____________PRINT_V2Max_W1______________🛠️
     v2Max_w1: CloudPreviewURL          : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fid207%2Fprod%2Fimages%2Fwatch1.png?alt=media
     v2Max_w1: CloudFileURL             : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fid207%2Fprod%2Ffiles%2Fw1.zip?alt=media
     v2Max_w1: watchfaceName            : w1
     v2Max_w1: watchfaceNameWithExt     : w1.zip
     v2Max_w1: localFileURL             : file:///var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/Documents/watchface_id207_prod_files_w1_zip.zip
     v2Max_w1: watchSupportedFileURL    : file:///private/var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/tmp/w1.zip
     v2Max_w1: localFileNameWithExt     : watchface_id207_prod_files_w1_zip.zip
     v2Max_w1: localFileName            : watchface_id207_prod_files_w1_zip
     v2Max_w1: fileExtension            : zip
     ℹ️____________PRINT_V2Max_W1______________🛠️


     ℹ️____________PRINT_V2Max_W67______________🛠️
     v2Max_w67: CloudPreviewURL          : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fid207%2Fprod%2Fimages%2Fwatch67.png?alt=media
     v2Max_w67: CloudFileURL             : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fid207%2Fprod%2Ffiles%2Fw67.zip?alt=media
     v2Max_w67: watchfaceName            : w67
     v2Max_w67: watchfaceNameWithExt     : w67.zip
     v2Max_w67: localFileURL             : file:///var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/Documents/watchface_id207_prod_files_w67_zip.zip
     v2Max_w67: watchSupportedFileURL    : file:///private/var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/tmp/w67.zip
     v2Max_w67: localFileNameWithExt     : watchface_id207_prod_files_w67_zip.zip
     v2Max_w67: localFileName            : watchface_id207_prod_files_w67_zip
     v2Max_w67: fileExtension            : zip
     ℹ️____________PRINT_V2Max_W67______________🛠️


     ℹ️____________PRINT_V2_Local_1______________🛠️
     v2_local_1: CloudPreviewURL          : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgt01%2Fprod%2Fimages%2Flocal_1.png?alt=media
     v2_local_1: CloudFileURL             :
     v2_local_1: watchfaceName            : local_1
     v2_local_1: watchfaceNameWithExt     : local_1
     v2_local_1: localFileURL             :
     v2_local_1: watchSupportedFileURL    :
     v2_local_1: localFileNameWithExt     :
     v2_local_1: localFileName            :
     v2_local_1: fileExtension            :
     ℹ️____________PRINT_V2_Local_1______________🛠️


     ℹ️____________PRINT_V2_Cw03______________🛠️
     v2_cw03: CloudPreviewURL          : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgt01%2Fprod%2Fimages%2Fwatch03.png?alt=media
     v2_cw03: CloudFileURL             : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgt01%2Fprod%2Ffiles%2Fcw03.zip?alt=media
     v2_cw03: watchfaceName            : cw03
     v2_cw03: watchfaceNameWithExt     : cw03.zip
     v2_cw03: localFileURL             : file:///var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/Documents/watchface_gt01_prod_files_cw03_zip.zip
     v2_cw03: watchSupportedFileURL    : file:///private/var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/tmp/cw03.zip
     v2_cw03: localFileNameWithExt     : watchface_gt01_prod_files_cw03_zip.zip
     v2_cw03: localFileName            : watchface_gt01_prod_files_cw03_zip
     v2_cw03: fileExtension            : zip
     ℹ️____________PRINT_V2_Cw03______________🛠️


     ℹ️____________PRINT_V2_Cw99______________🛠️
     v2_cw99: CloudPreviewURL          : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgt01%2Fprod%2Fimages%2Fwatch99.png?alt=media
     v2_cw99: CloudFileURL             : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgt01%2Fprod%2Ffiles%2Fcw99.zip?alt=media
     v2_cw99: watchfaceName            : cw99
     v2_cw99: watchfaceNameWithExt     : cw99.zip
     v2_cw99: localFileURL             : file:///var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/Documents/watchface_gt01_prod_files_cw99_zip.zip
     v2_cw99: watchSupportedFileURL    : file:///private/var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/tmp/cw99.zip
     v2_cw99: localFileNameWithExt     : watchface_gt01_prod_files_cw99_zip.zip
     v2_cw99: localFileName            : watchface_gt01_prod_files_cw99_zip
     v2_cw99: fileExtension            : zip
     ℹ️____________PRINT_V2_Cw99______________🛠️


     ℹ️____________PRINT_V2_W100______________🛠️
     v2_w100: CloudPreviewURL          : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgt01%2Fprod%2Fimages%2Fwatch100.png?alt=media
     v2_w100: CloudFileURL             : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgt01%2Fprod%2Ffiles%2Fw100.zip?alt=media
     v2_w100: watchfaceName            : w100
     v2_w100: watchfaceNameWithExt     : w100.zip
     v2_w100: localFileURL             : file:///var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/Documents/watchface_gt01_prod_files_w100_zip.zip
     v2_w100: watchSupportedFileURL    : file:///private/var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/tmp/w100.zip
     v2_w100: localFileNameWithExt     : watchface_gt01_prod_files_w100_zip.zip
     v2_w100: localFileName            : watchface_gt01_prod_files_w100_zip
     v2_w100: fileExtension            : zip
     ℹ️____________PRINT_V2_W100______________🛠️


     ℹ️____________PRINT_V2_Gt33______________🛠️
     v2_gt33: CloudPreviewURL          : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgt01%2Fprod%2Fimages%2Fwatch33.png?alt=media
     v2_gt33: CloudFileURL             : https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgt01%2Fprod%2Ffiles%2Fgt33.zip?alt=media
     v2_gt33: watchfaceName            : gt33
     v2_gt33: watchfaceNameWithExt     : gt33.zip
     v2_gt33: localFileURL             : file:///var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/Documents/watchface_gt01_prod_files_gt33_zip.zip
     v2_gt33: watchSupportedFileURL    : file:///private/var/mobile/Containers/Data/Application/2BDDFEAB-32B0-453D-B038-E06494CB404E/tmp/gt33.zip
     v2_gt33: localFileNameWithExt     : watchface_gt01_prod_files_gt33_zip.zip
     v2_gt33: localFileName            : watchface_gt01_prod_files_gt33_zip
     v2_gt33: fileExtension            : zip
     ℹ️____________PRINT_V2_Gt33______________🛠️
     */
    
///``Logs Info:    ✅ Success | ⚠️ Warning |  ❌ Error | ℹ️ Info | 🛠️ Debug
}
