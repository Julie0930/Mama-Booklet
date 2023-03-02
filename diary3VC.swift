//
//  diary3VC.swift
//  Mama
//
//  Created by AA101 on 2020/10/22.
//

import UIKit

class diary3VC: UIViewController, GetData1, GetData2 {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SicknessPage" {
           let aViewController = segue.destination as! Sickness_RC_VC
            aViewController.delegate = self
        }
        else if segue.identifier == "MedicinePage" {
           let bViewController = segue.destination as! MedicineVC
            bViewController.delegate = self
        }
    }
    
    func receiveData(data: String) {
       
       txtbody.text += data + "\t"
    }
      
    let re = WebService()
    @IBOutlet weak var txtbody: UITextView!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var textdescribe: UITextView!
    @IBOutlet weak var textother: UITextField!
    @IBOutlet weak var donebtn: UIButton!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textid: UILabel!
    @IBOutlet weak var texttype: UILabel!
    @IBOutlet weak var textbool: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.txtbody.isUserInteractionEnabled=false
        textdescribe.inputAccessoryView=toolbar
        textother.inputAccessoryView=toolbar
        textid.text = "F229419527"

        //txtbody.isHidden=true
        // Do any additional setup after loading the view.
        //Timer
        let now=Date()
        let formatter=DateFormatter()
        formatter.dateFormat="yyyy/MM/dd"
        let time=formatter.string(from: (now))
        datelabel.text=time
        
        //display
        texttype.text = "身體"
        textbool.text = re.Diarybool(id: textid.text!, date: datelabel.text!, type: texttype.text!)
        if(textbool.text == "true"){
            txtbody.text = re.DiaryBody(id: textid.text! ,date: datelabel.text!)
            textdescribe.text = re.DiaryBodyDes(id: textid.text! ,date: datelabel.text!)
        }
        else{
            let alert = UIAlertController(title: "您還未做任何填寫哦～", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @IBAction func datePickerChange(_ sender: Any) {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat="yyyy/MM/dd"
            //dateFormatter.dateStyle = DateFormatter
            //dateFormatter.timeStyle = DateFormatter.Style.short

            let strDate = dateFormatter.string(from: datePicker.date)
            datelabel.text = strDate
       
        //display
        txtbody.text = nil
        textdescribe.text = nil
        textbool.text = re.Diarybool(id: textid.text!, date: datelabel.text!, type: texttype.text!)
        if(textbool.text == "true"){
            txtbody.text = re.DiaryBody(id: textid.text! ,date: datelabel.text!)
            textdescribe.text = re.DiaryBodyDes(id: textid.text! ,date: datelabel.text!)
        }
        else{
            let alert = UIAlertController(title: "您還未做任何填寫哦～", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @IBAction func pain(_ sender: Any) {
        txtbody.text+="乳房疼痛\t"
    }
    
    @IBAction func constipation(_ sender: Any) {
        txtbody.text+="便秘\t"
    }
    
    @IBAction func Bleeding(_ sender: Any) {
        txtbody.text+="出血\t"
    }
    
    @IBAction func nausea(_ sender: Any) {
        txtbody.text+="反胃\t"
    }
    
    @IBAction func Sickness(_ sender: Any) {
        //txtbody.text+="害喜\t"
        //跳轉頁面
        /*if let controller = storyboard?.instantiateViewController(withIdentifier: "oncePage") {
            present(controller, animated: true, completion: nil)
        }*/
    }
    
    @IBAction func Sleepy(_ sender: Any) {
        txtbody.text+="犯睏\t"
    }
    
    @IBAction func movement(_ sender: Any) {
        txtbody.text+="胎動\t"
    }
    
    @IBAction func Backpain(_ sender: Any) {
        txtbody.text+="腰痛\t"
    }
    
    @IBAction func stomachache(_ sender: Any) {
        txtbody.text+="腹痛\t"
    }
    
    @IBAction func anemia(_ sender: Any) {
        txtbody.text+="貧血\t"
    }
    
    @IBAction func medicine(_ sender: Any) {
        //txtbody.text+="服藥\t"
        //跳轉頁面
        /*if let controller = storyboard?.instantiateViewController(withIdentifier: "twicePage") {
            present(controller, animated: true, completion: nil)
        }*/
    }
    
    @IBAction func Defecation(_ sender: Any) {
        txtbody.text+="排便\t"
    }
    
    @IBAction func allergy(_ sender: Any) {
        txtbody.text+="皮膚過敏\t"
    }
    
    @IBAction func cramp(_ sender: Any) {
        txtbody.text+="腿抽筋\t"
    }
    
    
    @IBAction func dizziness(_ sender: Any) {
        txtbody.text+="頭暈\t"
    }
    
    @IBAction func Jointpain(_ sender: Any) {
        txtbody.text+="關節痛\t\t"
    }
    @IBAction func headache(_ sender: Any) {
        txtbody.text+="頭痛\t"
    }
    
    @IBAction func edema(_ sender: Any) {
        txtbody.text+="浮腫\t"
    }
    
    @IBAction func exhausted(_ sender: Any) {
        txtbody.text+="疲憊\t"
    }
    
    @IBAction func Leucorrhea(_ sender: Any) {
        txtbody.text+="褐色白帶\t"
    }
    
    @IBAction func otherbtn(_ sender: Any) {
        textother.isHidden = false
        donebtn.isHidden = false
    }
    
    @IBAction func DoneEnter(_ sender: Any) {
        if(textother.text == "")
        {
            let alert = UIAlertController(title: "錯誤", message: "您還未輸入任何狀況喔", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else
        {
            txtbody.text+=textother.text! + "\t"
            textother.isHidden = true
            donebtn.isHidden = true
            textother.text = ""
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donebuttonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.8){
            self.textdescribe.resignFirstResponder()
            self.textother.resignFirstResponder()
        }
    }
    
    @IBAction func savebtn(_ sender: Any) {
        if(txtbody.text == "" && textdescribe.text == ""){
            let alert = UIAlertController(title: "未填寫", message: "請確實填寫", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else{
            re.InertDiary(id: textid.text!, date: datelabel.text!, mood: "", mooddes: "", body: txtbody.text!, bodydes: textdescribe.text!)
            let alert = UIAlertController(title: "已填寫", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
                //dismiss(animated: true, completion: nil)
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
