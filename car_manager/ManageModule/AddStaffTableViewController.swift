//
//  AddStaffTableViewController.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/26.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class AddStaffTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,
UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var haveCarSwitch: UISwitch!
    @IBOutlet var button: UIButton!
    
    var pickerView = UIPickerView()
    
    let carinfo = ["车牌号","类型","车辆型号","颜色","座位数"]
    let cartype = ["校车","教职工车","社会车"]
    
//    let identifier = String(describing: BasisCell.self)
//    let NibName = String(describing: BasisCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        let nib = UINib(nibName: NibName, bundle: nil)
        tableView.register(BasisCell.self, forCellReuseIdentifier: "staffCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        if haveCarSwitch.isOn{
//            return 2
//        }else{
//            return super.numberOfSections(in: tableView)
//        }
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1{
            return carinfo.count
        }else{
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    @IBAction func selectPhoto(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let photo = info[UIImagePickerControllerOriginalImage]
        photoView.image = photo as? UIImage
        photoView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }

//    func registerTableViewCell() {
//        let nib = UINib(nibName: NibName, bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: identifier)
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            return super.tableView(tableView, cellForRowAt: indexPath)
        }else{
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "staffCell", for: indexPath) as! BasisCell
                cell.textField.placeholder = "请选择类型"
                cell.textField.tag = 1
                pickerView.translatesAutoresizingMaskIntoConstraints = true
                pickerView.delegate = self
                pickerView.dataSource = self
                cell.textField.inputView = pickerView
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "staffCell", for: indexPath) as! BasisCell
                cell.titleLable.text = carinfo[indexPath.row]
                cell.textField.placeholder = "请输入"+carinfo[indexPath.row]
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 1 {
            return super.tableView(tableView, indentationLevelForRowAt: IndexPath(row: 0, section: 1))
        }else{
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 44
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let label = view.viewWithTag(1) as! UITextField
        label.text = cartype[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cartype.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cartype[row]
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
