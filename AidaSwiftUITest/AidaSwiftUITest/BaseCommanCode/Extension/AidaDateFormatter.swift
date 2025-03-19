//
//  AidaDateFormatter.swift
//  AidaApp
//
//  Created by Batuhan Göbekli on 26.12.2019.
//  Copyright © 2019 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

class AidaDateFormatter: DateFormatter {
    
    override var locale: Locale! {
        get {
            if LocalizedLanguage.userLocale == .turkish {
                return .init(identifier: "tr_TR")
            } else {
                return .init(identifier: "en_US")
            }
        }
        
        set {
            if LocalizedLanguage.userLocale == .turkish {
                super.locale =  .init(identifier: "tr_TR")
            } else {
                super.locale =  .init(identifier: "en_US")
            }
        }
    }
    
    override init() {
        super.init()
        locale = .current
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(format: DateFormat) {
        self.init()
        self.dateFormat = format.rawValue
    }
}
