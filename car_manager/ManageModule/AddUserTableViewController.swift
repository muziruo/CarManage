//
//  AddUserTableViewController.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/22.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class AddUserTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource{

    var currentType = "user"
//    var addUserTitle = ["用户编号（职工号）","密码","权限"]
//    var permissions = ["管理员","普通用户"]
    var titles = ["user":["用户编号（职工号）","密码","权限"],
                  "post":["编号","名称","电话"],
                  "car":["车牌号","类型","车辆型号","颜色","座位数"],
                  "passcard":["车牌号","类型","开始时间","结束时间","费用","车主"],
                  "blacklist":["车牌号"]]
    var pickViewItem = ["user":["普通用户","管理员"],
                        "car":[["校车","教职工车","社会车"]],
                        "passcard":["校车","教职工车","社会车"]]
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.separatorStyle = .none
        title = "添加用户"
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles[currentType]!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basisCell", for: indexPath) as! BasisCell
        switch currentType {
        case "user":
            cell.titleLable.text = titles[currentType]![indexPath.row]
            if indexPath.row == 2{
                cell.textField.placeholder = "请选择权限"
                cell.textField.tag = 1
                pickerView.translatesAutoresizingMaskIntoConstraints = true
                pickerView.delegate = self
                pickerView.dataSource = self
                cell.textField.inputView = pickerView
            }else{
                cell.textField.placeholder = "请输入"+titles[currentType]![indexPath.row]
            }
        case "car":
            cell.titleLable.text = titles[currentType]![indexPath.row]
            if indexPath.row == 1{
                cell.textField.placeholder = "请选择类型"
                cell.textField.tag = 1
                pickerView.translatesAutoresizingMaskIntoConstraints = true
                pickerView.delegate = self
                pickerView.dataSource = self
                cell.textField.inputView = pickerView
            }else{
                cell.textField.placeholder = "请输入"+titles[currentType]![indexPath.row]
            }
        case "passcard":
            cell.titleLable.text = titles[currentType]![indexPath.row]
            if indexPath.row == 1{
                cell.textField.placeholder = "请选择类型"
                cell.textField.tag = 1
                pickerView.translatesAutoresizingMaskIntoConstraints = true
                pickerView.delegate = self
                pickerView.dataSource = self
                cell.textField.inputView = pickerView
            }else{
                cell.textField.placeholder = "请输入"+titles[currentType]![indexPath.row]
            }
        default:
            break
        }
        
        return cell
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let label = view.viewWithTag(1) as! UITextField
        label.text = pickViewItem["user"]![row] as? String
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickViewItem[currentType]!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickViewItem[currentType]![row] as? String
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
