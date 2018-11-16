//
//  BooksViewController.swift
//  Project 3 Sou Mizobuchi
//
//  Created by user144546 on 11/14/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit

class BooksViewController : UITableViewController {
    
    private struct StoryBoard {
        static let BookCellIdentifier = "BookCell"
        static let ShowChaptersSegueIdentifier = "ShowChapterList"
        static let ShowScripturesSegueIdentifier = "ShowChapterContent"
    }
    
    var books = [Book]()
    var volume = ""
    var volumeId = 1
    
    // Mark - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.ShowChaptersSegueIdentifier {
            if let chapterVC = segue.destination as? ChaptersViewController {
                if let book = sender as? Book {
                    chapterVC.bookId = book.id
                    chapterVC.book = book.fullName
                    chapterVC.numChapters = book.numChapters!
                }
            }
        }
        else if segue.identifier == StoryBoard.ShowScripturesSegueIdentifier {
            if let scriptureVC = segue.destination as? ScripturesViewController {
                if let book = sender as? Book {
                    scriptureVC.bookId = book.id
                    scriptureVC.chapter = 1
                }
            }
        }
    }

    
    // Mark - table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.BookCellIdentifier, for: indexPath)
        cell.textLabel?.text = books[indexPath.row].fullName
        
        return cell
    }
    
    // Mark - table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        if book.numChapters == 1 {
            performSegue(withIdentifier: StoryBoard.ShowScripturesSegueIdentifier, sender: book)
        }
        else {
            performSegue(withIdentifier: StoryBoard.ShowChaptersSegueIdentifier, sender: book)
        }
    }
    
    // Mark - helpers
    private func updateModel() {
        title = volume
        books = GeoDatabase.sharedGeoDatabase.booksForParentId(volumeId)
    }
}

