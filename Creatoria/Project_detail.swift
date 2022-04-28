//
//  Project_detail.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 28/04/22.
//

import UIKit

class Project_detail: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet var icon: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var segmentView: UISegmentedControl!
    @IBOutlet var desc : UILabel!
    @IBOutlet var addAsset: UIButton!
    @IBOutlet var detailTable : UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var segmentIndex = 0
    var project: Projects?
    
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
