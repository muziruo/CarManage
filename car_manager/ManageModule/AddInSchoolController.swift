//
//  AddInSchoolController.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/30.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class AddInSchoolController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    @IBOutlet var carIdTextfield: UITextField!
    @IBOutlet var textfield: UITextField!
    var pickerView = UIPickerView()
    
    var currentLocation = "余区"
    let location = ["余区","南湖","鉴湖","西院","东院"]
    let schoolGate = ["余区":["友谊大道门","和平大道门"],
                      "南湖":["东门","文治街门","雄楚大道门"],
                      "鉴湖":["雄楚大道门","工大路门",""],
                      "西院":["珞狮路门","工大路门",],
                      "东院":["珞狮路门","桂珞路门"]]
    var gateRow = 0
    
    @IBAction func inSchool(){
        
        if carIdTextfield.text!.characters.count == 0 {
            let alertController = UIAlertController(title: "提示", message: "车牌号信息不能为空", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }else if((carIdTextfield.text!.characters.count) > String.IndexDistance(8)){
            let alertController = UIAlertController(title: "提示", message: "车牌号信息格式错误", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }else if (textfield.text == ""){
            let alertController = UIAlertController(title: "提示", message: "请选择进校门口", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }else{
            var car = carIdTextfield.text
            var gate = textfield.text
            //发起网络请求
            
            let alertController = UIAlertController(title: "提示", message: "添加成功", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = true
        textfield.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        //        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.plain, target: self, action: #selector(done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancel))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        textfield.inputView = pickerView
        textfield.inputAccessoryView = toolBar
    }
    
    func cancel() {
        textfield.resignFirstResponder()
    }
    func done() {
        textfield.text = location[pickerView.selectedRow(inComponent: 0)]+"-"+schoolGate[location[pickerView.selectedRow(inComponent: 0)]]![pickerView.selectedRow(inComponent: 1)]
        textfield.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return location.count
        }else{
            return (schoolGate[currentLocation]?.count)!
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return location[row]
        }else{
            return schoolGate[currentLocation]?[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            currentLocation = location[row]
            pickerView.reloadComponent(1)
        }
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
