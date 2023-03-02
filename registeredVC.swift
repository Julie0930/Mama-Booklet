//
//  registeredVC.swift
//  Mama
//
//  Created by AA101 on 2020/10/8.
//

import UIKit
import Vision

protocol GetData: class{
    func receiveData1(data1: String)
}

class registeredVC: UIViewController {

    var changeC: String = ""
    
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
    
    let datePicker = UIDatePicker()
    
    var request = VNRecognizeTextRequest(completionHandler: nil)
    weak var delegate: GetData?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textname.inputAccessoryView=toolbar
        textid.inputAccessoryView=toolbar
        textnum.inputAccessoryView=toolbar
        textpassword.inputAccessoryView=toolbar
        textER1.inputAccessoryView=toolbar
        textER1num.inputAccessoryView=toolbar
        textER2.inputAccessoryView=toolbar
        textER2num.inputAccessoryView=toolbar
        
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
    
    @IBAction func backbtnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savebtnClick(_ sender: Any) {
        if(textid.text == "" && textpassword.text == "" && textname.text == "" && textnum.text == "" && textbirthday.text == "" && textER1.text == "" && textER1num.text == "" ){
            let alert = UIAlertController(title: "未填寫", message: "請確實填寫", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else{
            let sign = WebService()
            sign.Insertregistered2(id:textid.text!, pwd:textpassword.text!, name:textname.text!, telephone:textnum.text!, birthday:textbirthday.text!, emergencyContact1:textER1.text!, emergencyTelephone1:textER1num.text!, emergencyContact2:textER2.text!, emergencyTelephone2:textER2num.text!)
            let alert = UIAlertController(title: "已註冊", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
                //dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func donebuttonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.textname.resignFirstResponder()
            self.textid.resignFirstResponder()
            self.textnum.resignFirstResponder()
            self.textpassword.resignFirstResponder()
            self.textER1.resignFirstResponder()
            self.textER1num.resignFirstResponder()
            self.textER2.resignFirstResponder()
            self.textER2num.resignFirstResponder()
        }
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
