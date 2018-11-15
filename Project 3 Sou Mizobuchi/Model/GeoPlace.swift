//
//  GeoPlace.swift
//  Map Scriptures
//
//  Created by Steve Liddle on 10/11/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation
import GRDB

struct GeoCategory : TableRecord, FetchableRecord {
    enum Category: Int {
        // Categories represent geocoded places we've constructed from various
        // Church history sources (1) or the Open Bible project (2)
        case churchHistory = 1,
        openBible = 2
    }
    
    var id: Int
    var category: Category
    
    static let databaseTableName = "geocategory"
    
    static let id = "Id"
    static let category = "Category"
    
    init(row: Row) {
        id = row[GeoCategory.id]
        category = Category(rawValue: row[GeoCategory.category])!
    }
}

struct GeoPlace : TableRecord, FetchableRecord {
    enum GeoFlag: String {
        // Flags indicate different levels of certainty in the Open Bible database
        case None = "",
        Open1 = "~",
        Open2 = ">",
        Open3 = "?",
        Open4 = "<",
        Open5 = "+"
    }
    
    var id: Int
    var placename: String
    var latitude: Double
    var longitude: Double
    var flag: GeoFlag
    var viewLatitude: Double!
    var viewLongitude: Double!
    var viewTilt: Double!
    var viewRoll: Double!
    var viewAltitude: Double!
    var viewHeading: Double!
    var category: GeoCategory.Category!
    
    static let databaseTableName = "geoplace"
    
    static let id = "Id"
    static let placename = "Placename"
    static let latitude = "Latitude"
    static let longitude = "Longitude"
    static let flag = "Flag"
    static let viewLatitude = "ViewLatitude"
    static let viewLongitude = "ViewLongitude"
    static let viewTilt = "ViewTilt"
    static let viewRoll = "ViewRoll"
    static let viewAltitude = "ViewAltitude"
    static let viewHeading = "ViewHeading"
    static let category = "Category"
    
    init(row: Row) {
        id = row[GeoPlace.id]
        placename = row[GeoPlace.placename]
        latitude = row[GeoPlace.latitude]
        longitude = row[GeoPlace.longitude]
        category = GeoCategory.Category(rawValue: row[GeoPlace.category])
        
        if let geoFlag = row[GeoPlace.flag] as? String {
            flag = GeoFlag(rawValue: geoFlag)!
        } else {
            flag = GeoFlag.None
        }
        
        if let vLatitude = row[GeoPlace.viewLatitude] as? Double {
            viewLatitude = vLatitude
            viewLongitude = row[GeoPlace.viewLongitude]
            viewTilt = row[GeoPlace.viewTilt]
            viewRoll = row[GeoPlace.viewRoll]
            viewAltitude = row[GeoPlace.viewAltitude]
            viewHeading = row[GeoPlace.viewHeading]
        }
    }
}

struct GeoTag : TableRecord, FetchableRecord {
    var geoplaceId: Int
    var scriptureId: Int
    var startOffset: Int
    var endOffset: Int

    static let databaseTableName = "geotag"

    static let geoplaceId = "GeoplaceId"
    static let scriptureId = "ScriptureId"
    static let startOffset = "StartOffset"
    static let endOffset = "EndOffset"

    init(row: Row) {
        geoplaceId = row[GeoTag.geoplaceId]
        scriptureId = row[GeoTag.scriptureId]
        startOffset = row[GeoTag.startOffset]
        endOffset = row[GeoTag.endOffset]
    }
}
