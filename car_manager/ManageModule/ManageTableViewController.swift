//
//  ManageTableViewController.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/15.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import SVProgressHUD

class ManageTableViewController: UITableViewController {
    
    var functions = [["添加教职工","添加车辆","添加用户","添加单位","添加通行证","添加黑名单"],["删除用户","移除黑名单"]]
    let Kinds = ["staff","car","user","post","passcard","blacklist"]
    let delete = ["deleteUser","deleteBlackList"]
    var type = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.dismiss()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.tableFooterView = UIView(frame: .zero)
//        let type = UserDefaults.standard.value(forKey: "usertype")
//        if type == 1{
//            let view
//        }
        let user = UserDefaults.standard
        
        type = user.value(forKey: "usertype") as! Int
        
        if type == 2 {
            let whiteview = UIView()
            whiteview.frame = tableView.frame
            whiteview.backgroundColor = UIColor.white
            
            view.addSubview(whiteview)
            view.bringSubview(toFront: whiteview)
            
            let noticelabel = UILabel()
            let width = view.frame.width
            noticelabel.adjustsFontSizeToFitWidth = true
            noticelabel.numberOfLines = 0
            noticelabel.frame = CGRect(x: 0, y: 100, width: width, height: 30)
            noticelabel.center = whiteview.center
            noticelabel.textAlignment = .center
            noticelabel.text = "您不是管理员，无权限进行管理"
            noticelabel.font = UIFont(name: "Avenir-Light", size: 15)
            whiteview.addSubview(noticelabel)
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if type == 2 {
            return 0
        }
        return 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return functions.count
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return functions[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageCell", for: indexPath) as! ManageTableViewCell

        // Configure the cell...
        cell.label?.text = functions[indexPath.section][indexPath.row]
        cell.label.font = UIFont(name: "Avenir-Light", size: 16)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "addStaffSegue", sender: nil)
                break
            case 1:
                performSegue(withIdentifier: "addUserSegue", sender: nil)
                break
            case 2:
                performSegue(withIdentifier: "addUserSegue", sender: nil)
                break
            case 3:
                performSegue(withIdentifier: "addUserSegue", sender: nil)
                break
            case 4:
                performSegue(withIdentifier: "addUserSegue", sender: nil)
            case 5:
                performSegue(withIdentifier: "addUserSegue", sender: nil)
                break
            default:
                break
            }
        }else{
            switch indexPath.row{
            case 0:
                performSegue(withIdentifier: "deleteSegue", sender: nil)
                break
            case 1:
                performSegue(withIdentifier: "deleteBlackListSegue", sender: nil)
                break
            default:
                break
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addUserSegue" {
            let dest = segue.destination as! AddUserTableViewController
            dest.currentType = Kinds[(tableView.indexPathForSelectedRow?.row)!]
        }else if segue.identifier == "deleteSegue"{
            let dest = segue.destination as! DeleteUserController
            dest.currntType = delete[(tableView.indexPathForSelectedRow?.row)!]
        }
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
