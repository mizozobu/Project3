//
//  String+Extensions.swift
//  Map Scriptures
//
//  Created by Steve Liddle on 10/24/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

extension String {
    // Convert certain UTF-8 characters to their corresponding HTML entities.
    // For example, the left double-quote character becomes "&ldquo;".  Use this
    // method to prepare a string for displaying e.g. in a web view.
    mutating func convertToHtmlEntities() -> String {
        _ = replaceAllSubstrings([
            "\u{00b6}" : "&para;",   "\u{2014}" : "&mdash;",  "\u{2013}" : "&ndash;",
            "\u{201c}" : "&ldquo;",  "\u{201d}" : "&rdquo;",  "\u{2018}" : "&lsquo;",
            "\u{2019}" : "&rsquo;",  "\u{2026}" : "&hellip;", "\u{00e9}" : "&eacute;",
            "\u{00e1}" : "&aacute;", "\u{00ed}" : "&iacute;", "\u{00f3}" : "&oacute;",
            "\u{00fa}" : "&uacute;", "\u{00f1}" : "&ntilde;",
            ])

        return self
    }

    // This method replaces substrings according to a dictionary of string/replacement pairs.
    // The key is the string to replace, and the value is the replacement.  The dictionary
    // can hold as many pairs as you'd like.
    mutating func replaceAllSubstrings(_ replacements: [String : String]) -> String {
        for (target, replacement) in replacements {
            self = replacingOccurrences(of: target,
                                        with: replacement,
                                        options: .caseInsensitive,
                                        range: nil)
        }

        return self
    }

    // This convenience method retrieves the substring from a given offset to end of string.
    func substring(fromOffset offset: Int) -> String {
        return String(self[index(startIndex, offsetBy: offset)...])
    }
}
