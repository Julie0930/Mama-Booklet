//
//  SigninVC.swift
//  Mama
//
//  Created by AA101 on 2020/10/8.
//

import UIKit
import LocalAuthentication

class SigninVC: UIViewController, UITextFieldDelegate, NSURLConnectionDelegate {

    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var textFildaccount: UITextField!
    @IBOutlet weak var textFildpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 創建 LAContext 實例
        let context = LAContext()
        // 設置取消按鈕標題
        context.localizedCancelTitle = "Cancel"
        var error: NSError?
        // 評估是否可以針對給定方案進行身份驗證
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "F229419527"
            textFildaccount.text = reason
            textFildpassword.text = "123"
            // 評估指定方案
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
                if success {
                    DispatchQueue.main.async { [unowned self] in
                        //跳轉頁面
                        if let controller = storyboard?.instantiateViewController(withIdentifier: "secondPage") {
                            present(controller, animated: true, completion: nil)
                        }
                    }
                }
                else {
                    DispatchQueue.main.async { [unowned self] in
                        self.showMessage(title: "Login Failed", message: error?.localizedDescription)
                        textFildaccount.text = ""
                        textFildpassword.text = ""
                    }
                }
            }
        } else {
            showMessage(title: "Failed", message: error?.localizedDescription)
            textFildaccount.text = ""
            textFildpassword.text = ""
        }
    }
    func showMessage(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    var dataToPass = ""

    @IBAction func doneButton(_ sender: Any) {
        UIView.animate(withDuration: 0.5 ){
            self.textFildaccount.resignFirstResponder()
            self.textFildpassword.resignFirstResponder()
        }
    }
    @IBAction func signinBtn(_ sender: Any) {
            textFildaccount.delegate = self
            let text1: String = textFildaccount.text!
            textFildpassword.delegate = self
            let text2: String = textFildpassword.text!
            
            let re = WebService()
            var textAll:String = re.Login(Id: text1, Pwd: text2)
            if textAll == "true"{
                /*let alert = UIAlertController(title: "正確", message: "正確", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
                return*/
                //跳轉頁面
                if let controller = storyboard?.instantiateViewController(withIdentifier: "secondPage") {
                    present(controller, animated: true, completion: nil)
                }
                textFildaccount.text = ""
                textFildpassword.text = ""
            }
            else if textAll == "false"{
                let alert = UIAlertController(title: "錯誤", message: "帳號密碼不正確", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
                textFildaccount.text = ""
                textFildpassword.text = ""
                return
            }
            else{
                let alert = UIAlertController(title: "錯誤", message: "請再輸入一次", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                           present(alert, animated: true)
                textFildaccount.text = ""
                textFildpassword.text = ""
                return
            }
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //透過button & viewController之間連線的segue
        if(textFildaccount.text == "" && textFildpassword.text == "")
        {
            let alert = UIAlertController(title: "錯誤", message: "您還未輸入帳號密碼", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else
        {
            let controller = segue.destination as! ViewController
            controller.name = textFildaccount.text
        }
    }

    @IBAction func register(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "registerPage") {
            present(controller, animated: true, completion: nil)
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
