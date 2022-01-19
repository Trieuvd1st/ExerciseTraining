//
//  DetailViewController.swift
//  ExerciseTraining
//
//  Created by macbook pro on 15/01/2022.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var tfNameFood: UITextField!
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var btnStar1: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStar3: UIButton!
    @IBOutlet weak var btnStar4: UIButton!
    @IBOutlet weak var btnStar5: UIButton!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    var ratingNumber: Int = 0
    var imagePath: String?
    var foodInfoItem: FoodInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillItemData()

        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        imageFood.addGestureRecognizer(tapGR)
        imageFood.isUserInteractionEnabled = true

        tfNameFood.addTarget(self, action: #selector(tfNameDidChange(_:)), for: .editingChanged)
    }
    
    func fillItemData() {
        guard let item = foodInfoItem else {
            return
        }
        let data = try? Data(contentsOf: URL(string: "\(item.image)")!)
        if let dataImage = data {
            self.imageFood.image = UIImage(data: dataImage)
        } else {
            self.imageFood.image = UIImage(named: "gai_xinh.jpg")
        }
        imagePath = item.image
        self.tfNameFood.text = item.name
        self.setHighlightStar(number: item.rating)
    }

    @IBAction func onCancel(_ sender: Any) {
        if foodInfoItem == nil {
            self.navigationController?.view.layer.add(CATransition().popFromTop(), forKey: nil)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSave(_ sender: Any) {
        let dataUpdated = FoodInfo(image: imagePath ?? "gai_xinh.jpg", name: tfNameFood.text!, rating: ratingNumber)
        let foodDao = FoodDao()
        if let foodInfoItem = foodInfoItem {
            foodDao.updateFoodById(id: foodInfoItem.id, item: dataUpdated)
        } else {
            foodDao.addFood(item: dataUpdated)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onStar1Select(_ sender: Any) {
        setHighlightStar(number: 1)
        setStateBtnSave(nameField: tfNameFood.text ?? "")
    }
    
    @IBAction func onStar2Select(_ sender: Any) {
        setHighlightStar(number: 2)
        setStateBtnSave(nameField: tfNameFood.text ?? "")
    }
    
    @IBAction func onStar3Select(_ sender: Any) {
        setHighlightStar(number: 3)
        setStateBtnSave(nameField: tfNameFood.text ?? "")
    }
    
    @IBAction func onStar4Select(_ sender: Any) {
        setHighlightStar(number: 4)
        setStateBtnSave(nameField: tfNameFood.text ?? "")
    }
    
    @IBAction func onStar5Select(_ sender: Any) {
        setHighlightStar(number: 5)
        setStateBtnSave(nameField: tfNameFood.text ?? "")
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
        }
    }
    
    @objc func tfNameDidChange(_ tfName: UITextField) {
        setStateBtnSave(nameField: tfName.text ?? "")
    }
    
    func setHighlightStar(number: Int) {
        ratingNumber = number
        let imageNormal = UIImage(named: "ic_star.png")
        let imageSelected = UIImage(named: "ic_star_selected.png")
        btnStar1.setImage(number >= 1 ? imageSelected : imageNormal, for: .normal)
        btnStar2.setImage(number >= 2 ? imageSelected : imageNormal, for: .normal)
        btnStar3.setImage(number >= 3 ? imageSelected : imageNormal, for: .normal)
        btnStar4.setImage(number >= 4 ? imageSelected : imageNormal, for: .normal)
        btnStar5.setImage(number >= 5 ? imageSelected : imageNormal, for: .normal)
    }
    
    func setStateBtnSave(nameField: String) {
        btnSave.isEnabled = !nameField.isEmpty && ratingNumber != 0
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imageUrl = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imageUrl)
        }
        let data = try? Data(contentsOf: imageUrl)
        imageFood.image = UIImage(data: data!)
        self.imagePath = imageUrl.absoluteString
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
