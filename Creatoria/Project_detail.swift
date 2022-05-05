//
//  Project_detail.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 28/04/22.
//

import UIKit
import CoreData

class Project_detail: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    
    @IBOutlet var icon: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var segmentView: UISegmentedControl!
    @IBOutlet var desc : UILabel!
    @IBOutlet var addAsset: UIButton!
    @IBOutlet var detailTable : UITableView!
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight  = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var segmentIndex = 0
    var project: Projects?
    var chooseAsset = [Assets]()
    
    var type: [String] = ["Name", "Type"]
    var value = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(openAlert))
        
        value.append(project?.name ?? "No Project")
        value.append(project?.type ?? "Project Type")
        
        name.text = project?.name
        desc.text = project?.desc
        addAsset.isHidden = true
        icon.image = UIImage(systemName: project?.symbol ?? "")
        icon.tintColor = UIColor.periwinkle
        
        trashButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = trashButton
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl)
    {
        segmentIndex = sender.selectedSegmentIndex
        detailTable.reloadData()
        
        if sender.selectedSegmentIndex == 0
        {
            addAsset.isHidden = true
        }
        
        else
        {
            addAsset.isHidden = false
        }
    }
    
    @IBAction func addAsset(_ sender: Any)
    {
        let alert = UIAlertController(title: "New Project Asset", message: "Add name and format (Image/Video/Sounds)", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in guard let field = alert.textFields?.first, let field2 = alert.textFields?.last, let newName = field.text, let newType = field2.text, !newName.isEmpty && !newType.isEmpty else
             {
                 return
             }
            
            self?.addToProjectAsset(name: newName, type: newType)
             
        }))
        
        self.present(alert, animated: true)
    }
    
    func addToProjectAsset(name: String, type: String)
    {
        let proj = AsseProj(context: self.context)
        proj.name = name
        proj.type = type
        project?.addToAssets(proj)
        
        do
        {
            try context.save()
            detailTable.reloadData()
        }
        
        catch
        {
            
        }
    }
    
    @objc func openAlert()
    {
        let alert = UIAlertController(title: "Delete Item", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {[self]_ in
            self.deleteItem(item: project!)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: {_ in
            alert.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
    
    func deleteItem(item: Projects)
    {
        context.delete(item)
        
        do
        {
            try context.save()
            self.navigationController?.popViewController(animated: true)
        }
        
        catch
        {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentIndex == 0
        {
            return type.count
        }
        
        else
        {
            return project?.assetArray?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
        let setAction : UITableViewRowAction
        
            if segmentIndex == 1
            {
                let setActionTitle = project?.assetArray?[indexPath.row].isSet ?? false ? "Unsset" : "Set"
                setAction = UITableViewRowAction(style: .default, title: setActionTitle) { [self]_, indexPath in
                    
                    print(project?.assetArray?[indexPath.row].type)
        
                    if !(project?.assetArray?[indexPath.row].isSet ?? false) || project?.assetArray?[indexPath.row].isSet == nil
                    {
                        let typeOfAsset: String = project?.assetArray?[indexPath.row].type ?? "Image"
                        fetchAssets(typeOfAsset: typeOfAsset)
                        
                        let vc = UIViewController()
                        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
                        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
                        pickerView.delegate = self
                        pickerView.dataSource = self
                        
                        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
                        
                        vc.view.addSubview(pickerView)
                        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
                        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
                        
                        let alert = UIAlertController(title: "Select Asset to set into Project", message: "", preferredStyle: .actionSheet)
                        
                        alert.setValue(vc, forKey: "contentViewController")
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
                            self.chooseAsset.removeAll()
                            alert.dismiss(animated: true)
                        }))
                        
                        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { [self]_ in
                            selectedRow = pickerView.selectedRow(inComponent: 0)
                            project?.assetArray?[indexPath.row].isSet = true
                            project?.assetArray?[indexPath.row].assets = chooseAsset[selectedRow]
                            
                            do
                            {
                                try context.save()
                                detailTable.reloadData()
                            }
                            
                            catch
                            {
                                
                            }
                        }))
                        
                        self.present(alert, animated: true)
                        
                        
                    }
                    
                    else if project?.assetArray?[indexPath.row].isSet == true
                    
                    {
                        let alert = UIAlertController(title: "Are you sure?", message: "The asset will be unlinked from the project", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self]_ in
                            
                            project?.assetArray?[indexPath.row].assets = nil
                            project?.assetArray?[indexPath.row].isSet = false
                            
                            do
                            {
                                try context.save()
                                detailTable.reloadData()
                            }
                            catch
                            {
                                
                            }
                        }))
                        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
                            alert.dismiss(animated: true)
                        }))
                        
                        self.present(alert, animated: true)
                    }
                }
            }
        
        else
        {
            setAction = UITableViewRowAction(style: .default, title: "Check", handler: { _, indexPath in
                
            })
        }
        
        setAction.backgroundColor = UIColor.sunnyYellow
            
        return [setAction]
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        
        let name : String = chooseAsset[row].name ?? ""
        let ext : String = chooseAsset[row].file_extension ?? ""
        label.text = "\(name).\(ext)"
        label.sizeToFit()
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        chooseAsset.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    
    func fetchAssets(typeOfAsset : String)
    {
        do
        {
            let filteredRequest: NSFetchRequest<Assets> = Assets.fetchRequest()
            let pred = NSPredicate(format: "file_type CONTAINS '\(typeOfAsset)'")
            
            filteredRequest.predicate = pred
            
            self.chooseAsset = try context.fetch(filteredRequest)
        }
        
        catch
        {
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "data_cell", for: indexPath) as! ProjectTableCell)
        if segmentIndex == 0
        {
            cell.mainText.text = type[indexPath.row]
            cell.detailText.text = value[indexPath.row]
        }
        
        else
        {
            if project?.assetArray?[indexPath.row].isSet == true
            {
                cell.mainText.text = project?.assetArray?[indexPath.row].name
                cell.detailText.text = project?.assetArray?[indexPath.row].assets?.name
            }
            
            else
            {
                cell.mainText.text = project?.assetArray?[indexPath.row].name
                cell.detailText.text = "Not yet set"
            }
          
        }
        
        return cell
    }

}
