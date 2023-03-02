//
//  diaryVC.swift
//  Mama
//
//  Created by AA101 on 2020/10/19.
//

import UIKit
import Vision

class diaryVC: UIViewController {
    
    let re = WebService()
    @IBOutlet weak var lblMood: UILabel!
    @IBOutlet weak var txtMood: UITextView!
    @IBOutlet var Toolbar: UIToolbar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textid: UILabel!
    @IBOutlet weak var texttype: UILabel!
    @IBOutlet weak var textbool: UILabel!
    @IBOutlet weak var ImageStr: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtMood.inputAccessoryView=Toolbar
        textid.text = "F229419527"
        
        //Timer
        let now=Date()
        let formatter=DateFormatter()
        formatter.dateFormat="yyyy/MM/dd"
        let time=formatter.string(from: (now))
        datelabel.text=time
        
        //display
        texttype.text = "心情"
        textbool.text = re.Diarybool(id: textid.text!, date: datelabel.text!, type: texttype.text!)
        if(textbool.text == "true"){
            lblMood.text = re.DiaryMood(id: textid.text! ,date: datelabel.text!)
            txtMood.text = re.DiaryMoodDes(id: textid.text! ,date: datelabel.text!)
            let PictureName = re.DiaryImage(id: textid.text!, date: datelabel.text!)
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
        }
        else{
            let alert = UIAlertController(title: "您還未做任何填寫哦～", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
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
    
    @IBAction func datePickerChange(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="yyyy/MM/dd"

        let strDate = dateFormatter.string(from: datePicker.date)
        datelabel.text = strDate
        
        //display
        lblMood.text = nil
        txtMood.text = nil
        imageView.image = nil
        textbool.text = re.Diarybool(id: textid.text!, date: datelabel.text!, type: texttype.text!)
        if(textbool.text == "true"){
            lblMood.text = re.DiaryMood(id: textid.text! ,date: datelabel.text!)
            txtMood.text = re.DiaryMoodDes(id: textid.text! ,date: datelabel.text!)
            
            let PictureName = re.DiaryImage(id: textid.text!, date: datelabel.text!)
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
        }
        else{
            let alert = UIAlertController(title: "您還未做任何填寫哦～", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //隱藏上方欄位
    /*override var prefersStatusBarHidden: Bool{
        return true
    }*/
    
    //toolbar
    @IBAction func donebuttonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.txtMood.resignFirstResponder()
        }
    }
    
    @IBAction func btnGood(_ sender: Any) {
        lblMood.text=""
        lblMood.text="不錯"
    }
    
    @IBAction func btnHappy(_ sender: Any) {
        lblMood.text=""
        lblMood.text="開心"
    }
    @IBAction func btnJoyful(_ sender: Any) {
        lblMood.text=""
        lblMood.text="雀躍"
    }
    @IBAction func btnHappyness(_ sender: Any) {
        lblMood.text=""
        lblMood.text="幸福"
    }
    
    @IBAction func btnSad(_ sender: Any) {
        lblMood.text=""
        lblMood.text="難過"
    }
    @IBAction func btnAngry(_ sender: Any) {
        lblMood.text=""
        lblMood.text="生氣"
    }
    @IBAction func btnTired(_ sender: Any) {
        lblMood.text=""
        lblMood.text="焦慮"
    }
    @IBAction func btnIrritability(_ sender: Any) {
        lblMood.text=""
        lblMood.text="煩躁"
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
    @IBAction func savebtn(_ sender: Any) {
        if(lblMood.text == "" && txtMood.text == ""){
            let alert = UIAlertController(title: "未填寫", message: "請確實填寫", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else{
            let imageView = UIImageView()
            imageView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            
            if(datelabel.text == "2021/03/22"){
                //Convert image to Base 64 String
                let myImageName = "20200324"
                let myImage = UIImage(named: myImageName)
                //imageView.image = myImage
                let imageStringData = convertImageToBase64(image: myImage!)
                print("IMAGE base64 String: \(imageStringData)")
                ImageStr.text = imageStringData
                           
                //Convert Base 64 String back to Image
                /*let imageView2 = UIImageView()
                imageView2.frame = CGRect(x: 300, y: 50, width: 200, height: 200)
                imageView2.contentMode = .scaleAspectFit
                view.addSubview(imageView2)
                imageView2.image = convertBase64ToImage(imageString: imageStringData)*/
                
                re.InertDiary(id: textid.text!, date: datelabel.text!, mood: lblMood.text!, mooddes: txtMood.text!, body: "", bodydes: "")
                re.InertDiaryPhoto(stringBuffer: ImageStr.text!, id: textid.text!, date: datelabel.text!)
                let alert = UIAlertController(title: "已填寫", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
                    //dismiss(animated: true, completion: nil)
            }
            else if(datelabel.text == "2021/03/23"){
                //Convert image to Base 64 String
                let myImageName = "20200323"
                let myImage = UIImage(named: myImageName)
                //imageView.image = myImage
                let imageStringData = convertImageToBase64(image: myImage!)
                print("IMAGE base64 String: \(imageStringData)")
                ImageStr.text = imageStringData
                           
                //Convert Base 64 String back to Image
                /*let imageView2 = UIImageView()
                imageView2.frame = CGRect(x: 300, y: 50, width: 200, height: 200)
                imageView2.contentMode = .scaleAspectFit
                view.addSubview(imageView2)
                imageView2.image = convertBase64ToImage(imageString: imageStringData)*/
                
                re.InertDiary(id: textid.text!, date: datelabel.text!, mood: lblMood.text!, mooddes: txtMood.text!, body: "", bodydes: "")
                re.InertDiaryPhoto(stringBuffer: ImageStr.text!, id: textid.text!, date: datelabel.text!)
                let alert = UIAlertController(title: "已填寫", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
                    //dismiss(animated: true, completion: nil)
            }
            else if(datelabel.text == "2021/03/24"){
                //Convert image to Base 64 String
                let myImageName = "20200322"
                let myImage = UIImage(named: myImageName)
                //imageView.image = myImage
                let imageStringData = convertImageToBase64(image: myImage!)
                print("IMAGE base64 String: \(imageStringData)")
                ImageStr.text = imageStringData
                           
                //Convert Base 64 String back to Image
                /*let imageView2 = UIImageView()
                imageView2.frame = CGRect(x: 300, y: 50, width: 200, height: 200)
                imageView2.contentMode = .scaleAspectFit
                view.addSubview(imageView2)
                imageView2.image = convertBase64ToImage(imageString: imageStringData)*/
                
                re.InertDiary(id: textid.text!, date: datelabel.text!, mood: lblMood.text!, mooddes: txtMood.text!, body: "", bodydes: "")
                re.InertDiaryPhoto(stringBuffer: ImageStr.text!, id: textid.text!, date: datelabel.text!)
                let alert = UIAlertController(title: "已填寫", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                present(alert, animated: true)
                    //dismiss(animated: true, completion: nil)
            }
            else if(datelabel.text == "2021/03/21"){
                //Convert image to Base 64 String
                let myImageName = "20200321"
                let myImage = UIImage(named: myImageName)
                //imageView.image = myImage
                let imageStringData = convertImageToBase64(image: myImage!)
                print("IMAGE base64 String: \(imageStringData)")
                ImageStr.text = imageStringData
                           
                //Convert Base 64 String back to Image
                /*let imageView2 = UIImageView()
                imageView2.frame = CGRect(x: 300, y: 50, width: 200, height: 200)
                imageView2.contentMode = .scaleAspectFit
                view.addSubview(imageView2)
                imageView2.image = convertBase64ToImage(imageString: imageStringData)*/
                
                re.InertDiary(id: textid.text!, date: datelabel.text!, mood: lblMood.text!, mooddes: txtMood.text!, body: "", bodydes: "")
                re.InertDiaryPhoto(stringBuffer: ImageStr.text!, id: textid.text!, date: datelabel.text!)
                let alert = UIAlertController(title: "已填寫", message: "", preferredStyle: .alert)
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
extension diaryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let image=info[UIImagePickerController.InfoKey.originalImage]as?UIImage
        self.imageView.image=image
    }
}

