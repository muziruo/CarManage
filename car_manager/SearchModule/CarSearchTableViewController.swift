//
//  CarSearchTableViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/15.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class CarSearchTableViewController: UITableViewController {
    
    @IBOutlet weak var InputNum: UITextField!
    @IBOutlet weak var CarNum: UILabel!
    @IBOutlet weak var Owner: UILabel!
    @IBOutlet weak var CarKind: UILabel!
    @IBOutlet weak var PassDocumentInfo: UILabel!
    @IBOutlet weak var PassInfo: UILabel!
    @IBOutlet weak var UpholdInfo: UILabel!
    @IBOutlet weak var AddInfo: UILabel!
    @IBOutlet weak var BreakInfo: UILabel!
    
    var GetCarInfo:CarInfo!
    
    //查询操作
    @IBAction func SearchActivity(_ sender: UIButton) {
        SVProgressHUD.show()
        
        let userinput:String = InputNum.text!
        if userinput == "" {
            let notice = UIAlertController(title: "警告", message: "查询编号不能为空!", preferredStyle: .alert)
            let noticeaction = UIAlertAction(title: "好的", style: .default, handler: nil)
            notice.addAction(noticeaction)
            self.present(notice, animated: true, completion: nil)
        }else{
            /*
            let url:URL = URL(string: "https://car.wuruoye.com/car/query_car_detail")!
            let prameters = ["id":userinput]
            Alamofire.request(url, method: .get, parameters: prameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
            
            })
            */
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
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
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
