//
//  GraphViewController.swift
//  StudyApp
//
//  Created by Yuta Nakahama on 2016/07/24.
//  Copyright © 2016年 YuleTeam. All rights reserved.
//

import UIKit
import Charts
import NCMB

class GraphViewController: UIViewController {

    // storyboardから接続
    @IBOutlet weak var barChartView: BarChartView!

    @IBAction func addDB(sender: UIButton) {
        let userId = "test"
        let nowTime = NSDate(timeIntervalSinceNow: NSTimeInterval(NSTimeZone.systemTimeZone().secondsFromGMT))
        let interval = UInt(arc4random() % 100 + 1)
        addStudyData(userId: userId, startDate: nowTime, interval: interval)
    }

    var months: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        months = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
        let unitsSold = [50.3, 68.3, 113.3, 115.7, 160.8, 214.0, 220.4, 132.1, 176.2, 120.9, 71.3, 48.0]

        barChartView.animate(yAxisDuration: 2.0)
        barChartView.pinchZoomEnabled = false
        barChartView.drawBarShadowEnabled = false
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

        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "降水量")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
    }

    // データベースから該当データを抽出
    //
    // :param: None
    // :returns: None
    func fetchAllStudyData() {
        let query = StudyData.query()
        query.whereKey("user_id", equalTo: "test")
        query.orderByDescending("createDate")
        query.limit = 20

        query.findObjectsInBackgroundWithBlock({(objects, error) in
            if (error == nil) {
                print("登録件数 \(objects.count)")
               // let studydata = objects as! [NCMBObject]
                for object in objects {
                    let studydata = object as! NCMBObject
                    let title = studydata.ncmbClassName
                    let startdate = studydata.objectForKey("startDate")
                    let interval = studydata.objectForKey("Interval")
//                    let title = object.ncmbClassName
                    print("--- \(studydata.objectId): \(title) \(startdate) \(interval)")

                }
            } else {
                print("Error: \(error)")
            }
        })
    }

    func addStudyData(userId userId: String, startDate: NSDate, interval: UInt) {
        let studydata = StudyData.object() as! StudyData
        studydata.setObject(userId, forKey: "user_id")
        studydata.setObject(startDate, forKey: "startDate")
        studydata.setObject(interval, forKey: "Interval")
        studydata.saveInBackgroundWithBlock({(error) in
            if (error == nil) {
                print("保存成功。")
            } else {
                print("保存に失敗しました: \(error)")
            }

        })
    }


}
