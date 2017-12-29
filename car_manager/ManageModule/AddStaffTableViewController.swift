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
    
    //教职工信息textfield
    @IBOutlet var nameTextfiled: UITextField!
    @IBOutlet var partTextfield: UITextField!
    @IBOutlet var idTextfield: UITextField!
    //车辆信息textfield
    @IBOutlet var carIdTextfield: UITextField!
    @IBOutlet var carTypeTextfield: UITextField!
    @IBOutlet var carModelTextfield: UITextField!
    @IBOutlet var carColorTextfield: UITextField!
    @IBOutlet var carSeatTextfield: UITextField!
    
    var pickerView = UIPickerView()
    
    let carinfo = ["车牌号","类型","车辆型号","颜色","座位数"]
    let cartype = ["校车","教职工车","社会车"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        haveCarSwitch.addTarget(self, action: #selector(reload), for: .valueChanged)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = true
        carTypeTextfield.inputView = pickerView
        
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.blue
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1.5
        button.clipsToBounds = true
 
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.plain, target: self, action: #selector(done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        carTypeTextfield.inputView = pickerView
        carTypeTextfield.inputAccessoryView = toolBar
        
        haveCarSwitch.isOn = false
    }
    
    func back() {
        carTypeTextfield.resignFirstResponder()
    }
    func done() {
        carTypeTextfield.text = cartype[pickerView.selectedRow(inComponent: 0)]
        carTypeTextfield.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if haveCarSwitch.isOn {
            return 2
        }else{
            return 1
        }
    }
    
    func reload() {
        tableView.reloadData()
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
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if haveCarSwitch {
//            <#code#>
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if !haveCarSwitch.isOn{
//            if indexPath.section == 1{
//
//            }
//        }
//        return super.tableView(tableView, cellForRowAt: indexPath)
//    }
    
    
    
    //pickerview setting
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        carTypeTextfield.text = cartype[row]
//    }
    
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
