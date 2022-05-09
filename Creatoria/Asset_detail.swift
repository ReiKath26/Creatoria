//
//  Asset_detail.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 28/04/22.
//

import UIKit

class Asset_detail: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var icon: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var segmentView: UISegmentedControl!
    @IBOutlet var desc : UILabel!
    @IBOutlet var detailTable : UITableView!
    @IBOutlet var headText : UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var segmentIndex = 0
    var asset: Assets?
    
    var type: [String] = ["Name", "File Extension", "Source", "Type", "Duration"]
    
    var value : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(openAlert))
        
        
        value.append(asset?.name ?? "No Asset")
        value.append(asset?.file_extension ?? "No format")
        value.append(asset?.source ?? "No source")
        value.append(asset?.type ?? "No type")
    
        value.append("\(asset?.duration ?? 0)" )
        
        let directory : String = asset?.folder?.directory ?? ""
        headText.text = "File folder: \(directory)"
    
        let nameee: String = asset?.name ?? ""
        let ext: String = asset?.file_extension ?? ""
      
        name.text = "\(nameee).\(ext)"
        desc.text = asset?.desc
        icon.image = UIImage(systemName: asset?.symbol ?? "")
        icon.tintColor = UIColor.periwinkle
        
        trashButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = trashButton
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl)
    {
        segmentIndex = sender.selectedSegmentIndex
        
        if segmentIndex == 0
        {
            let directory : String = asset?.folder?.directory ?? ""
            headText.text = "File folder: \(directory)"
        }
        
        else
        {
            headText.text = "Project                                                  Usage"
        }
        detailTable.reloadData()
    }

    @objc func openAlert()
    {
        let alert = UIAlertController(title: "Delete Item", message: "Are you sure you want to delete this item?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {[self]_ in
            self.deleteItem(item: asset!)
        }))

        alert.addAction(UIAlertAction(title: "No", style: .default, handler: {_ in
            alert.dismiss(animated: true)
        }))

        self.present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if segmentIndex == 0
        {
            return type.count
        }

        else
        {
            return asset?.assetInProject?.count ?? 0
        }
    }
    
    
    func deleteItem(item: Assets)
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = (tableView.dequeueReusableCell(withIdentifier: "asset_det_cell", for: indexPath) as! AssetCellTableViewCell)

        if segmentIndex == 0
        {
                cell.mainText.text = type[indexPath.row]
                cell.detailText.text = value[indexPath.row]
            
        }

        else
        {
            cell.mainText.text = asset?.assetInProject?[indexPath.row].project?.name
            cell.detailText.text = asset?.assetInProject?[indexPath.row].name
        }

        return cell
    }

}
