//
//  RatingStartCustom.swift
//  ExerciseTraining
//
//  Created by macbook pro on 15/01/2022.
//

import UIKit

class RatingStarCustom: UIStackView {

    @IBOutlet weak var btnStar1: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStar3: UIButton!
    @IBOutlet weak var btnStar4: UIButton!
    @IBOutlet weak var btnStar5: UIButton!
    
    let image = UIImage(named: "ic_star_selected.png")

    func setHighlightStar(number: Int) {
        let imageNormal = UIImage(named: "ic_star.png")
        let imageSelected = UIImage(named: "ic_star_selected.png")
        btnStar1.setImage(number >= 1 ? imageSelected : imageNormal, for: .normal)
        btnStar2.setImage(number >= 2 ? imageSelected : imageNormal, for: .normal)
        btnStar3.setImage(number >= 3 ? imageSelected : imageNormal, for: .normal)
        btnStar4.setImage(number >= 4 ? imageSelected : imageNormal, for: .normal)
        btnStar5.setImage(number >= 5 ? imageSelected : imageNormal, for: .normal)
    }
}
