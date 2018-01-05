//
//  CarDetailTableViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/18.
//  Copyright © 2017年 李祎喆. All rights reserved.
//  车辆详情页面

import UIKit
import SVProgressHUD

class CarDetailTableViewController: UITableViewController {

    var InfoKind:Int!
    var breakinfo:[Ticket] = []
    var inoutinfo:[InOutNote] = []
    
    let location:[String] = ["余区-友谊大道门","余区-和平大道门","南湖-东门","南湖-文治街门","南湖雄楚大道门","鉴湖-雄楚大道门","鉴湖-工大路门","西院-珞狮路门","西院-工大路门","东院-珞狮路门","东院-桂珞路门"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.dismiss()
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        let emptynotice:UILabel = UILabel()
        emptynotice.text = "无任何数据"
        emptynotice.center = tableView.center
        tableView.addSubview(emptynotice)
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
        return 1
        /*
        switch InfoKind {
        case 0:
            return 4
        case 1:
            return GetInfo.count
        default:
            return 0
        }
        */
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch InfoKind {
        case 2:
            return inoutinfo.count
        case 3:
            return breakinfo.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarDetailCell", for: indexPath) as! CarDetailTableViewCell
        
        switch InfoKind {
        case 2:
            if inoutinfo[indexPath.row].inTime != nil {
                let intime = changetime(time: inoutinfo[indexPath.row].inTime)
                if inoutinfo[indexPath.row].inGate != nil {
                    if inoutinfo[indexPath.row].inGate > 11 || inoutinfo[indexPath.row].inGate < 1{
                        cell.TimeLabel.text = "进：" + intime + "," + "未知地点"
                    }else{
                        cell.TimeLabel.text = "进：" + intime + "," + location[inoutinfo[indexPath.row].inGate]
                    }
                }else{
                    cell.TimeLabel.text = "进：" + intime + "," + "未知地点"
                }
            }else{
                if inoutinfo[indexPath.row].inGate != nil {
                    if inoutinfo[indexPath.row].inGate > 11 || inoutinfo[indexPath.row].inGate < 1{
                        cell.TimeLabel.text = "进：" + "未知时间" + "," + "未知地点"
                    }else{
                        cell.TimeLabel.text = "进：" + "未知时间" + "," + location[inoutinfo[indexPath.row].inGate]
                    }
                }else{
                    cell.TimeLabel.text = "进：" + "未知时间" + "," + "未知地点"
                }
            }
            
            if inoutinfo[indexPath.row].outTime != nil {
                let outtime = changetime(time: inoutinfo[indexPath.row].outTime)
                if inoutinfo[indexPath.row].outGate != nil {
                    if inoutinfo[indexPath.row].outGate > 11 || inoutinfo[indexPath.row].outGate < 1{
                        cell.InfoLabel.text = "出：" + outtime + "," + "未知地点"
                    }else{
                        cell.InfoLabel.text = "出：" + outtime + "," + location[inoutinfo[indexPath.row].outGate]
                    }
                }else{
                    cell.InfoLabel.text = "出：" + outtime + "," + "未知地点"
                }
            }else{
                if inoutinfo[indexPath.row].outGate != nil {
                    if inoutinfo[indexPath.row].outGate > 11 || inoutinfo[indexPath.row].outGate < 1{
                        cell.InfoLabel.text = "出：" + "未知时间" + "," + "未知地点"
                    }else{
                        cell.InfoLabel.text = "出：" + "未知时间" + "," + location[inoutinfo[indexPath.row].outGate]
                    }
                }else{
                    cell.InfoLabel.text = "出：" + "未知时间" + "," + "未知地点"
                }
            }
            break
        case 3:
            if breakinfo[indexPath.row].id != nil {
                if breakinfo[indexPath.row].car != nil {
                    cell.InfoLabel.text = "罚单编号:" + String(breakinfo[indexPath.row].id) + "     " + "违章车辆编号:" + breakinfo[indexPath.row].car
                }else{
                    cell.InfoLabel.text = "罚单编号:" + String(breakinfo[indexPath.row].id) + "     " + "违章车辆编号:" + "未知车辆编号"
                }
            }else{
                if breakinfo[indexPath.row].car != nil {
                    cell.InfoLabel.text = "未知罚单编号" + "     " + breakinfo[indexPath.row].car
                }else{
                    cell.InfoLabel.text = "未知罚单编号" + "     " + "未知车辆编号"
                }
            }
            if breakinfo[indexPath.row].time != nil {
                let timestring = changetime(time: breakinfo[indexPath.row].time)
                cell.TimeLabel.text = "违章时间:" + timestring
            }else{
                cell.TimeLabel.text = "违章时间:" + "未知时间"
            }
        default:
            break
        }
        return cell
    }

    
    func changetime(time:Int) -> String {
        let inttime = time/1000
        let timestamp = TimeInterval(inttime)
        let timedate = Date(timeIntervalSince1970: timestamp)
        let dateform = DateFormatter()
        dateform.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateform.string(from: timedate)
    }

    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
