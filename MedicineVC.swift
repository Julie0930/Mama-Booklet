//
//  MedicineVC.swift
//  Mama
//
//  Created by AA101 on 2020/12/17.
//

import UIKit

protocol GetData2: class {
    func receiveData(data: String)
}

class MedicineVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: GetData2?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var textview: UITextView!
    
    let medicine = ["綜合維他命", "葉酸", "DHA鈣片", "Ｂ群"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row:Int, forComponent component: Int) -> String? {
        return medicine[row]
    }
    
    func pickerView(_ pickerView:UIPickerView, numberOfRowsInComponent compoent: Int) -> Int {
        return medicine.count
    }
    
    func pickerView(_ pickerView:UIPickerView, didSelectRow row:Int, inComponent component: Int) {
        label.text = medicine[row]
        
        if(label.text == "葉酸")
        {
            textview.text = "依據美國實證研究顯示，孕期攝取足夠的葉酸可以預防胎兒腦及脊髓的先天性神經管缺陷的比例，可減少50-70%胎兒的腦及脊髓的先天性神經管缺陷的發生。葉酸廣泛存在於許多食物中，如：綠色蔬菜、肝臟、酵母、豆類及水果(如柑橘類)，都是豐富的來源，葉酸攝取建議應優先由天然食物中多樣攝取。如果在日常飲食中攝取不足，建議在醫師處方指導下，補充葉酸錠劑。"
        }
        else if(label.text == "綜合維他命")
        {
            textview.text = "高單位維他命B群，能有效地補充婦女朋友每月流失的鐵劑與懷孕期體內所不足的葉酸，懷孕早期補充紐萊特孕維他-B群+葉酸維他命B群與葉酸，可以降低胎兒發生神經管缺陷的機會。\n\n\n另外補充:\n但要注意只有在懷孕期間患糖尿病的女性才應該攝取那麼多的維他命B群，而在懷孕的最後一個月只需要攝取到100毫克的維他命B群。對於其他孕婦來說，每天大約攝取25-50毫克的維他命B群。"
        }
        else if(label.text == "DHA鈣片")
        {
            textview.text = "胎兒在母體中即開始累積DHA於大腦中，其中以產前三個月及出生後三個月中累積速度最快，而胎兒之DHA是來自母體所供給的營養，而出生後，嬰兒則 需由飲食中攝取，母乳則是小寶寶最自然，最充份的DHA來源，尤其是初乳DHA的含量會更高。新生兒若餵予母乳則會比餵予嬰兒奶粉者得到更多的DHA，使得寶寶更聰明。"
        }
        else if(label.text == "Ｂ群")
        {
            textview.text = "高單位維他命B群，能有效地補充婦女朋友每月流失的營養與懷孕期體內所不足的維生素，讓容易勞累的媽咪，迅速補充體力，但要注意只有在懷孕期間患糖尿病的女性才應該攝取那麼多的維他命B群，而在懷孕的最後一個月只需要攝取到100毫克的維他命B群。對於其他孕婦來說，每天大約攝取25-50毫克的維他命B群。"
        }
    }
    
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var enterbtn: UIButton!
    @IBOutlet weak var txtother: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtother.inputAccessoryView=toolbar
        
        if(label.text == "綜合維他命")
        {
            textview.text = "高單位維他命B群，能有效地補充婦女朋友每月流失的鐵劑與懷孕期體內所不足的葉酸，懷孕早期補充紐萊特孕維他-B群+葉酸維他命B群與葉酸，可以降低胎兒發生神經管缺陷的機會。\n\n\n另外補充:\n但要注意只有在懷孕期間患糖尿病的女性才應該攝取那麼多的維他命B群，而在懷孕的最後一個月只需要攝取到100毫克的維他命B群。對於其他孕婦來說，每天大約攝取25-50毫克的維他命B群。"
        }
    }
    @IBAction func donebuttonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.5){
            self.txtother.resignFirstResponder()
        }
    }
    
    @IBAction func otherbtn(_ sender: Any) {
        txtother.isHidden = false
        enterbtn.isHidden = false
    }
    
    @IBAction func EnterBtn(_ sender: Any) {
        if(txtother.text?.isEmpty==true)
        {
            let controller = UIAlertController(title: "請輸入您服用的藥種", message: "您沒有做輸入喔", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
        else
        {
            label.text!+="\t"+txtother.text!
            txtother.text=""
            UIView.animate(withDuration: 0.3){
                self.txtother.resignFirstResponder()
        }
        }
    }
    @IBAction func savebtn(_ sender: Any) {
        
        delegate?.receiveData(data: label.text!)
        let alert = UIAlertController(title: "已儲存", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
        present(alert, animated: true)
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
