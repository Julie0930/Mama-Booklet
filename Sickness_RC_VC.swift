//
//  Sickness_RC_VC.swift
//  Mama
//
//  Created by AA101 on 2020/12/16.
//

import UIKit

protocol GetData1: class {
    func receiveData(data: String)
}

class Sickness_RC_VC: UIViewController {

    weak var delegate: GetData1?
    @IBOutlet weak var lblgrade: UILabel!
    @IBOutlet weak var textview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textview.text = "一級：無孕吐\n\n由於存在個體差異，有些孕媽可能對激素變化不敏感，或者適應能力較強，因此沒有明顯的孕吐反應，屬於正常情況。\n\n雖然沒有孕吐擾人，但也可能會有其他的早孕反應，如頭暈、乏力、嗜睡等，總之它們都是在提醒你懷孕啦!不過，若孕媽起初有孕吐反應，後來突然消失，同時伴有輕微腹痛、陰道少量出血，很有可能是胎兒停育的表現，需儘快去醫院診治。"
    }
    
    @IBAction func yesnobool(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0{
            lblgrade.text = "害喜程度為1級"
            textview.text = "一級：無孕吐\n\n由於存在個體差異，有些孕媽可能對激素變化不敏感，或者適應能力較強，因此沒有明顯的孕吐反應，屬於正常情況。\n\n雖然沒有孕吐擾人，但也可能會有其他的早孕反應，如頭暈、乏力、嗜睡等，總之它們都是在提醒你懷孕啦!不過，若孕媽起初有孕吐反應，後來突然消失，同時伴有輕微腹痛、陰道少量出血，很有可能是胎兒停育的表現，需儘快去醫院診治。"
        }
        else if sender.selectedSegmentIndex==1{
            lblgrade.text = "害喜程度為2級"
            textview.text = "二級：輕微孕吐\n\n輕微的孕吐僅僅只是在早起刷牙的時候會噁心，不會有很多嘔吐物出來。孕媽媽在平時還是可以該吃吃該喝喝，毫不影響進食。並且可以隨心所欲的到處去看看花，賞賞草等等"
        }
        else if sender.selectedSegmentIndex==2{
            lblgrade.text = "害喜程度為3級"
            textview.text = "三級：正常孕吐\n輕微的噁心、嘔吐、食慾下降，屬於正常反應，孕媽不必過於擔心，僅需正常作息、進食，養成良好的生活習慣即可。"
        }
        else if sender.selectedSegmentIndex==3{
            lblgrade.text = "害喜程度為4級"
            textview.text = "四級：略微嚴重的孕吐\n\n 此反應，則是在聞到油煙味、汽油味或者其他特定的氣味時候，會噁心嘔吐。有的還會連續性嘔吐，但還是能夠吃下一些東西，出去走走。"
        }
        else{
            lblgrade.text = "害喜程度為5級"
            textview.text = "五級：妊娠劇吐\n\n少數孕媽的反應特別嚴重，呈持續性嘔吐，嘔吐物除食物外，也可能有膽汁或血性物。 更嚴重者甚至不能進食、進水，可能會發生失水或電解質紊亂等情況。一旦孕媽出現體重明顯減輕、面色蒼白、尿量減少等症狀，需到醫院及時就診。"
        }
    }
    
    @IBAction func savebtn(_ sender: Any) {
        delegate?.receiveData(data: lblgrade.text!)
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
