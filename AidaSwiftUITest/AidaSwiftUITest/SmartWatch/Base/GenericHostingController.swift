//
//  HostingController.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

///HostingController will use to link Swift UI Code to UIKit view controller and manage linking between UIKit and SwiftUI
class GenericHostingController<T: View>: UIHostingController<T> {
    override init(rootView: T) {
        super.init(rootView: rootView)
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Customize the navigation bar when this view is loaded. Must be in viewWillAppear otherwise swipe gesture may increase the title size.
       // navigationController?.configure(font: StyleManager.fonts.muliBlackMedium, prefersLargeTitle: false)
    }
}
