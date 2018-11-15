//
//  Scripture.swift
//  Map Scriptures
//
//  Created by Steve Liddle on 10/11/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation
import GRDB

struct Scripture : TableRecord, FetchableRecord {
    var id: Int
    var bookId: Int
    var chapter: Int
    var verse: Int
    var flag: String
    var text: String
    
    static let databaseTableName = "scripture"
    
    static let id = "ID"
    static let bookId = "BookID"
    static let chapter = "Chapter"
    static let verse = "Verse"
    static let flag = "Flag"
    static let text = "Text"
    
    init(row: Row) {
        id = row[Scripture.id]
        bookId = row[Scripture.bookId]
        chapter = row[Scripture.chapter]
        verse = row[Scripture.verse]
        flag = row[Scripture.flag]
        text = String(data: row[Scripture.text], encoding: .utf8)!
    }
}
