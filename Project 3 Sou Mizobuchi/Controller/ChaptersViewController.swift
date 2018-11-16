//
//  ChaptersViewController.swift
//  Project 3 Sou Mizobuchi
//
//  Created by user144546 on 11/15/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit

class ChaptersViewController : UITableViewController {
    
    private struct StoryBoard {
        static let ChapterCellIdentifier = "ChapterCell"
        static let ShowScripturesSegueIdentifier = "ShowChapterContent"
    }
    
    var numChapters = 1
    var book = ""
    var bookId = 101
    
    // Mark - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = book
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.ShowScripturesSegueIdentifier {
            if let scriptureVC = segue.destination as? ScripturesViewController {
                if let indexPath = sender as? IndexPath {
                    scriptureVC.bookId = bookId
                    scriptureVC.chapter = indexPath.row + 1
                }
            }
        }
    }
    
    // Mark - table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numChapters
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.ChapterCellIdentifier, for: indexPath)
        cell.textLabel?.text = "Chapter \(String(indexPath.row + 1))"
        
        return cell
    }
    
    // Mark - table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: StoryBoard.ShowScripturesSegueIdentifier, sender: indexPath)
    }
}
