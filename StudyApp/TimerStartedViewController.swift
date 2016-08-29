//
//  TimerStartedViewController.swift
//  StudyApp
//
//  Created by 濱崎 裕太 on 2016/08/29.
//  Copyright © 2016年 YuleTeam. All rights reserved.
//

import UIKit

class TimerStartedViewController: UIViewController {

    @IBOutlet weak var closeButton: CircularButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //closeButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
    }

    @IBAction func closeAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }

    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .Default
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
