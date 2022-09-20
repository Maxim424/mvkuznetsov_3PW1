//
//  ViewController.swift
//  mvkuznetsov_3PW1
//
//  Created by Максим Кузнецов on 19.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet var views: [UIView]!
    let a = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColorButtonPressed(button1 as Any)
    }

    @IBAction func changeColorButtonPressed(_ sender: Any) {
        let button = sender as? UIButton
        button?.isEnabled = false
        var set = Set<String>()
        while set.count < views.count {
            let hex = "#".appending(a[Int.random(in:0..<15)]).appending(a[Int.random(in:0..<15)]).appending(a[Int.random(in:0..<15)])
            set.insert(
                hex
            )
        }
        UIView.animate(withDuration: 1, animations: {
            for view in self.views {
                view.layer.cornerRadius = .random(in: 0...1)*30
                let hex = set.popFirst()
                let r, g, b: CGFloat
                if hex!.hasPrefix("#") {
                    let start = hex!.index(hex!.startIndex, offsetBy: 1)
                    let hexColor = String(hex![start...])
                    if hexColor.count > 0 {
                        let scanner = Scanner(string: hexColor)
                        var hexNumber: UInt64 = 0
                        if scanner.scanHexInt64(&hexNumber) {
                            r = CGFloat((hexNumber >> 4) & 0xFF) / 255
                            g = CGFloat(((hexNumber >> 2) & 0xFF)) / 255
                            b = CGFloat((hexNumber) & 0xFF) / 255
                            view.backgroundColor = UIColor.init(red: r, green: g, blue: b, alpha: 1)
                        }
                    }
                }
            }
        }) { completion in
            button?.isEnabled = true
        }
    }
}

