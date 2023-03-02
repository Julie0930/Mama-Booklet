//
//  ModifyDetailVC.swift
//  Mama
//
//  Created by AA101 on 2020/12/10.
//

import UIKit
import Vision

class ModifyDetailVC: UIViewController {
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var textname: UITextField!
    @IBOutlet weak var textid: UITextField!
    @IBOutlet weak var textnum: UITextField!
    @IBOutlet weak var textpassword: UITextField!
    @IBOutlet weak var textbirthday: UITextField!
    @IBOutlet weak var textER1: UITextField!
    @IBOutlet weak var textER1num: UITextField!
    @IBOutlet weak var textER2: UITextField!
    @IBOutlet weak var textER2num: UITextField!
    
    var id: String?
    let re = WebService()
    let datePicker = UIDatePicker()
    
    struct MamaDetail: Codable {
        let Birthday:String?
        let Id:String?
        let Telephone:String?
        let Pwd: String?
        let EmergencyTelephone1: String?
        let EmergencyTelephone2: String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textname.inputAccessoryView=toolbar
        textnum.inputAccessoryView=toolbar
        textpassword.inputAccessoryView=toolbar
        textER1.inputAccessoryView=toolbar
        textER1num.inputAccessoryView=toolbar
        textER2.inputAccessoryView=toolbar
        textER2num.inputAccessoryView=toolbar
        textid.text = id

        
        //display information_XML
        textname.text = re.Modifyname(id: id!)
        textER1.text = re.ModifyEC1(id: id!)
        textER2.text = re.ModifyEC2(id: id!)

        //display information_Json
        let res = re.MaMaModify(id: id!)
        var data = res.data(using: .utf8)
        do{
            let decoder: JSONDecoder = JSONDecoder()
            let decoded = try decoder.decode(MamaDetail.self, from: data!)
            textid.text = decoded.Id!
            textpassword.text = decoded.Pwd!
            textbirthday.text = decoded.Birthday!
            textnum.text = decoded.Telephone!
            textER1num.text = decoded.EmergencyTelephone1!
            textER2num.text = decoded.EmergencyTelephone2!
        }
        catch{
            
        }
        
        if(textER2.text == "無" && textER2num.text == "0"){
            textER2.text = nil
            textER2num.text = nil
        }
        
        //birthday
        createDatePicker()
    }
    
    func createDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        textbirthday.inputAccessoryView = toolbar
        
        //assign date picker to the text field
        textbirthday.inputView = datePicker
        
        //date Picker mode
        datePicker.datePickerMode = .date
    }
    
    @objc func  donePressed() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy/MM/dd"
        textbirthday.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    
    @IBAction func savebtn(_ sender: Any) {
        if (textpassword.text == "" && textname.text == "" && textnum.text == "" && textER1.text == "" && textER1num.text == "" )
        {
            let alert = UIAlertController(title: "未填寫", message: "請確實填寫", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else{
            re.Updateregistered2(id:textid.text!, pwd:textpassword.text!, name:textname.text!, telephone:textnum.text!, birthday:textbirthday.text!, emergencyContact1:textER1.text!, emergencyTelephone1:textER1num.text!, emergencyContact2:textER2.text!, emergencyTelephone2:textER2num.text!)
            let alert = UIAlertController(title: "已修改", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
            //dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func donebuttonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.textname.resignFirstResponder()
            self.textnum.resignFirstResponder()
            self.textpassword.resignFirstResponder()
            self.textER1.resignFirstResponder()
            self.textER1num.resignFirstResponder()
            self.textER2.resignFirstResponder()
            self.textER2num.resignFirstResponder()
        }
    }
    
    @IBAction func Cancelbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //隱藏上方欄位
    override var prefersStatusBarHidden: Bool{
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
