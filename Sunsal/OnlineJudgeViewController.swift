//
//  OnlineJudgeViewController.swift
//  Sunsal
//
//  Created by KimSoong on 2014. 11. 6..
//  Copyright (c) 2014년 kims1006. All rights reserved.
//

import UIKit

class OnlineJudgeViewController: UITableViewController {

    var listArray:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadProblems();
        
        refreshControl = UIRefreshControl(frame: CGRectZero);
        
        if let r = refreshControl {
            r.sizeToFit()
            r.addTarget(self, action: "refreshStart", forControlEvents: .ValueChanged);
            tableView.addSubview(r);
        }
    }
    
    func refreshStart() {
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "refreshEnd", userInfo: nil, repeats: false);
    }
    func refreshEnd() {
        if let r = refreshControl {
            r.endRefreshing()
        }
    }
    func loadProblems() {
        
        MBProgressHUD.showHUDAddedTo(navigationController?.view, animated: true)
        
        var manager = AFHTTPRequestOperationManager();
        manager.GET("http://www.acmicpc.net/data/problems.json", parameters: nil, success: { (operation, list) -> Void in
            
            var a = list as [AnyObject]
            
            self.listArray = a;
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                var x = MBProgressHUD.hideHUDForView(self.navigationController?.view, animated: true)
                self.tableView.reloadData()
            })
            
        }) { (operation, error) -> Void in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return listArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OJCell", forIndexPath: indexPath) as UITableViewCell
        
        if let d = listArray[indexPath.row] as? [NSObject : AnyObject] {
            if let s = d["title"] as? String {
                cell.detailTextLabel?.text = s
            }
            if let s = d["problem_id"] as? String {
                cell.textLabel?.text = s;
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let d = listArray[indexPath.row] as? [NSObject : AnyObject] {
            if let s = d["problem_id"] as? String {
                var url = "http://www.acmicpc.net/problem/\(s)";
                NSLog("%@",url);
                UIApplication.sharedApplication().openURL(NSURL(string: url)!);
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
