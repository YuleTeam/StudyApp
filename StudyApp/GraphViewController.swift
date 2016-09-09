//
//  GraphViewController.swift
//  StudyApp
//
//  Created by Yuta Nakahama on 2016/07/24.
//  Copyright © 2016年 YuleTeam. All rights reserved.
//


// NCMB (データベースのやつ)に関するリファレンスは以下に記載
// http://mb.cloud.nifty.com/assets/sdk_doc/ios/doc/html/index.html


import UIKit
import Charts
import NCMB

class GraphViewController: UIViewController {

    // storyboardから接続
    @IBOutlet weak var barChartView: LineChartView!

    // DB挿入例
    @IBAction func addDB(sender: UIButton) {
        let userId = "test"
        let nowTime = NSDate(timeIntervalSinceNow: NSTimeInterval(NSTimeZone.systemTimeZone().secondsFromGMT))
        let interval = UInt(arc4random() % 100 + 1)
        // この関数呼び出しによってDBに追加できる
        addStudyData(userId: userId, startDate: nowTime, interval: interval)
    }

    var months: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        months = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
        let unitsSold = [50.3, 68.3, 113.3, 115.7, 160.8, 214.0, 220.4, 132.1, 176.2, 120.9, 71.3, 48.0]

        barChartView.animate(yAxisDuration: 2.0)
        barChartView.backgroundColor = UIColor.whiteColor()
        barChartView.gridBackgroundColor = UIColor.whiteColor()

        barChartView.drawGridBackgroundEnabled = true
        barChartView.legend.enabled = false
//        barChartView.xAxis.enabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false

        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawZeroLineEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = true
        barChartView.rightAxis.enabled = false
        barChartView.pinchZoomEnabled = false
        barChartView.dragEnabled = true
        barChartView.drawBordersEnabled = true
        barChartView.descriptionText = "京都府の月毎の降水量グラフ"

        setChart(months, values: unitsSold)

        fetchAllStudyData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."

        var dataEntries: [ChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }

        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "降水量")
        chartDataSet.axisDependency = .Left
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.lineWidth = 2.0
        chartDataSet.circleRadius = 3.0
        chartDataSet.drawCubicEnabled = true
        chartDataSet.fillAlpha = 1.0
        chartDataSet.drawFilledEnabled = true
        chartDataSet.fillColor = UIColor.init(red: 51/255.0, green: 181/255.0, blue: 229/255.0, alpha: 150/255.0)
        chartDataSet.highlightColor = UIColor.init(red: 244/255.0, green: 117/255.0, blue: 117/255.0, alpha: 1.0)
        chartDataSet.drawCircleHoleEnabled = false
        let chartData = LineChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
    }

    // データベースから該当データを抽出
    //
    // :param: None
    // :returns: None
    func fetchAllStudyData() {
        // クエリ実行用変数を用意
        let query = StudyData.query()

        // 以下、クエリを設定する
        // ちなみに用意されているメソッドは以下を参照
        // http://mb.cloud.nifty.com/assets/sdk_doc/ios/doc/html/Classes/NCMBQuery.html
        query.whereKey("user_id", equalTo: "test")
        query.orderByDescending("createDate")
        query.limit = 20

        // 先に設定したクエリを発行する
        // 結果は NCMBObject の配列として受け取る :objects
        // エラーがある場合は NSError として受け取る :error
        query.findObjectsInBackgroundWithBlock({(objects, error) in
            if (error == nil) {
                print("登録件数 \(objects.count)")

                // 配列の中身をを1つずつ取り出す
                for object in objects {
                    // object は実は NSArray という関係ない形なので強制的に NCMBObject にキャストする
                    let studydata = object as! NCMBObject
                    // テーブルの名前は ncmbClassName に格納されている
                    let title = studydata.ncmbClassName
                    // テーブルの属性値は objectForKey("属性名") で取り出す
                    let startdate = studydata.objectForKey("startDate")
                    let interval = studydata.objectForKey("Interval")
                    print("--- \(studydata.objectId): \(title) \(startdate) \(interval)")

                }
            } else {
                print("Error: \(error)")
            }
        })
    }

    /**
     データベースへデータを挿入するメソッド

     - parameter userId:    ユーザIDを指定
     - parameter startDate: 時間を指定
     - parameter interval:  間隔を指定
     */
    func addStudyData(userId userId: String, startDate: NSDate, interval: UInt) {
        // データベースに挿入するために、インスタンスを生成する
        // StudyData() でやってしまうとエラー出るので注意
        let studydata = StudyData.object() as! StudyData

        // テーブルの属性名および属性値を指定する
        // setObject(属性値, forKey:"属性名")
        studydata.setObject(userId, forKey: "user_id")
        studydata.setObject(startDate, forKey: "startDate")
        studydata.setObject(interval, forKey: "Interval")

        // 先に設定した値でデータを挿入する
        studydata.saveInBackgroundWithBlock({(error) in
            if (error == nil) {
                print("保存成功。")
            } else {
                print("保存に失敗しました: \(error)")
            }

        })
    }


}
