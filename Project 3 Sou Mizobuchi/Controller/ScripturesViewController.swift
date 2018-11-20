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
    
    // Mark -
    private struct StoryBoard {
        static let ShowMapSegueIdentifier = "ShowMap"
    }
    
    // Mark - properties
    var bookId = 101
    var book = ""
    var chapter = 1
    var geoplaces = [GeoPlace]()
    weak var mapViewController: MapViewController?
    
    // Mark outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var mapBtn: UIButton!
    
    // Mark - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(book) Chapter \(chapter)"
        configureDetailViewController()
        
        let (html, gps) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookId, chapter: chapter)
        geoplaces = gps
        
        webView.navigationDelegate = self
        webView.loadHTMLString(html, baseURL: nil)
        
        if let mapVC = mapViewController {
            mapVC.book = book
            mapVC.chapter = chapter
            mapVC.setTitle()
            mapVC.configureMap(geoplaces)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureDetailViewController()

        if mapViewController != nil {
            mapBtn.isHidden = true
        }
        else {
            mapBtn.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.ShowMapSegueIdentifier {
            if let navVC = segue.destination as? UINavigationController {
                if let mapVC = navVC.viewControllers.first as? MapViewController {
                    mapVC.geoplaces = geoplaces
                    mapVC.book = book
                    mapVC.chapter = chapter
                }
            }
        }
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
