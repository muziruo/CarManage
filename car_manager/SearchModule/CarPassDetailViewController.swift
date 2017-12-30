//
//  CarPassDetailViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/30.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class CarPassDetailViewController: UIViewController {

    
    @IBOutlet weak var CarId: UILabel!
    @IBOutlet weak var PersonId: UILabel!
    @IBOutlet weak var CreateTime: UILabel!
    @IBOutlet weak var StartTime: UILabel!
    @IBOutlet weak var EndTime: UILabel!
    @IBOutlet weak var Fee: UILabel!
    @IBOutlet weak var CarType: UILabel!
    
    var PassCard:Pas!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "通行证信息"
        
        if PassCard != nil {
            if PassCard.car != nil {
                CarId.text = PassCard.car
            }else{
                CarId.text = "未知"
            }
            if PassCard.owner != nil {
                PersonId.text = PassCard.owner
            }else{
                PersonId.text = "未知"
            }
            if PassCard.createTime != nil {
                let timestring = changetime(time: PassCard.createTime)
                CreateTime.text = timestring
            }else{
                CreateTime.text = "未知"
            }
            if PassCard.fromTime != nil {
                let startstring = changetime(time: PassCard.fromTime)
                StartTime.text = startstring
            }else{
                StartTime.text = "未知"
            }
            if PassCard.toTime != nil {
                let endstring = changetime(time: PassCard.toTime)
                EndTime.text = endstring
            }else{
                EndTime.text = "未知"
            }
            if PassCard.fee != nil {
                let feestring = String(PassCard.fee)
                Fee.text = feestring
            }else{
                Fee.text = "未知"
            }
            if PassCard.type != nil {
                switch PassCard.type {
                case 1:
                    CarType.text = "小型车"
                case 2:
                    CarType.text = "大型车"
                default:
                    CarType.text = "未知类型"
                }
            }else{
                CarType.text = "未知"
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changetime(time:Int) -> String {
        let inttime = time/1000
        let timestamp = TimeInterval(inttime)
        let timedate = Date(timeIntervalSince1970: timestamp)
        let dateform = DateFormatter()
        dateform.dateFormat = "yyyy-MM-dd"
        return dateform.string(from: timedate)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
