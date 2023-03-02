//
//  babyVC.swift
//  Mama
//
//  Created by AA101 on 2020/11/19.
//

import UIKit

class babyVC: UIViewController {
    
    let re = WebService()
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var babyname: UITextField!
    @IBOutlet weak var babyparity: UITextField!
    @IBOutlet weak var babyid: UITextField!
    @IBOutlet weak var textgender: UITextField!
    @IBOutlet weak var textname: UITextField!
    @IBOutlet weak var textbirth: UITextField!
    @IBOutlet weak var textweek: UITextField!
    @IBOutlet weak var textstyle: UITextField!
    @IBOutlet weak var textone: UITextField!
    @IBOutlet weak var textfive: UITextField!
    @IBOutlet weak var textheight: UITextField!
    @IBOutlet weak var textweight: UITextField!
    @IBOutlet weak var texthead: UITextField!
    @IBOutlet weak var textbody: UITextField!
    @IBOutlet weak var texthospital: UITextField!
    @IBOutlet weak var babyimage: UIImageView!
    var session:URLSession?
    var id: String?
    
    struct Product: Codable {
        let BabyWeek:String?
        let BabyOne:String?
        let BabyFive:String?
        let BabyHight: String?
        let BabyWeight: String?
        let BabyHead: String?
        let BabyBody: String?
        let BabyBornTime: String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        babyname.inputAccessoryView=toolbar
        babyparity.inputAccessoryView=toolbar
        babyid.text = id!
        
        //存入圖片網址
        let imageAddress = "http://120.125.78.69:8082/image/BABY.png"
        //產生url
        if let imageUrl = URL(string: imageAddress){
            DispatchQueue.global().async {
                do{
                    //利用Data來產生下載內容
                    let imageData = try Data(contentsOf: imageUrl)
                    let downLoadImage = UIImage(data: imageData)
                        DispatchQueue.main.async {
                        self.babyimage.image = downLoadImage
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }

    @IBAction func cancelbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donebuttonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.babyname.resignFirstResponder()
            self.babyparity.resignFirstResponder()
        }
        if(babyparity.text == ""){
            let alert = UIAlertController(title: "未填寫", message: "請確實填寫", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else{
            //display information_XML
            textgender.text = re.Babygender(id: id!, parity: babyparity.text!)
            textname.text = re.BabyName(id: id!, parity: babyparity.text!)
            textstyle.text = re.Babyway(id: id!, parity: babyparity.text!)
            texthospital.text = re.BabyWeekHospital(id: id!, parity: babyparity.text!)

            //display information_Json
            let res = re.BabyRecord(id: id!, parity: babyparity.text!)
            var data = res.data(using: .utf8)
            do{
                let decoder: JSONDecoder = JSONDecoder()
                var decoded = try decoder.decode(Product.self, from: data!)
                textweek.text = decoded.BabyWeek
                textone.text = decoded.BabyOne
                textfive.text = decoded.BabyFive
                textheight.text = decoded.BabyHight
                textweight.text = decoded.BabyWeight
                texthead.text = decoded.BabyHead
                textbody.text = decoded.BabyBody
                textbirth.text = decoded.BabyBornTime
            }
            catch{
                
            }
            let PictureName = re.BabyImage(id: id!, parity: babyparity.text!)
            //存入圖片網址
            let imageAddress = PictureName
            //產生url
            if let imageUrl = URL(string: imageAddress){
                DispatchQueue.global().async {
                    do{
                        //利用Data來產生下載內容
                        let imageData = try Data(contentsOf: imageUrl)
                        let downLoadImage = UIImage(data: imageData)
                            DispatchQueue.main.async {
                            self.babyimage.image = downLoadImage
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @IBAction func savebtn(_ sender: Any) {
        if(textname.text == ""){
            let alert = UIAlertController(title: "未填寫", message: "請確實填寫", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else{
            re.UpdateBaby(id: babyid.text!, parity: babyparity.text!, babyname: textname.text!)
            let alert = UIAlertController(title: "已填寫", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
                //dismiss(animated: true, completion: nil)
        }
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
