//
//  RecordingController.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/29.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class RecordingController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var location = "余区"
    var current = "添加出校记录"
    let AddBreakUrl = "https://car.wuruoye.com/car/add_ticket"
    let GetInsideCarUrl = "https://car.wuruoye.com/car/query_in_car"
    let OutCarUrl = "https://car.wuruoye.com/car/out_car"
    var CarList:[InsideCar] = []
    
    let inlocation:[String] = ["余区-友谊大道门","余区-和平大道门","南湖-东门","南湖-文治街门","南湖雄楚大道门","鉴湖-雄楚大道门","鉴湖-工大路门","西院-珞狮路门","西院-工大路门","东院-珞狮路门","东院-桂珞路门"]
    
    @IBOutlet var tableView: UITableView!
    var num = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        self.automaticallyAdjustsScrollViewInsets = false
        
        SVProgressHUD.show()
        GetInsideCar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CarList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recording", for: indexPath) as! RecordingCell

        if CarList[indexPath.row].id != nil {
            cell.carid.text = CarList[indexPath.row].id
        }else{
            cell.carid.text = "未知ID"
        }
        if CarList[indexPath.row].inGate != nil {
            if CarList[indexPath.row].inGate >= 1 && CarList[indexPath.row].inGate <= 11 {
                cell.location.text = inlocation[CarList[indexPath.row].inGate]
            }else{
                cell.location.text = "未知地点进入"
            }
        }else{
            cell.location.text = "未知地点进入"
        }
        if CarList[indexPath.row].inTime != nil {
            let timestring = changetime(time: CarList[indexPath.row].inTime)
            cell.time.text = timestring
        }else{
            cell.time.text = "未知时间进入"
        }

        return cell
    }
    
    //得到校内车辆
    func GetInsideCar() {
        let url = URL(string: GetInsideCarUrl)
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responsedata) in
            switch responsedata.result {
            case .success(let data):
                SVProgressHUD.dismiss()
                let jsondata = JSON(data)
                if jsondata != nil {
                    let jsonarray = jsondata.arrayObject
                    if jsonarray != nil {
                        for item in jsonarray! {
                            let listitem = InsideCar.init(fromDictionary: item as! [String : Any])
                            self.CarList.append(listitem)
                        }
                        self.tableView.reloadData()
                    }
                }
                break
            case .failure(let error):
                SVProgressHUD.dismiss()
                print(error.localizedDescription)
                let notice = UIAlertController(title: "提示", message: "网络请求出错", preferredStyle: .alert)
                let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                notice.addAction(noticeaction)
                self.present(notice, animated: true, completion: nil)
                break
            }
        }
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if current == "添加出校记录" {
            let action = UITableViewRowAction(style: .default, title: "出校") { (action, indexPath) in
                self.num = self.num - 1
                
                //发起出校网络请求
                let gateno = Int(arc4random()%11)+1    //随机生成出校门口号
                let gatenostring = String(gateno)
                let outcarid = self.CarList[indexPath.row].id!
                let user = UserDefaults.standard
                let userid = user.value(forKey: "userid") as! String
                
                print(outcarid)
                print(userid)
                print(gatenostring)
                
                let parameter = ["car":outcarid,"gate":gatenostring,"user":userid]
                let url = URL(string: self.OutCarUrl)
                var outsuccess = false
                
                Alamofire.request(url!, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                    switch responsedata.result {
                    case .success(let data):
                        let jsondata = JSON(data)
                        let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                        if issuccess {
                            outsuccess = true
                            //tableView.deleteRows(at: [indexPath], with: .fade)
                            self.CarList.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)

                        }else{
                            let errordata = jsondata.dictionaryObject?["info"] as! String
                            let notice = UIAlertController(title: "提示", message: errordata, preferredStyle: .alert)
                            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                            notice.addAction(noticeaction)
                            self.present(notice, animated: true, completion: nil)
                        }
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        let notice = UIAlertController(title: "提示", message: "网络请求出错", preferredStyle: .alert)
                        let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        notice.addAction(noticeaction)
                        self.present(notice, animated: true, completion: nil)
                        break
                    }
                })
                /*
                if outsuccess {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                */
        }
            action.backgroundColor = UIColor.green
            return [action]
        }else{
            let action = UITableViewRowAction(style: .default, title: "违章", handler: { (action, indexPath) in
                
                SVProgressHUD.show()
                //发起违章网络请求
                let url = URL(string: self.AddBreakUrl)
                let id = self.CarList[indexPath.row].id!
                let parameter = ["car":id]
                var ifsuccess = false
                
                Alamofire.request(url!, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                    switch responsedata.result {
                    case .success(let data):
                        SVProgressHUD.dismiss()
                        let jsondata = JSON(data)
                        let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                        if issuccess {
                            ifsuccess = true
                            SVProgressHUD.showInfo(withStatus: "添加违章成功")
                            SVProgressHUD.dismiss(withDelay: 0.5)
                        }else{
                            let errordata = jsondata.dictionaryObject?["info"] as! String
                            let notice = UIAlertController(title: "提示", message: errordata, preferredStyle: .alert)
                            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                            notice.addAction(noticeaction)
                            self.present(notice, animated: true, completion: nil)
                        }
                        break
                    case .failure(let error):
                        SVProgressHUD.dismiss()
                        print(error.localizedDescription)
                        let notice = UIAlertController(title: "提示", message: "网络请求出错", preferredStyle: .alert)
                        let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        notice.addAction(noticeaction)
                        self.present(notice, animated: true, completion: nil)
                        break
                    }
                })
                
            })
            action.backgroundColor = UIColor.red
            return [action]
        }
    }

    func changetime(time:Int) -> String {
        let inttime = time/1000
        let timestamp = TimeInterval(inttime)
        let timedate = Date(timeIntervalSince1970: timestamp)
        let dateform = DateFormatter()
        dateform.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateform.string(from: timedate)
    }

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            num = num - 1
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
