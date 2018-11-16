//
//  ScripturesViewController.swift
//  Project 3 Sou Mizobuchi
//
//  Created by user144546 on 11/14/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit
import WebKit

class ScripturesViewController : UIViewController, WKNavigationDelegate {
    
    // Mark - properties
    var bookId = 101
    var chapter = 2
    private weak var mapViewController: MapViewController?
    
    // Mark outlets
    @IBOutlet weak var webView: WKWebView!
    
    // Mark - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailViewController()
        
        let (html, geoplaces) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookId, chapter: chapter)
        
        webView.navigationDelegate = self
        webView.loadHTMLString(html, baseURL: nil)
        
        if let mapVC = mapViewController {
            mapVC.configureMap(geoplaces)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureDetailViewController()
    }
    
    // Mark - webkit delegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let path = navigationAction.request.url?.absoluteString {
            let baseUrl = ScriptureRenderer.Constant.baseUrl
            if path.hasPrefix(baseUrl) {
                if let geoplaceId = Int(path.substring(fromOffset: baseUrl.count)) {
                    print(geoplaceId)
                }
                
                if mapViewController == nil {
                    //a
                }
                else {
                    //a
                }
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    // Mark - helper
    private func configureDetailViewController () {
        if let splitVC = splitViewController {
            if let navVC = splitVC.viewControllers.last as? UINavigationController {
                mapViewController = navVC.topViewController as? MapViewController
            }
        }
        else {
            mapViewController = nil
        }
    }
}
