//
//  DeTailVC.swift
//  baby
//
//  Created by AA101 on 2020/11/19.
//

import UIKit

class DeTailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var list = [String]()
    @IBOutlet weak var textname: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var Str: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textname.text = Str
        if(textname.text == "第一孕期\t第0週～第17週"){
            list.append("香菇棗蒸雞")
            list.append("烏雞補腎湯")
            list.append("素什錦")
            list.append("南瓜牛肉湯")
            list.append("苦瓜燉排骨")
            list.append("蒜苗甜椒炒牛肉")
            list.append("豆苗燒銀耳")
            list.append("三丁糖醋燒黃魚")
            list.append("雞肉鮮湯小白菜")
            list.append("什錦水果澆汁飯")
        }
        else if(textname.text == "第二孕期\t第17週～第29週"){
            list.append("芹菜炒豬肝")
            list.append("黃豆燉豬蹄")
            list.append("清蒸大蝦")
            list.append("什錦沙拉")
            list.append("干貝火腿燉雞湯")
            list.append("酸菜炒牛肉")
            list.append("雞湯煲松仁海帶絲")
            list.append("核桃芝麻糯米粥")
            list.append("黃豆海帶燜雞翅")
            list.append("蝦皮燒冬瓜")
        }
        else if(textname.text == "第三孕期\t第29週～"){
            list.append("歸參燉母雞")
            list.append("蓮藕章魚湯")
            list.append("蟹肉蒸飯")
            list.append("銀耳紅棗冰糖湯")
            list.append("蝦仁菠蘿飯")
            list.append("糯米紅棗")
            list.append("蕃茄辣炒荸薺")
            list.append("紅棗黑豆燉鯉魚")
            list.append("海帶燕窩豆腐湯")
            list.append("腐竹豆芽炒木耳")
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for : indexPath)
        
        cell.textLabel?.text = list[indexPath.row]
        
        cell.layer.cornerRadius = 25
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemTeal.cgColor
        let shadowPath2 = UIBezierPath(rect: cell.bounds)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowPath = shadowPath2.cgPath
        
        return cell
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        let indexPath = tableview.indexPathForSelectedRow
        let Str = list[indexPath!.row]
        let vc = segue.destination as? Recipe_stepVC
            vc?.Str = Str
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
