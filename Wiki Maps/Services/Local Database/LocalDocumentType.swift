//
//  LocalDocumentType.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/3/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import Gloss

protocol LocalDocumentType: Glossy {
    var id: String { get }
    var type: String? { get }
}
