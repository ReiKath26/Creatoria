//
//  AddSoundController.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 27/04/22.
//

import UIKit

class AddSoundController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var symbolPreview: UIImageView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var file_extensionTextField: UITextField!
    @IBOutlet var sourceTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var file_locationTextField: UITextField!
    @IBOutlet var descTextField: UITextField!
    @IBOutlet var durationBar: UISlider!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var durationText: UILabel!
    
    @IBOutlet var nameValidate: UILabel!
    @IBOutlet var sourceValidate: UILabel!
    @IBOutlet var file_extensionValidate: UILabel!
    @IBOutlet var type_extensionValidate: UILabel!
    @IBOutlet var file_locationValidate: UILabel!
    @IBOutlet var desc_Validate: UILabel!
    @IBOutlet var duration_Validate: UILabel!
    
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

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var pickerView = UIPickerView()
    
    var folders = [Folder]()
    
    let type = ["BGM", "Sound Effect", "Ambience"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setPickerView()
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
    
    @IBAction func sourceChanged(_ sender: Any) {
        if let source = sourceTextField.text
        {
            if let errorMessage = invalidSource(source)
            {
                sourceValidate.text = errorMessage
                sourceValidate.isHidden = false
            } else
            {
                sourceValidate.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func fileExtensionChanged(_ sender: Any) {
        if let file_ex = file_extensionTextField.text
        {
            if let errorMessage = invalidfileExtension(file_ex)
            {
                file_extensionValidate.text = errorMessage
                file_extensionValidate.isHidden = false
            } else
            {
                file_extensionValidate.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func fileLocationChanged(_ sender: Any) {
        if let file_loc = file_locationTextField.text
        {
            if let errorMessage = invalidFileLocation(file_loc)
            {
                file_locationValidate.text = errorMessage
                file_locationValidate.isHidden = false
            } else
            {
                file_locationValidate.isHidden = true
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
    
    @IBAction func durationChanged(_ sender: Any)
    {
        durationText.text = "\(durationBar.value)"
        
        if let errorMessage = invalidDuration(durationBar.value)
            {
                duration_Validate.text = errorMessage
                duration_Validate.isHidden = false
            }
            
            else
            {
                duration_Validate.isHidden = true
            }
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        fetchFolder()
        
        let newSounds = Assets(context: self.context)
        
        newSounds.name = nameTextField.text
        newSounds.type = typeTextField.text
        newSounds.source = sourceTextField.text
        newSounds.file_extension = file_extensionTextField.text
        newSounds.symbol = symbolNames[index]
        
        if !folders.isEmpty
        {
            var flag = 0
            
            for x in 0..<folders.count
            {
                if folders[x].directory == file_locationTextField.text
                {
                    folders[x].addToAsset(newSounds)
                    flag = 0
                    break
                }
                
                else
                {
                    flag = 1
                }
            }
            
            if flag == 1
            {
                let folder = Folder(context: self.context)
                folder.directory = file_locationTextField.text
                folder.addToAsset(newSounds)
            }
        }
        newSounds.desc = descTextField.text
        newSounds.duration = Double(durationBar.value)
        
        let alert = UIAlertController(title: "Success", message: "Successfully add asset!", preferredStyle: .alert)
        
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
    
    func fetchFolder()
    {
        do
        {
            folders = try context.fetch(Folder.fetchRequest())
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
    
    
    func invalidfileExtension(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "File Extension must be filled"
        }
        return nil
    }
    
    func invalidSource(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Source must be filled"
        }
        return nil
    }
    
    func invalidFileLocation(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "File Location must be filled"
        }
        return nil
    }
    
    func invalidDuration(_ value: Float) -> String?
    {
        if value == 0
        {
            return "Duration should be more than 0"
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
        
        if !(value == "BGM" || value == "Sound Effect" || value == "Ambience")
        {
            return "Invalid asset type"
        }
        return nil
    }
    
    func checkValidForm() {
        if(nameValidate.isHidden && sourceValidate.isHidden && desc_Validate.isHidden && duration_Validate.isHidden && file_locationValidate.isHidden && file_extensionValidate.isHidden && type_extensionValidate.isHidden)
        {
            saveButton.isEnabled = true
        }
        else
        {
            saveButton.isEnabled = false
        }
    }

}
