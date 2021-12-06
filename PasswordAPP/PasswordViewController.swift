//
//  ViewController.swift
//  PasswordAPP
//
//  Created by 姜又寧 on 2021/12/5.
//
enum Image: String {
    case cat = "cat0", catFill = "cat1", none = "None"
}
import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet var images: [UIImageView]!
    
    @IBOutlet weak var showLabel: UILabel!
    
    @IBOutlet weak var showImage: UIImageView!
    
    let correctPassword = "1234"
    var currentPassword = ""
    
    var addImageString : Image = .none {
        didSet {
            let imageIndex = self.currentPassword.count - 1
            self.images[imageIndex].image = UIImage(named: addImageString.rawValue)
        }
    }
    
    var reduceImageString : Image = .none {
        didSet {
            let imageIndex = self.currentPassword.count
            self.images[imageIndex].image = UIImage(named: reduceImageString.rawValue)
        }
    }
    
    var showImageString : Bool = true {
        didSet {
            if self.showImageString {
                self.showImage.image = UIImage(named: "北爛貓")
                self.showLabel.text = "被你猜對了"
            }else{
                self.showImage.image = UIImage(named: "北爛貓2")
                self.showLabel.text = "猜不到吧！哈哈哈哈哈"
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.resetAll()
    }

    @IBAction func enterPassword(_ sender: UIButton) {
        let number = sender.tag
        if self.currentPassword.count < 4 {
            self.currentPassword.append(contentsOf: "\(number)")
            self.addImageString = .catFill
            checkPassword()
        }
        
        print("\(currentPassword)第\(currentPassword.count)個")

    }
    
    func checkPassword() {
        if currentPassword != correctPassword, self.currentPassword.count == 4 {
            self.alertController("不對不對喔！！", "再試一遍", "重新來吧")
            self.showImageString = false
        }else if currentPassword == correctPassword{
            self.alertController("你終於對了！！", "恭喜發財", "OK")
            self.showImageString = true
        }
    }
    
    func alertController(_ ctTitle: String, _ ctMessage: String, _ acTitle: String) {
        let controller = UIAlertController(title: ctTitle, message: ctMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: acTitle, style: .default) { _ in
            self.resetAll()
        }
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func backPassword(_ sender: UIButton) {
        if self.currentPassword.count > 0 {
            self.currentPassword.removeLast()
            self.reduceImageString = .cat
        }
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        resetAll()
    }
    
    
    func resetAll() {
        self.currentPassword.removeAll()
        self.showImage.image = UIImage(named: "北爛貓1")
        self.showLabel.text = "想偷看？猜猜看呀"
        for image in self.images {
            let imageString : Image = .cat
            image.image = UIImage(named: imageString.rawValue)
        }
    }
    
}

