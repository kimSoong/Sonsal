//
//  MainViewController.swift
//  Sunsal
//
//  Created by KimSoong on 2014. 11. 6..
//  Copyright (c) 2014년 kims1006. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    
    @IBOutlet weak var hudCell: UITableViewCell!
    @IBOutlet weak var AlertCell: UITableViewCell!
    @IBOutlet weak var ActionSheetCell: UITableViewCell!
    
    @IBOutlet weak var photoViewCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        AlbumManager.sharedManager;
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell == hudCell {
                showHUD();
            }else if cell == AlertCell {
                showAlert(UIAlertControllerStyle.Alert);
            }else if cell == ActionSheetCell {
                showAlert(UIAlertControllerStyle.ActionSheet);
            }else if cell == photoViewCell {
                photoView();
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func photoView(){
    
        var browser = MWPhotoBrowser(delegate: AlbumManager.sharedManager)
        browser.displayActionButton = true; // Show action button to allow sharing, copying, etc (defaults to YES)
        browser.displayNavArrows = false; // Whether to display left and right nav arrows on toolbar (defaults to NO)
        browser.displaySelectionButtons = false; // Whether selection buttons are shown on each image (defaults to NO)
        browser.zoomPhotosToFill = true; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
        browser.alwaysShowControls = false; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
        browser.enableGrid = true; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
        browser.startOnGrid = true; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
        browser.enableSwipeToDismiss = true;
        
        self.navigationController!.pushViewController(browser, animated: true)
        
    }
    
    func showHUD() {
        MBProgressHUD.showHUDAddedTo(navigationController!.view, animated: true)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "hideHUD", userInfo: nil, repeats: false)
    }
    
    func hideHUD() {
        MBProgressHUD.hideHUDForView(navigationController?.view, animated: true)
    }
    
    func showAlert(AlertType: UIAlertControllerStyle) {
        var alertContrller = UIAlertController(title: "안녕하세요", message: "나는 마스터 입니다.", preferredStyle: AlertType);
        alertContrller.addAction(UIAlertAction(title: "꺼주세요", style: UIAlertActionStyle.Cancel, handler: {
            (alertAction) -> Void in
        }))
        alertContrller.addAction(UIAlertAction(title: "끄지마요", style: UIAlertActionStyle.Default, handler: {
            (alertAction) -> Void in
            self.presentViewController(alertContrller, animated: true, completion: nil);
        }))
        presentViewController(alertContrller, animated: true, completion: nil);
    }
    
}
