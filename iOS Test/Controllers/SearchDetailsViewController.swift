//
//  SearchDetailsViewController.swift
//  iOS Test
//
//  Created by Ankush Kumar Singh on 03/09/17.
//  Copyright © 2017 Castle. All rights reserved.
//

import UIKit

class SearchDetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var fullTitle: UILabel!

    @IBOutlet weak var subTitle: UILabel!

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var detailView: UIView!


    @IBOutlet weak var imageHeight: NSLayoutConstraint!

    var data = Page()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let thumbnail = data.thumbnail {

            let ratio = Double(thumbnail.height)/Double(thumbnail.width)
            let height = UIScreen.main.bounds.size.width * CGFloat(ratio)
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0, animations: {
                self.imageHeight.constant = height
                self.view.layoutIfNeeded()
            })

            var urlString = thumbnail.source

            if data.pageImage.lowercased().range(of:"svg") == nil {
                var components = urlString.components(separatedBy: "/")
                components = components.filter{$0 != "thumb"}
                let remainingComponents = components.dropLast()

                urlString = remainingComponents.map { String($0) }
                    .joined(separator: "/")
            }

            let imageUrl = URL(string: urlString)
            image.kf.setImage(with: imageUrl,
                                               placeholder:UIImage(named: PLACEHOLDER_LOADING ),
                                               options: [.transition(.fade(1))],
                                               progressBlock: nil,
                                               completionHandler: nil)
        } else {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0, animations: {
                self.imageHeight.constant = 0
                self.view.layoutIfNeeded()
            })
        }
        fullTitle.text = data.title
        subTitle.text = data.extract
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        scrollView?.contentSize =  CGSize(width: detailView.frame.width, height: detailView.frame.height)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
