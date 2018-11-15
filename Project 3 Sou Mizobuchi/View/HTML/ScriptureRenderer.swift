//
//  ScriptureRenderer.swift
//  Map Scriptures
//
//  Created by Steve Liddle on 11/7/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import Foundation

// MARK: - ScriptureRenderer class

class ScriptureRenderer {

    // MARK: - Constants

    struct Constant {
        static let baseUrl = "http://scriptures.byu.edu/mapscrip/"
        static let footnoteVerse = 1000
        static let renderLongTitles = true
    }

    // MARK: - Properties

    // Note how I've made this property private and now return a tuple from htmlForBookId() so as
    // to eliminate the "code smell" of having MapViewController depend on state of this singleton.
    // Many software engineers would point to the previous public version of this property as an
    // example of a classic anti-pattern (a bad thing).
    private var collectedGeocodedPlaces = [GeoPlace]()

    // MARK: - Singleton

    // See http://bit.ly/1tdRybj for a discussion of this singleton pattern.
    static let sharedRenderer = ScriptureRenderer()

    private init() {
        // This guarantees that code outside this file can't instantiate a ScriptureRenderer.
        // So others must use the sharedRenderer singleton.
    }

    // MARK: - Helpers

    func htmlForBookId(_ bookId: Int, chapter: Int) -> (String, [GeoPlace]) {
        let book = GeoDatabase.sharedGeoDatabase.bookForId(bookId)
        var title = ""
        var heading1 = ""
        var heading2 = ""

        title = titleForBook(book, chapter, Constant.renderLongTitles)

        heading1 = book.webTitle

        if !isSupplementary(book) {
            heading2 = book.heading2

            if heading2 != "" {
                heading2 = "\(heading2)\(chapter)"
            }
        }

        let stylePath = Bundle.main.path(forResource: "scripture", ofType: "css")!
        let scriptureStyle = try? NSString(contentsOfFile: stylePath, encoding: String.Encoding.utf8.rawValue)

        var page = "<!doctype html>\n<html><head><title>\(title)</title>\n"

        if let style = scriptureStyle {
            page += "<style type=\"text/css\">\n\(style)\n</style>\n"
        }
        
        page += "<meta name=\"viewport\" content=\"initial-scale=1.0, user-scalable=NO\" />\n"
        page += "</head>\n<body>"
        page += "<div class=\"heading1\">\(heading1)</div>"
        page += "<div class=\"heading2\">\(heading2)</div>"
        page += "<div class=\"chapter\">"

        collectedGeocodedPlaces = [GeoPlace]()

        for scripture in GeoDatabase.sharedGeoDatabase.versesForScriptureBookId(bookId, chapter) {
            var verseClass = "verse"

            if scripture.flag == "H" {
                verseClass = "headVerse"
            }

            page += "<a name=\"\(scripture.verse)\"><div class=\"\(verseClass)\">"

            if scripture.verse > 1 && scripture.verse < Constant.footnoteVerse {
                page += "<span class=\"verseNumber\">\(scripture.verse)</span>"
            }

            page += geocodedTextForVerseText(scripture.text, scripture.id)
            page += "</div>"
        }

        let scriptPath = Bundle.main.path(forResource: "geocode", ofType: "js")!
        let script = try! NSString(contentsOfFile: scriptPath, encoding: String.Encoding.utf8.rawValue)
        
        page += "</div></body><script type=\"text/javascript\">\(script)</script></html>"

        return (page.convertToHtmlEntities(), collectedGeocodedPlaces)
    }

    // MARK: - Private helpers

    private func geocodedTextForVerseText(_ verseText: String, _ scriptureId: Int) -> String {
        var verseText = verseText
        for (geoplace, geotag) in GeoDatabase.sharedGeoDatabase.geoTagsForScriptureId(scriptureId) {
            let startIndex = verseText.index(verseText.startIndex, offsetBy: geotag.startOffset)
            let endIndex = verseText.index(startIndex, offsetBy: geotag.endOffset - geotag.startOffset)

            collectedGeocodedPlaces.append(geoplace)

            // Insert hyperlink for geotag in this verse at the given offsets
            verseText = """
                        \(verseText[..<startIndex])\
                        <a href="\(Constant.baseUrl)\(geoplace.id)">\
                        \(verseText[startIndex ..< endIndex])</a>\
                        \(verseText[endIndex...])
                        """
        }

        return verseText
    }

    private func isSupplementary(_ book: Book) -> Bool {
        return book.numChapters == nil && book.parentBookId != nil;
    }

    private func titleForBook(_ book: Book, _ chapter: Int, _ renderLongTitles: Bool) -> String {
        var title = renderLongTitles ? book.citeFull : book.citeAbbr
        let numChapters = book.numChapters ?? 0

        if chapter > 0 && numChapters > 1 {
            title += " \(chapter)"
        }

        return title
    }
}
