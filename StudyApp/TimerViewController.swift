//
//  ViewController.swift
//  StudyApp
//
//  Created by Yuta Nakahama on 2016/07/23.
//  Copyright © 2016年 YuleTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flag : Int = 0
    var s : Int = 0
    var m : Int = 0
    var h : Int = 0
    var d : Int = 0
    
    //時間計測用の変数
    var cnt : Double = 0
    
    //時間表示用のラベル
    var myLabel : UILabel!
    
    //秒数定義用テキストボックス
    @IBOutlet var sec_pre: UITextField!
    
    @IBOutlet weak var myTextField: UITextField!
    
    override func viewDidLoad() {
        
        //ラベルを作る
        myLabel = UILabel(frame: CGRectMake(0,0,200,50))
        myLabel.backgroundColor = UIColor.blueColor()
        myLabel.layer.masksToBounds = true
        myLabel.layer.cornerRadius = 20.0
        myLabel.text = "Time:\(cnt)"
        myLabel.textColor = UIColor.whiteColor()
        myLabel.shadowColor = UIColor.grayColor()
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 100)
        self.view.backgroundColor = UIColor.cyanColor()
        self.view.addSubview(myLabel)
        
        //定義用テキストボックステンキー化
        sec_pre.keyboardType = .NumberPad
        
        //タイマーを作る
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.onUpdate(_:)), userInfo: nil, repeats: true)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //NSTimerIntervalで指定された秒数毎に呼び出されるメソッド.
    func onUpdate(timer : NSTimer){
        
        cnt += 0.1
        
        //桁数を指定して文字列を作る.
        let str = "Time:".stringByAppendingFormat("%.1f",cnt)
        
        myLabel.text = str
        
        //flagに応じてテキストボックスに表示する
        if flag == 1 && 29.9 < cnt && cnt < 30.1{
            myTextField.text = "30sec"
        }
        if flag == 2 && 59.9 < cnt && cnt < 60.1{
            myTextField.text = "1min"
        }
        if flag == 3 && 599.9 < cnt && cnt < 600.1{
            myTextField.text = "10min"
        }
        
        //打鍵による一般的な定義用if文
        if flag == 4 /*&& (Double(s) - 0.1) < cnt && cnt < (Double(s) + 0.1)*/{
            if m >= 1 && h < 1{
                myTextField.text = "".stringByAppendingFormat("%d", m )+("min ")+"".stringByAppendingFormat("%d", s - (m * 60) )+("sec")
            }
            else if h >= 1 && d < 1{
                myTextField.text = "".stringByAppendingFormat("%d", h )+("hour ")+"".stringByAppendingFormat("%d",m - ( h * 60) )+("min ")+"".stringByAppendingFormat("%d",s - ( m * 60 ) )+("sec")
            }
            else if d >= 1 {
                myTextField.text = "".stringByAppendingFormat("%d", d )+("day ")+"".stringByAppendingFormat("%d", h - ( d * 24 ) )+("hour ")+"".stringByAppendingFormat("%d",m - ( h * 60) )+("min ")+"".stringByAppendingFormat("%d",s - ( m * 60 ) )+("sec")
            }
            else{
                myTextField.text = "".stringByAppendingFormat("%d",s)+("sec")
            }
        }
    }
    
    @IBAction func tapScreen(sender: AnyObject) {
        self.view.endEditing(true)
    }
    //    func textFieldShouldReturn(sec_pre: UITextField) -> Bool{
    //        // キーボードを閉じる
    //        sec_pre.resignFirstResponder()
    //
    //        return true
    //    }
    
    @IBAction func sec30(sender: AnyObject) {
        cnt = 0
        flag = 1
        myTextField.text = ""
    }
    @IBAction func min1(sender: AnyObject) {
        cnt = 0
        flag = 2
        myTextField.text = ""
    }
    @IBAction func min10(sender: AnyObject) {
        cnt = 0
        flag = 3
        myTextField.text = ""
    }
    
    //打鍵にて秒数定義
    @IBAction func definition(sender: AnyObject) {
        s = Int(sec_pre.text!)!
        m = s / 60
        h = m / 60
        d = h / 24
        cnt = 0
        flag = 4
        myTextField.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
