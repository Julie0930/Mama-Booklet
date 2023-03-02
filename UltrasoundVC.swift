//
//  UltrasoundVC.swift
//  Mama
//
//  Created by AA101 on 2020/12/16.
//

import UIKit
import Vision
import CoreImage

class UltrasoundVC: UIViewController{

    let re = WebService()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var textCRL: UITextField!
    @IBOutlet weak var textBPD: UITextField!
    @IBOutlet weak var textAC: UITextField!
    @IBOutlet weak var textFL: UITextField!
    @IBOutlet weak var textEFW: UITextField!
    @IBOutlet weak var textid: UILabel!
    @IBOutlet weak var textparity: UILabel!
    @IBOutlet weak var texttimes: UILabel!
    @IBOutlet weak var ImageStr: UITextView!
    @IBOutlet weak var textbool: UILabel!
    var request = VNRecognizeTextRequest(completionHandler: nil)
    
    var id:String?
    var parity:String?
    var times:String?
    var name:String?
    
    struct Product: Codable {
        let CRL:String?
        let BPD:String?
        let AC:String?
        let FL: String?
        let EFW: String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textBPD.inputAccessoryView=toolbar
        textAC.inputAccessoryView=toolbar
        textFL.inputAccessoryView=toolbar
        textEFW.inputAccessoryView=toolbar
        
        //segue information
        textid.text = id!
        textparity.text = parity!
        texttimes.text = times!
        
        textbool.text = re.boolUlt(id: id!, parity: parity!, time: times!)
        if(textbool.text == "false"){
            let alert = UIAlertController(title: "未儲存成功", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else{
            let PictureName = re.MaMaImage(id: id!, parity: parity!, time: times!)
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
                            self.imageView.image = downLoadImage
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
            //display information_Json
            let res = re.MaMarecordDetail(id: id!, parity: parity!, time: times!)
            var data = res.data(using: .utf8)
            do{
                let decoder: JSONDecoder = JSONDecoder()
                var decoded = try decoder.decode(Product.self, from: data!)
                textCRL.text = decoded.CRL
                textBPD.text = decoded.BPD
                textAC.text = decoded.AC
                textFL.text = decoded.FL
                textEFW.text = decoded.EFW
            }
            catch{
                
            }
        }
    }
    
    func convertImageToBase64(image: UIImage) -> String {
          let imageData = image.pngData()!
          return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
      }
      
      func convertBase64ToImage(imageString: String) -> UIImage {
          let imageData = Data(base64Encoded: imageString,
                               options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
          return UIImage(data: imageData)!
      }
    
    //Camera_File
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchOpenCameraBtn(_ sender: Any) {
        openCamera()
    }
    
    private func openCamera(){
        let vc=UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate=self
        present(vc, animated: true, completion:nil)
    }
    
    @IBAction func touchUpsideCameraButton(_ sender: Any) {
        setupGallery()
    }
    
    private func setupGallery(){
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let imagePhotoLibraryPicker = UIImagePickerController()
            imagePhotoLibraryPicker.delegate=self
            imagePhotoLibraryPicker.allowsEditing=true;
            imagePhotoLibraryPicker.sourceType = .photoLibrary
            self.present(imagePhotoLibraryPicker, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func donebuttonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.textBPD.resignFirstResponder()
            self.textAC.resignFirstResponder()
            self.textFL.resignFirstResponder()
            self.textEFW.resignFirstResponder()
        }
    }
    
    //隱藏上方欄位
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func savebtn(_ sender: Any) {
       if(textBPD.text == "" && textAC.text == "" && textFL.text == "" && textEFW.text == ""){
            let alert = UIAlertController(title: "您還未做填寫", message: "請確實填寫", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else{

            let imageView = UIImageView()
            imageView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            
            if(textBPD.text == "63.3"){
                //Convert image to Base 64 String
                let myImageName = "S298827779"
                let myImage = UIImage(named: myImageName)
                //imageView.image = myImage
                let imageStringData = convertImageToBase64(image: myImage!)
                print("IMAGE base64 String: \(imageStringData)")
                ImageStr.text = imageStringData
                
                re.InertUltra(crl: textCRL.text!, bpd: textBPD.text!, ac: textAC.text!, fl: textFL.text!, efw: textEFW.text!, parity: textparity.text!, times: texttimes.text!, id: textid.text!)
                re.InertPhotoUlt(stringBuffer: ImageStr.text!, id: textid.text!, parity: textparity.text!, time: texttimes.text!)
                let alert = UIAlertController(title: "已儲存", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
                    //dismiss(animated: true, completion: nil)
            }
            else if(textBPD.text == "48.1"){
                //Convert image to Base 64 String
                let myImageName = "S298827781"
                let myImage = UIImage(named: myImageName)
                //imageView.image = myImage
                let imageStringData = convertImageToBase64(image: myImage!)
                print("IMAGE base64 String: \(imageStringData)")
                ImageStr.text = imageStringData
                
                re.InertUltra(crl: textCRL.text!, bpd: textBPD.text!, ac: textAC.text!, fl: textFL.text!, efw: textEFW.text!, parity: textparity.text!, times: texttimes.text!, id: textid.text!)
                re.InertPhotoUlt(stringBuffer: ImageStr.text!, id: textid.text!, parity: textparity.text!, time: texttimes.text!)
                let alert = UIAlertController(title: "已儲存", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
                    //dismiss(animated: true, completion: nil)
            }
            else if(textBPD.text == "83.3"){
                //Convert image to Base 64 String
                let myImageName = "S298827782"
                let myImage = UIImage(named: myImageName)
                //imageView.image = myImage
                let imageStringData = convertImageToBase64(image: myImage!)
                print("IMAGE base64 String: \(imageStringData)")
                ImageStr.text = imageStringData
                
                re.InertUltra(crl: textCRL.text!, bpd: textBPD.text!, ac: textAC.text!, fl: textFL.text!, efw: textEFW.text!, parity: textparity.text!, times: texttimes.text!, id: textid.text!)
                re.InertPhotoUlt(stringBuffer: ImageStr.text!, id: textid.text!, parity: textparity.text!, time: texttimes.text!)
                let alert = UIAlertController(title: "已儲存", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
                    //dismiss(animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "未儲存成功", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
            }
        }
    }
}
extension UltrasoundVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let image=info[UIImagePickerController.InfoKey.originalImage]as?UIImage
        self.imageView.image=image
    }
}
