//
//  IconNetworkManager.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 17.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol ImageDownloadManagerInput {
    func getIcon(name: String, completion: @escaping (_ icon: Data?, _ error: String?) -> ())
}

final class ImageDownloadManager: NetworkResponseHandler, ImageDownloadManagerInput {
    
    let router = Router<ImageDownload>()

    func getIcon(name: String, completion: @escaping (Data?, String?) -> ()) {
        router.request(.getIcon(name: name), modelType: Data.self) { data, error in
            completion(data, error)
        }
    }
    
}
