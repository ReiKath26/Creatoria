//
//  LaunchScreenController.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 06/05/22.
//

import UIKit

class LaunchScreenController: UIViewController {
    
//    private let bookImage: UIImageView =
//    {
//        let imageView = UIImageView(frame: CGRect(x: 46, y: 345, width: 307, height: 206))
//        imageView.image = UIImage(named: "Book Color")
//        return imageView
//    }()
//
//    private let pictureImage: UIImageView =
//    {
//        let imageView = UIImageView(frame: CGRect(x: 46, y: 325, width: 58, height: 58))
//        imageView.image = UIImage(named: "Picture color")
//        return imageView
//    }()
//
//    private let videoImage: UIImageView =
//    {
//        let imageView = UIImageView(frame: CGRect(x: 170, y: 279, width: 58, height: 58))
//        imageView.image = UIImage(named: "Picture color")
//        return imageView
//    }()
//
//    private let soundsImage: UIImageView =
//    {
//        let imageView = UIImageView(frame: CGRect(x: 281, y: 325, width: 58, height: 58))
//        imageView.image = UIImage(named: "Picture color")
//        return imageView
//    }()
    
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var pictureImage: UIImageView!
    @IBOutlet var videoImage: UIImageView!
    @IBOutlet var soundsImage: UIImageView!
    @IBOutlet var creatoriaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(bookImage)
//        view.addSubview(pictureImage)
//        view.addSubview(videoImage)
//        view.addSubview(soundsImage)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            self.animate()
        })
        // Do any additional setup after loading the view.
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//    }
    
    private func animate()
    {
        UIView.animate(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat, .curveEaseInOut]) {
            self.bookImage.frame = CGRect(x: 46, y: 360, width: 307, height: 206)
            self.pictureImage.frame = CGRect(x: 46, y: 335, width: 58, height: 58)
            self.videoImage.frame = CGRect(x: 170, y: 250, width: 58, height: 58)
            self.soundsImage.frame = CGRect(x: 281, y: 350, width: 58, height: 58)
        }

        UIView.animate(withDuration: 5, delay: 0.5) {
            self.bookImage.alpha = 0
            self.pictureImage.alpha = 0
            self.videoImage.alpha = 0
            self.soundsImage.alpha = 0
            self.creatoriaLabel.alpha = 0
        } completion: { done in
            if done
            {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "tabView") as! TabBarController
                mainVC.modalTransitionStyle = .crossDissolve
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC, animated: true)
            }
        }

    }

}
