//
//  Record_DetailVC.swift
//  Mama
//
//  Created by AA101 on 2020/11/24.
//

import UIKit

class Record_DetailVC: UIViewController {
    
    let re = WebService()
    @IBOutlet weak var lblnumber: UILabel!
    @IBOutlet weak var lblnumrecord: UITextField!
    @IBOutlet weak var secondview: UIView!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var firstview: UIView!
    @IBOutlet weak var lblnumrecord2: UITextField!
    @IBOutlet weak var textID: UILabel!
    @IBOutlet weak var textParity: UILabel!
    @IBOutlet weak var textID2: UILabel!
    @IBOutlet weak var textParity2: UILabel!
    @IBOutlet weak var scroller1: UIScrollView!
    @IBOutlet weak var scroller2: UIScrollView!
    @IBOutlet weak var textview1: UITextView!
    @IBOutlet weak var textview2: UITextView!
    @IBOutlet weak var RecordTime1: UILabel!
    @IBOutlet weak var DueDate1: UILabel!
    @IBOutlet weak var PregnantWeek1: UILabel!
    @IBOutlet weak var RecordTime2: UILabel!
    @IBOutlet weak var DueDate2: UILabel!
    @IBOutlet weak var PregnantWeek2: UILabel!
    var str: String?
    var id:String?
    var parity:String?
    var number:Int?
    
    //parity content
    @IBOutlet weak var weight1: UILabel!
    @IBOutlet weak var high_blood1: UILabel!
    @IBOutlet weak var low_blood1: UILabel!
    @IBOutlet weak var Rh_reason: UILabel!
    @IBOutlet weak var Blood: UILabel!
    @IBOutlet weak var WBC: UILabel!
    @IBOutlet weak var RBC: UILabel!
    @IBOutlet weak var PLT: UILabel!
    @IBOutlet weak var HCT: UILabel!
    @IBOutlet weak var HB: UILabel!
    @IBOutlet weak var MCV: UILabel!
    @IBOutlet weak var parity_reason: UILabel!
    
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var high_blood: UILabel!
    @IBOutlet weak var low_blood: UILabel!
    @IBOutlet weak var sugar_blood: UILabel!
    @IBOutlet weak var Urineprotein: UILabel!
    @IBOutlet weak var parity_reason2: UILabel!
    
    @IBOutlet weak var textother1: UITextField!
    @IBOutlet weak var textother2: UITextField!
    
    //Json
    struct Product: Codable {
        let Weight:String?
        let SystolicBP:String?
        let DiastolicBP:String?
        let RhFactor: String?
        let BloodType: String?
        let WBC: String?
        let RBC: String?
        let Plt: String?
        let Hct: String?
        let Hb: String?
        let MCV: String?
        let RecordTime: String?
        let DueDate: String?
        let PregnantWeek: String?
    }
    struct Product2: Codable {
        let Weight:String?
        let SystolicBP:String?
        let DiastolicBP:String?
        let RecordTime: String?
        let DueDate: String?
        let PregnantWeek: String?
        let UrineSugar: String?
        let UrineProtein:String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //segue ??????
        lblSecond.text = str
        lblnumber.text = str
        textID.text = id!
        textParity.text = parity!
        textID2.text = id!
        textParity2.text = parity!
        
