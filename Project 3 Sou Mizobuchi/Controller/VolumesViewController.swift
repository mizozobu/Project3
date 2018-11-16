//
//  VolumesViewController.swift
//  
//
//  Created by user144546 on 11/14/18.
//

import UIKit

class VolumesViewController : UITableViewController {
    
    private struct StoryBoard {
        static let ShowBooksSegueIdentifier = "ShowBooks"
        static let VolumeCellIdentifier = "VolumeCell"
    }
    
    var volumes = GeoDatabase.sharedGeoDatabase.volumes()
    
    // Mark - view lifecycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.ShowBooksSegueIdentifier {
            if let bookVC = segue.destination as? BooksViewController {
                if let indexPath = sender as? IndexPath {
                    bookVC.volumeId = indexPath.row + 1
                    bookVC.volume = volumes[indexPath.row]
                }
                
            }
        }
    }
    
    // Mark - tableview data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volumes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.VolumeCellIdentifier, for: indexPath)
        cell.textLabel?.text = volumes[indexPath.row]
        
        return cell
    }
    
    // Mark - tableview delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: StoryBoard.ShowBooksSegueIdentifier, sender: indexPath)
    }
}
