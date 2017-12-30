//
//  CarSearchTableViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/15.
//  Copyright © 2017年 李祎喆. All rights reserved.
//  车辆查询

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class CarSearchTableViewController: UITableViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var InputNum: UITextField!
    @IBOutlet weak var CarNum: UILabel!
    @IBOutlet weak var Owner: UILabel!
    @IBOutlet weak var CarKind: UILabel!
    @IBOutlet weak var PassDocumentInfo: UILabel!
    @IBOutlet weak var PassInfo: UILabel!
    @IBOutlet weak var BreakInfo: UILabel!
    
    @IBOutlet weak var CarModel: UILabel!
    @IBOutlet weak var CarColor: UILabel!
    
    
    var GetCarInfo:QueryCar!
    //是否已经查询到结果
    var IsOrder:Bool = false
    
    //查询操作
    @IBAction func SearchActivity(_ sender: UIButton) {
        SVProgressHUD.show()
        
        view.endEditing(true)
        
        let userinput:String = InputNum.text!
        
        if userinput == "" {
            SVProgressHUD.dismiss()
            let notice = UIAlertController(title: "警告", message: "查询编号不能为空!", preferredStyle: .alert)
            let noticeaction = UIAlertAction(title: "好的", style: .default, handler: nil)
            notice.addAction(noticeaction)
            self.present(notice, animated: true, completion: nil)
        }else{
            if userinput.characters.count <= 8 {
                let url:URL = URL(string: "https://car.wuruoye.com/car/query_car_detail")!
                let prameters = ["id":userinput]
                Alamofire.request(url, method: .get, parameters: prameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                    let jsondata = JSON.init(responsedata.value!)
                    let success = jsondata.dictionaryObject?["result"] as! Bool
                    if success {
                        let cardata = QueryCar.init(fromDictionary: jsondata.dictionaryObject!)
                        self.GetCarInfo = cardata
                        self.IsOrder = true
                        
                        self.CarNum.text = cardata.info.car.id
                        if cardata.info.car.type != nil {
                            self.CarKind.text = cardata.info.car.type
                        }else{
                             self.CarKind.text = "未知"
                        }
                        if cardata.info.car.model != nil {
                            self.CarModel.text = cardata.info.car.model
                        }else{
                            self.CarModel.text = "未知"
                        }
                        if cardata.info.car.color != nil {
                            self.CarColor.text = cardata.info.car.color
                        }else{
                            self.CarColor.text = "未知"
                        }
                        
                        //以下三项是所有车辆都会有，也都应该收录的信息
                        if cardata.info.inOutNote.count == 0 {
                            self.PassInfo.text = "暂无进出记录"
                        }else{
                            var passstring:String = ""
                            if cardata.info.inOutNote[0].inTime != nil {
                                passstring = passstring + self.changetimedetail(time: cardata.info.inOutNote[0].inTime) + "~~"
                            }else{
                                passstring = passstring + "未知时间" + "~~"
                            }
                            if cardata.info.inOutNote[0].outTime != nil {
                                passstring = passstring + self.changetimedetail(time: cardata.info.inOutNote[0].outTime)
                            }else{
                                passstring = passstring + "未知时间"
                            }
                            self.PassInfo.text = passstring
                        }
                        if cardata.info.pass == nil {
                            self.PassDocumentInfo.text = "该车辆没有通行证"
                        }else{
                            var startstring = "未知时间"
                            var endstring = "未知时间"
                            if cardata.info.pass.fromTime != nil {
                                startstring = self.changetime(time: cardata.info.pass.fromTime)
                            }
                            if cardata.info.pass.toTime != nil {
                                endstring = self.changetime(time: cardata.info.pass.toTime)
                            }
                            let timestring = startstring + "~~" + endstring
                            self.PassDocumentInfo.text = timestring
                        }
                        if cardata.info.ticket.count == 0 {
                            self.BreakInfo.text = "该车辆没有违章记录"
                        }else{
                            let breakstring = String(cardata.info.ticket[0].id)
                            self.BreakInfo.text = breakstring
                        }
                        SVProgressHUD.dismiss()
                        
                    }else{
                        //未查询到信息
                        SVProgressHUD.dismiss()
                        let errordata = jsondata.dictionaryObject?["info"] as! String
                        let notice = UIAlertController(title: "提示", message: errordata, preferredStyle: .alert)
                        let noticeactivity = UIAlertAction(title: "确定", style: .default, handler: nil)
                        notice.addAction(noticeactivity)
                        self.present(notice, animated: true, completion: nil)
                    }
                })
            }else{
                SVProgressHUD.dismiss()
                let notice = UIAlertController(title: "提示", message: "编号输入不能超过8位", preferredStyle: .alert)
                let noticeactivity = UIAlertAction(title: "确定", style: .default, handler: nil)
                notice.addAction(noticeactivity)
                self.present(notice, animated: true, completion: nil)
                
            }
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.navigationItem.title = "车辆查询系统"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            if IsOrder {
                performSegue(withIdentifier: "GoToPass", sender: nil)
            }else{
                let notice = UIAlertController(title: "提示", message: "没有查询信息，请先进行查询", preferredStyle: .alert)
                let noticeactivity = UIAlertAction(title: "确定", style: .default, handler: nil)
                notice.addAction(noticeactivity)
                self.present(notice, animated: true, completion: nil)
            }
            break
        case 3:
            if IsOrder {
                performSegue(withIdentifier: "LookForDetail", sender: nil)
            }else{
                let notice = UIAlertController(title: "提示", message: "没有查询信息，请先进行查询", preferredStyle: .alert)
                let noticeactivity = UIAlertAction(title: "确定", style: .default, handler: nil)
                notice.addAction(noticeactivity)
                self.present(notice, animated: true, completion: nil)
            }
            break
        case 4:
            if IsOrder {
                performSegue(withIdentifier: "LookForDetail", sender: nil)
            }else{
                let notice = UIAlertController(title: "提示", message: "没有查询信息，请先进行查询", preferredStyle: .alert)
                let noticeactivity = UIAlertAction(title: "确定", style: .default, handler: nil)
                notice.addAction(noticeactivity)
                self.present(notice, animated: true, completion: nil)
            }
            break
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LookForDetail" {
            let dest = segue.destination as! CarDetailTableViewController
            switch (tableView.indexPathForSelectedRow?.section)! {
            case 3:
                dest.InfoKind = 2
                if GetCarInfo.info.inOutNote.count != 0 {
                    dest.inoutinfo = GetCarInfo.info.inOutNote
                }else{
                    dest.inoutinfo = []
                }
                break
            case 4:
                if GetCarInfo.info.ticket != nil {
                    dest.breakinfo = GetCarInfo.info.ticket
                }else{
                    dest.breakinfo = []
                }
                dest.InfoKind = 3
            default: break
            }
        }else if segue.identifier == "GoToPass" {
            let dest = segue.destination as! CarPassDetailViewController
            if GetCarInfo.info.pass != nil {
                dest.PassCard = GetCarInfo.info.pass
            }else{
                dest.PassCard = nil
            }
        }
    }
    
    //点击其他区域输入框消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func changetime(time:Int) -> String {
        let inttime = time/1000
        let timestamp = TimeInterval(inttime)
        let timedate = Date(timeIntervalSince1970: timestamp)
        let dateform = DateFormatter()
        dateform.dateFormat = "yyyy-MM-dd"
        return dateform.string(from: timedate)
    }
    
    func changetimedetail(time:Int) -> String {
        let inttime = time/1000
        let timestamp = TimeInterval(inttime)
        let timedate = Date(timeIntervalSince1970: timestamp)
        let dateform = DateFormatter()
        dateform.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateform.string(from: timedate)
    }

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
}
