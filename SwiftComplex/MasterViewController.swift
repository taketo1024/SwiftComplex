//
//  MasterViewController.swift
//  SwiftComplex
//
//  Created by Taketo Sano on 2014/10/18.
//  
//

import UIKit

class MasterViewController: UITableViewController {
    
    let titles = ["w = z * z", "w = 1 / z", "w = z^2 + z + 1"]
    
    func map(index: Int) -> ((Complex) -> Complex) {
        switch(index) {
        case 0: return {$0 * $0}
        case 1: return {1 /  $0}
        case 2: return {$0 * $0 + $0 + 1}
        default: return {$0}
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destinationViewController as DetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let index = indexPath.row
                vc.title = titles[index];
                vc.map = map(index)
            }
        } else if segue.identifier == "showSphere" {
            let vc = segue.destinationViewController as ComplexSphereViewController
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let index = indexPath.row
                vc.title = titles[index];
                vc.map = map(index)
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return "Basic"
        case 1: return "Complex Plane"
        default: return nil
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return titles.count
        case 1: return 1
        default: return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseId = "Cell-Section\(indexPath.section)"
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseId, forIndexPath: indexPath) as UITableViewCell
        
        switch(indexPath.section) {
        case 0:
            let object = titles[indexPath.row] as String
            cell.textLabel?.text = object
        case 1:
            cell.textLabel?.text = "test"
        default:
            break
        }
        
        return cell
    }
}

