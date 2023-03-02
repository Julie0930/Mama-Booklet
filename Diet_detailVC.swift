//
//  Diet_detailVC.swift
//  Mama
//
//  Created by AA101 on 2020/11/23.
//

import UIKit

class Diet_detailVC: UIViewController {

    let re = WebService()
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var txteat: UITextField!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var textid: UILabel!
    @IBOutlet weak var textdate: UILabel!
    @IBOutlet weak var textindex: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textbool: UILabel!
    @IBOutlet weak var txtdate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        image.image = UIImage(named: "breakfast")
        txteat.inputAccessoryView=toolbar
        textid.text = "F229419527"
        textindex.text = "早餐"
        
        //time
        let now=Date()
        let formatter=DateFormatter()
        let formatter2=DateFormatter()
        formatter.dateFormat="yyyy-MM-dd HH:mm"
        formatter2.dateFormat="yyyy-MM-dd"
        let time=formatter.string(from: (now))
        let time2=formatter2.string(from: (now))
        textdate.text=time
        txtdate.text=time2
        
        //Display
        textbool.text = re.FoodBool(id: textid.text!, time: textindex.text!, date: txtdate.text!)
        if(textbool.text == "true"){
            txteat.text = re.FoodContent(id: textid.text!, time: textindex.text!, date: txtdate.text!)
        }
        else{
            let alert = UIAlertController(title: "您還未做任何填寫哦～", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @IBAction func datePickerChange(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="yyyy-MM-dd HH:mm"
        let strDate = dateFormatter.string(from: datePicker.date)
        textdate.text = strDate
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat="yyyy-MM-dd"
        let strDate2 = dateFormatter2.string(from: datePicker.date)
        txtdate.text = strDate2

        //Display
        txteat.text = nil
        textbool.text = re.FoodBool(id: textid.text!, time: textindex.text!, date: txtdate.text!)
        if(textbool.text == "true"){
            txteat.text = re.FoodContent(id: textid.text!, time: textindex.text!, date: txtdate.text!)
        }
        else{
            let alert = UIAlertController(title: "您還未做任何填寫哦～", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @IBAction func Donebtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choosebool(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0{
            image.image = UIImage(named: "breakfast")
            textindex.text = "早餐"
            txteat.text = nil
            textbool.text = re.FoodBool(id: textid.text!, time: textindex.text!, date: txtdate.text!)
            if(textbool.text == "true"){
                txteat.text = re.FoodContent(id: textid.text!, time: textindex.text!, date: txtdate.text!)
            }
            else{
                let alert = UIAlertController(title: "您還未做任何填寫哦～", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
            }
        }
        else if sender.selectedSegmentIndex==1{
            image.image = UIImage(named: "lunch")
            textindex.text = "午餐"
            txteat.text = nil
            textbool.text = re.FoodBool(id: textid.text!, time: textindex.text!, date: txtdate.text!)
            if(textbool.text == "true"){
                txteat.text = re.FoodContent(id: textid.text!, time: textindex.text!, date: txtdate.text!)
            }
            else{
                let alert = UIAlertController(title: "您還未做任何填寫哦～", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
            }
        }
        else if sender.selectedSegmentIndex==2{
            image.image = UIImage(named: "dinner")
            textindex.text = "晚餐"
            txteat.text = nil
            textbool.text = re.FoodBool(id: textid.text!, time: textindex.text!, date: txtdate.text!)
            if(textbool.text == "true"){
                txteat.text = re.FoodContent(id: textid.text!, time: textindex.text!, date: txtdate.text!)
            }
            else{
                let alert = UIAlertController(title: "您還未做任何填寫哦～", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
            }
        }
    }
    
    @IBAction func savebtn(_ sender: Any) {
        if(txteat.text! == ""){
            let alert = UIAlertController(title: "您未作任何填寫喔", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else{
            re.InertFood(id: textid.text!, time: textindex.text!, date: textdate.text!, food: txteat.text!)
            let alert = UIAlertController(title: "已儲存", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @IBAction func donebuttonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.txteat.resignFirstResponder()
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
