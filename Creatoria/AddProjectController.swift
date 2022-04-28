//
//  AddProjectController.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 27/04/22.
//

import UIKit

class AddProjectController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet var symbolPreview: UIImageView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var descTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var nameValidate: UILabel!
    @IBOutlet var type_extensionValidate: UILabel!
    @IBOutlet var desc_Validate: UILabel!

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var pickerView = UIPickerView()
    
    let type = ["Design", "Video Editing", "Other"]
    
    var assets = [String]()
    var asset_type = [String]()
    
    var symbolNames: [String] = [
        "house.fill",
        "ticket.fill",
        "gamecontroller.fill",
        "theatermasks.fill",
        "ladybug.fill",
        "books.vertical.fill",
        "moon.zzz.fill",
        "umbrella.fill",
        "paintbrush.pointed.fill",
        "leaf.fill",
        "globe.americas.fill",
        "clock.fill",
        "building.2.fill",
        "gift.fill",
        "graduationcap.fill",
        "heart.rectangle.fill",
        "phone.bubble.left.fill",
        "cloud.rain.fill",
        "building.columns.fill",
        "mic.circle.fill",
        "comb.fill",
        "person.3.fill",
        "bell.fill",
        "hammer.fill",
        "star.fill",
        "crown.fill",
        "briefcase.fill",
        "speaker.wave.3.fill",
        "tshirt.fill",
        "tag.fill",
        "airplane",
        "pawprint.fill",
        "case.fill",
        "creditcard.fill",
        "infinity.circle.fill",
        "dice.fill",
        "heart.fill",
        "camera.fill",
        "bicycle",
        "radio.fill",
        "car.fill",
        "flag.fill",
        "map.fill",
        "figure.wave",
        "mappin.and.ellipse",
        "facemask.fill",
        "eyeglasses",
        "tram.fill",
    ]
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symbolPreview.image = UIImage(systemName: symbolNames[index])
        symbolPreview.tintColor = UIColor.periwinkle
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func nextPic()
    {
        if index < symbolNames.count
        {
            index = index + 1
            symbolPreview.image = UIImage(systemName: symbolNames[index])
        }
        
        else if index == symbolNames.count
        {
            index = 0
            symbolPreview.image = UIImage(systemName: symbolNames[index])
        }
    }
    
    @IBAction func prevPic()
    {
        if index > 0
        {
            index = index - 1
            symbolPreview.image = UIImage(systemName: symbolNames[index])
        }
        
        else if index == 0
        {
            index = symbolNames.count
            symbolPreview.image = UIImage(systemName: symbolNames[index])
        }
            
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        typeTextField.text = type[row]
        
        if let typeText = typeTextField.text
        {
            if let errorMessage = invalidType(typeText)
            {
                type_extensionValidate.text = errorMessage
                type_extensionValidate.isHidden = false
            } else
            {
                type_extensionValidate.isHidden = true
            }
        }
        checkValidForm()
       
    }
    
    func setPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        typeTextField.inputView = pickerView
        
        // default set value
        pickerView.selectRow(1, inComponent: 0, animated: true)
        pickerView(pickerView, didSelectRow: 1, inComponent: 0)
        
    }
    
    @IBAction func nameChanged(_ sender: Any) {
        if let name = nameTextField.text
        {
            if let errorMessage = invalidName(name)
            {
                nameValidate.text = errorMessage
                nameValidate.isHidden = false
            } else
            {
                nameValidate.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func descChanged(_ sender: Any) {
        if let desc = descTextField.text
        {
            if let errorMessage = invalidDesc(desc)
            {
                desc_Validate.text = errorMessage
                desc_Validate.isHidden = false
            } else
            {
                desc_Validate.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func saveButton(_ sender: Any)
    {
        let newProject = Projects(context: self.context)
        newProject.name = nameTextField.text
        newProject.type = typeTextField.text
        newProject.desc = descTextField.text
        newProject.symbol = symbolNames[index]
        
        if !assets.isEmpty && !asset_type.isEmpty
        {
            for x in 0..<assets.count
            {
                let newProjectAsset = AsseProj(context: self.context)
                
                newProjectAsset.name = assets[x]
                newProjectAsset.type = asset_type[x]
                newProjectAsset.isSet = false
                
                newProject.addToAssets(newProjectAsset)
                
            }
        }
        
        
        let alert = UIAlertController(title: "Success", message: "Successfully add project!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self]_ in
            self.navigationController?.popViewController(animated: true)
        }))
        
        do
        {
            try context.save()
            self.present(alert, animated: true)
        }
        
        catch
        {
            
        }
        
        
    }
    
    func invalidName(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Name should be filled"
        }
        return nil
    }
    
    func invalidDesc(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Desc must be filled"
        }
        return nil
    }
    
    func invalidType(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Type should be filled"
        }
        
        if !(value == "Design" || value == "Video Editing" || value == "Other")
        {
            return "Invalid asset type"
        }
        return nil
    }
    
    func checkValidForm() {
        if(nameValidate.isHidden && desc_Validate.isHidden)
        {
            saveButton.isEnabled = true
        }
        else
        {
            saveButton.isEnabled = false
        }
    }
    


}
