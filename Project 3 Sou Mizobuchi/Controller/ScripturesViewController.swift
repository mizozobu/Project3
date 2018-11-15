//
//  ScripturesViewController.swift
//  Project 3 Sou Mizobuchi
//
//  Created by user144546 on 11/14/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit
import WebKit

class ScripturesViewController : UIViewController {
    
    var bookId = 101
    var chapter = 2
    
    // Mark outlets
    @IBOutlet weak var webView: WKWebView!
    
    
    // Mark - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (html, _) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookId, chapter: chapter)
        webView.loadHTMLString(html, baseURL: nil)
    }
}
