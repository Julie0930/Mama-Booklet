//
//  Recipe_stepVC.swift
//  Mama
//
//  Created by AA101 on 2021/1/23.
//

import UIKit

class Recipe_stepVC: UIViewController {

    let re = WebService()
    @IBOutlet weak var foodname: UILabel!
    @IBOutlet weak var foodStep: UITextView!
    @IBOutlet weak var image: UIImageView!
    var Str: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        foodname.text = Str!
        
        foodStep.text = re.FoodRecipe(topic: Str!)
        print(re.FoodRecipe(topic: Str!))

        let PictureName = re.FoodPicture(topic: foodname.text!)
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
                        self.image.image = downLoadImage
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
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
