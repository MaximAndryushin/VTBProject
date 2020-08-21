//
//  HistoryModels.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.

import UIKit

enum History {
    // MARK: - Use cases
    
    enum ShowQueries {
        struct Request {
            let type: TypeOfQuery?
            let isAscending: Bool
        }
        
        struct Response {
            let queries: [QueryViewModel]
        }
        
        struct viewModel {
            let queries: [QueryViewModel]
        }
        
    }
    
}