        //parity number
        if(lblnumber.text == "???1???????????????"){
            lblnumber.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "1"
            number = 1
            scroller2.isHidden = true
            scroller1.isHidden = false
        }
        else if(lblSecond.text == "???2???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "2"
            number = 2
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???3???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "3"
            number = 3
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???4???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "4"
            number = 4
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???5???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "5"
            number = 5
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???6???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "6"
            number = 6
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???7???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "7"
            number = 7
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???8???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "8"
            number = 8
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???9???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "9"
            number = 9
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???10???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "10"
            number = 10
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???11???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "11"
            number = 11
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???12???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "12"
            number = 12
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???13???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "13"
            number = 13
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???14???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "14"
            number = 14
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        else if(lblSecond.text == "???15???????????????"){
            lblSecond.text = str
            lblnumrecord.text = "1"
            lblnumrecord2.text = "15"
            number = 15
            scroller1.isHidden = true
            scroller2.isHidden = false
        }
        
        if(number == 1)
        {
            //display information_XML
            textother1.text = re.MaMaRecordOther(id: textID.text!, parity: textParity.text!, time: lblnumrecord.text!)
            parity_reason.text = re.MaMaRecordResult(id: textID.text!, parity: textParity.text!, time: lblnumrecord.text!)
            
            //display information_Json
            let res = re.MaMaRecordParity1(id: textID.text!, parity: textParity.text!, time: lblnumrecord.text!)
            var data = res.data(using: .utf8)
            do{
                let decoder: JSONDecoder = JSONDecoder()
                var decoded = try decoder.decode(Product.self, from: data!)
                Rh_reason.text = decoded.RhFactor
                Blood.text = decoded.BloodType
                WBC.text = decoded.WBC
                RBC.text = decoded.RBC
                PLT.text = decoded.Plt
                HCT.text = decoded.Hct
                MCV.text = decoded.MCV
                HB.text = decoded.Hb
                weight1.text = decoded.Weight
                high_blood1.text = decoded.SystolicBP
                low_blood1.text = decoded.DiastolicBP
                RecordTime1.text = decoded.RecordTime
                PregnantWeek1.text = decoded.PregnantWeek
                DueDate1.text = decoded.DueDate
            }
            catch{
                let alert = UIAlertController(title: "??????", message: "????????????????????????", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "???", style: .default, handler: nil))
                    present(alert, animated: true)
            }
        }
        else
        {
            //display information_XML
            textother2.text = re.MaMaRecordOther(id: textID2.text!, parity: textParity2.text!, time: lblnumrecord2.text!)
            parity_reason2.text = re.MaMaRecordResult(id: textID2.text!, parity: textParity2.text!, time: lblnumrecord2.text!)
        
            //display information_Json
            let res = re.MaMaRecordParity2(id: textID2.text!, parity: textParity2.text!, time: lblnumrecord2.text!)
            var data = res.data(using: .utf8)
            do{
                let decoder: JSONDecoder = JSONDecoder()
                var decoded = try decoder.decode(Product2.self, from: data!)
                weight.text = decoded.Weight
                high_blood.text = decoded.SystolicBP
                low_blood.text = decoded.DiastolicBP
                sugar_blood.text = decoded.UrineSugar
                Urineprotein.text = decoded.UrineProtein
                RecordTime2.text = decoded.RecordTime
                PregnantWeek2.text = decoded.PregnantWeek
                DueDate2.text = decoded.DueDate
            }
            catch{
                let alert = UIAlertController(title: "??????", message: "????????????????????????", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "???", style: .default, handler: nil))
                    present(alert, animated: true)
            }
        }
        
        //result
        if(parity_reason.text == "????????????????????????")
        {
            textview1.isHidden = false
            textview1.text = re.MaMaRecordWarn(id: textID.text!, parity: textParity.text!, time: lblnumrecord.text!)
        }
        else if(parity_reason2.text == "????????????????????????")
        {
            textview2.isHidden = false
            textview2.text = re.MaMaRecordWarn(id: textID.text!, parity: textParity.text!, time: lblnumrecord2.text!)
        }
        else
        {
            textview1.isHidden = true
            textview2.isHidden = true
        }
    }
    
    //??????????????????
    override var prefersStatusBarHidden: Bool{
        return true
    }
    @IBAction func cancelbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //??????button & viewController???????????????segue
        if segue.identifier == "UltrasoundPage"{
            let controller = segue.destination as!UltrasoundVC
            controller.id = textID.text
            controller.parity = textParity.text
            controller.times = lblnumrecord.text
            controller.id = textID2.text
            controller.parity = textParity2.text
            controller.times = lblnumrecord2.text
        }
    }
}
