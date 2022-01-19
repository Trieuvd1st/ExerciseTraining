//
//  ViewController.swift
//  ExerciseTraining
//
//  Created by macbook pro on 15/01/2022.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var tbvFood: UITableView!
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    
    var arrayFood = [FoodInfo]()
    
    let foodDao = FoodDao()
    var itemSelected: FoodInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if foodDao.isListEmpty() {
            foodDao.addFood(item: FoodInfo(image: "gai_xinh.jpg", name: "thịt chó", rating: 1))
            foodDao.addFood(item: FoodInfo(image: "gai_xinh.jpg", name: "phở", rating: 2))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arrayFood = foodDao.getAllFood()
        tbvFood.reloadData()
    }
    
    @IBAction func onEditItem(_ sender: UIBarButtonItem) {
        let isEditting = tbvFood.isEditing
        self.tbvFood.setEditing(!isEditting, animated: true)
        sender.title = isEditting ? "Edit" : "Done"
    }
    
    @IBAction func onAddItem(_ sender: UIBarButtonItem) {
        itemSelected = nil
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.view.layer.add(CATransition().segueFromBottom(), forKey: nil)
        self.navigationController?.pushViewController(detailViewController, animated: true)
        //self.performSegue(withIdentifier: "nextToDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailViewController {
            controller.foodInfoItem = itemSelected
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodTableViewCell
        let item = arrayFood[indexPath.item]
        cell.fillData(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemSelected = arrayFood[indexPath.item]
        self.performSegue(withIdentifier: "nextToDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foodDao.deleteFoodById(id: arrayFood[indexPath.row].id)
            arrayFood.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
}

extension CATransition {

//New viewController will appear from bottom of screen.
    func segueFromBottom() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromTop
        return self
    }
    //New viewController will appear from top of screen.
    func segueFromTop() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
     //New viewController will appear from left side of screen.
    func segueFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
    //New viewController will pop from right side of screen.
    func popFromRight() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    //New viewController will appear from left side of screen.
    func popFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
    //New viewController will appear from top side of screen.
    func popFromTop() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
}

