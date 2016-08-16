//
//  PageMenuViewController.swift
//  StudyApp
//
//  Created by Yuta Nakahama on 2016/08/15.
//  Copyright © 2016年 YuleTeam. All rights reserved.
//

import UIKit
import PageMenu

class PageMenuViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Viewを格納する配列
        var controllerArray : [UIViewController] = []
        
        // 追加するViewを作成
        let controller1 : UIViewController = UIViewController()
        controller1.title = "ビューその１"
        controller1.view.backgroundColor = UIColor.blueColor()
        controllerArray.append(controller1)
        
        let controller2 : UITableViewController = UITableViewController()
        controller2.title = "ビューその２"
        controller2.view.backgroundColor = UIColor.redColor()
        controllerArray.append(controller2)
        
        let controller3 : UITableViewController = UITableViewController()
        controller3.title = "ビューその３"
        controller3.view.backgroundColor = UIColor.greenColor()
        controllerArray.append(controller3)
        
        // PageMenuの設定
        let parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(4.3),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1)
        ]
        
        // PageMenuのビューのサイズを設定
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 20.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        // PageMenuのビューを親のビューに追加
        self.view.addSubview(pageMenu!.view)
        // PageMenuのビューをToolbarの後ろへ移動
        self.view.sendSubviewToBack(pageMenu!.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}