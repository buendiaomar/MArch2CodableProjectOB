//
//  DetailViewController.swift
//  MArch2CodableProject
//
//  Created by Consultant on 3/2/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var primaryAttributeLabel: UILabel!
    @IBOutlet weak var primaryAttackLabel: UILabel!
    @IBOutlet weak var legsLabel: UILabel!
    
    var hero:Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = hero?.name
        primaryAttackLabel.text = hero?.attackType
        primaryAttributeLabel.text = hero?.primaryAttribute
        legsLabel.text = "\((hero?.legs)!)"
        let baseURL = "https://api.opendota.com" + (hero?.image)!
        let url = URL(string: baseURL)
        imageImageView.getImage(from: url!)
    
    }
}


