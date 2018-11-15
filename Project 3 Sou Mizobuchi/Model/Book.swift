//
//  Book.swift
//  Map Scriptures
//
//  Created by Steve Liddle on 10/11/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation
import GRDB

struct Book : TableRecord, FetchableRecord {
    
    // MARK: - Properties
    
    var id: Int
    var abbr: String
    var citeAbbr: String
    var fullName: String
    var numChapters: Int?
    var parentBookId: Int?
    var webTitle: String
    var tocName: String
    var subdiv: String?
    var backName: String
    var gridName: String
    var citeFull: String
    var heading2: String
    
    // MARK: - Table mapping
    
    static let databaseTableName = "book"
    
    // MARK: - Field names
    
    static let id = "ID"
    static let abbr = "Abbr"
    static let citeAbbr = "CiteAbbr"
    static let citeFull = "CiteFull"
    static let fullName = "FullName"
    static let numChapters = "NumChapters"
    static let parentBookId = "ParentBookId"
    static let webTitle = "WebTitle"
    static let tocName = "TOCName"
    static let subdiv = "Subdiv"
    static let backName = "BackName"
    static let gridName = "GridName"
    static let heading2 = "Heading2"
    
    // MARK: - Initialization
    
    init() {
        id = 0
        abbr = ""
        citeAbbr = ""
        fullName = ""
        webTitle = ""
        tocName = ""
        backName = ""
        gridName = ""
        citeFull = ""
        heading2 = ""
    }

    init(row: Row) {
        id = row[Book.id]
        abbr = row[Book.abbr]
        citeAbbr = row[Book.citeAbbr]
        citeFull = row[Book.citeFull]
        fullName = row[Book.fullName]
        numChapters = row[Book.numChapters]
        parentBookId = row[Book.parentBookId]
        webTitle = row[Book.webTitle]
        tocName = row[Book.tocName]
        subdiv = row[Book.subdiv]
        backName = row[Book.backName]
        gridName = row[Book.gridName]
        heading2 = row[Book.heading2]
    }
}
