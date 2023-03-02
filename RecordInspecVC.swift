//
//  RecordInspecVC.swift
//  Mama
//
//  Created by AA101 on 2020/12/29.
//

import UIKit

class RecordInspecVC: UIViewController,UITableViewDelegate,UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var list = [String]()
    var choices = ["1","2","3"]
    var pickerView = UIPickerView()
    var typeValue = String()
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var textID: UILabel!
    @IBOutlet weak var textParity: UILabel!
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //選擇想觀看的胎次
        let alert = UIAlertController(title: "請選擇想觀看的胎次", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            
            //self.textParity.text = self.typeValue
            //print("You selected " + self.typeValue )
        
        }))
        self.present(alert,animated: true, completion: nil )
        
        //傳值
        textID.text = id!
        
        list.append("第1次產檢紀錄")
        list.append("第2次產檢紀錄")
        list.append("第3次產檢紀錄")
        list.append("第4次產檢紀錄")
        list.append("第5次產檢紀錄")
        list.append("第6次產檢紀錄")
        list.append("第7次產檢紀錄")
        list.append("第8次產檢紀錄")
        list.append("第9次產檢紀錄")
        list.append("第10次產檢紀錄")
        list.append("第11次產檢紀錄")
        list.append("第12次產檢紀錄")
        list.append("第13次產檢紀錄")
        list.append("第14次產檢紀錄")
        list.append("第15次產檢紀錄")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath)
        
        cell.textLabel?.text = list[indexPath.row]
        
        cell.layer.cornerRadius = 25
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray5.cgColor
        let shadowPath2 = UIBezierPath(rect: cell.bounds)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowPath = shadowPath2.cgPath
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableview.indexPathForSelectedRow
        let str = list[indexPath!.row]
        let vc = segue.destination as? Record_DetailVC
        vc?.str = str
        
        //透過button & viewController之間連線的segue
        if segue.identifier == "Record"{
            let controller = segue.destination as!Record_DetailVC
            controller.id = textID.text
            controller.parity = textParity.text
        }
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    //隱藏上方欄位
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //chose parity
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textParity.text = choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
        
    @IBAction func showChoices(_ sender: Any) {
        let alert = UIAlertController(title: "請選擇想觀看的胎次", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            
            //self.textParity.text = self.typeValue
            //print("You selected " + self.typeValue )
        }))
        self.present(alert,animated: true, completion: nil )
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
