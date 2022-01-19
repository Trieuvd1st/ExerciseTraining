//
//  FoodTableViewCell.swift
//  ExerciseTraining
//
//  Created by macbook pro on 15/01/2022.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imFood: UIImageView!
    @IBOutlet weak var lbNameFood: UILabel!
    @IBOutlet weak var rscRating: RatingStarCustom!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillData(item: FoodInfo) {
        let data = try? Data(contentsOf: URL(string: "\(item.image)")!)
        if let dataImage = data {
            imFood.image = UIImage(data: dataImage)
        } else {
            imFood.image = UIImage(named: "gai_xinh.jpg")
        }
        lbNameFood.text = item.name
        rscRating.setHighlightStar(number: item.rating)
    }
}
