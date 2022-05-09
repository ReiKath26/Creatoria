//
//  ViewController.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 27/04/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    let filter_image = ["Vector icon", "Pic Icon", "Video icon", "CD"]
    let filter_text = ["All", "Images", "Video", "Sound"]
    @IBOutlet var filter_catalog: UICollectionView!
    @IBOutlet var assetTable: UITableView!
    
    var index = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var folders = [Folder]()
    
    private let bookImage: UIImageView =
    {
        let imageView = UIImageView(frame: CGRect(x: 85, y: 300, width: 200, height: 200))
        imageView.image = UIImage(named: "Picture blue")
        return imageView
        
    }()
    
    private let textEmpty: UILabel =
    {
        let textLabel = UILabel(frame: CGRect(x: -50, y: 470, width: 500, height: 100))
        textLabel.text = "No asset added yet...."
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.lightGray
        return textLabel
    }()
    
    var imageArray : [Assets] = []
    var videoArray : [Assets] = []
    var soundsArray : [Assets] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAlert))
        
        addButton.tintColor = UIColor.periwinkle
//        dummyData()
        checkData()
        view.addSubview(bookImage)
        view.addSubview(textEmpty)
        print(folders.count)
        navigationItem.rightBarButtonItem = addButton
        // Do any additional setup after loading the view.
    }
    
    func checkData()
    {
        fetchFolder()
        
        if folders.isEmpty
        {
            filter_catalog.isHidden = true
            assetTable.isHidden = true
            bookImage.isHidden = false
            textEmpty.isHidden = false
            
        }
        
        else
        {
            filter_catalog.isHidden = false
            assetTable.isHidden = false
            bookImage.isHidden = true
            textEmpty.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkData()
        print(folders.count)
    }
    
    func dummyData()
    {
        
        let folder1 = Folder(context: self.context)
        folder1.directory = "PC_1/Documents/Footages"
        
        let folder2 = Folder(context: self.context)
        folder2.directory = "PC1_/Downloads/ForProjects"
        
        let folder3 = Folder(context: self.context)
        folder3.directory = "PC_2/Documents"
                             
                             
        let newAsset1 = Assets(context: self.context)
        newAsset1.name = "img_0001"
        newAsset1.type = "Photo"
        newAsset1.source = "Camera Canon 4D"
        newAsset1.symbol = "leaf.fill"
        newAsset1.file_extension = "jpeg"
        newAsset1.desc = "Picture of leaf"
        newAsset1.file_type = "Image"
        
        let newAsset2 = Assets(context: self.context)
        newAsset2.name = "img_0002"
        newAsset2.type = "Photo"
        newAsset2.source = "Camera Canon 4D"
        newAsset2.symbol = "sun.max.fill"
        newAsset2.file_extension = "jpeg"
        newAsset2.desc = "Beach Picture"
        newAsset2.file_type = "Image"
        
        let newAsset3 = Assets(context: self.context)
        newAsset3.name = "img_0003"
        newAsset3.type = "Photo"
        newAsset3.source = "Camera Canon 4D"
        newAsset3.symbol = "cloud.fill"
        newAsset3.file_extension = "jpeg"
        newAsset3.desc = "Image of clear blue sky"
        newAsset3.file_type = "Image"
        
        let newAsset4 = Assets(context: self.context)
        newAsset4.name = "img_0004"
        newAsset4.type = "Photo"
        newAsset4.source = "Camera Canon 4D"
        newAsset4.symbol = "moon.fill"
        newAsset4.file_extension = "jpeg"
        newAsset4.desc = "Moon Picture"
        newAsset4.file_type = "Image"
        
        let newAsset5 = Assets(context: self.context)
        newAsset5.name = "img_0005"
        newAsset5.type = "Photo"
        newAsset5.source = "Camera Canon 4D"
        newAsset5.symbol = "leaf.fill"
        newAsset5.file_extension = "jpeg"
        newAsset5.desc = "Picture of leaf"
        newAsset5.file_type = "Image"
        
        let newAsset6 = Assets(context: self.context)
        newAsset6.name = "vid_0001"
        newAsset6.type = "Footage"
        newAsset6.source = "Camera Canon 4D"
        newAsset6.symbol = "person.2.fill"
        newAsset6.duration = 120
        newAsset6.file_extension = "mov"
        newAsset6.desc = "Person gathering"
        newAsset6.file_type = "Video"
        
        let newAsset7 = Assets(context: self.context)
        newAsset7.name = "vid_0002"
        newAsset7.type = "Footage"
        newAsset7.source = "Camera Canon 4D"
        newAsset7.symbol = "person.2.fill"
        newAsset7.duration = 120
        newAsset7.file_extension = "mov"
        newAsset7.desc = "Person gathering"
        newAsset7.file_type = "Video"
        
        let newAsset8 = Assets(context: self.context)
        newAsset8.name = "vid_0003"
        newAsset8.type = "Footage"
        newAsset8.source = "Camera Canon 4D"
        newAsset8.symbol = "person.2.fill"
        newAsset8.duration = 120
        newAsset8.file_extension = "mov"
        newAsset8.desc = "Person gathering"
        newAsset8.file_type = "Video"
        
        let newAsset9 = Assets(context: self.context)
        newAsset9.name = "vid_0004"
        newAsset9.type = "Footage"
        newAsset9.source = "Camera Canon 4D"
        newAsset9.symbol = "person.2.fill"
        newAsset9.duration = 120
        newAsset9.file_extension = "mov"
        newAsset9.desc = "Person gathering"
        newAsset9.file_type = "Video"
        
        let newAsset10 = Assets(context: self.context)
        newAsset10.name = "bird_chirp"
        newAsset10.file_extension = "mp3"
        newAsset10.type = "BGM"
        newAsset10.source = "SoundFlix"
        newAsset10.symbol = "music.note"
        newAsset10.duration = 180
        newAsset10.desc = "Bird Chirping"
        newAsset10.file_type = "Sounds"
        
        let dummyProject1 = Projects(context: self.context)
        dummyProject1.name = "Winter Promotion"
        dummyProject1.type = "Edit Video"
        dummyProject1.desc = "Edit video for Winter Promotion"
        dummyProject1.symbol = "snowflake"
        
        let dummyProject2 = Projects(context: self.context)
        dummyProject2.name = "Summer Party Poster"
        dummyProject2.type = "Design"
        dummyProject2.desc = "Design Summer Poster for School"
        dummyProject2.symbol = "sun.max.fill"
        
        let asset1 = AsseProj(context: self.context)
        asset1.name = "Model Image"
        asset1.type = "Image"
        asset1.isSet = false
        
        let asset2 = AsseProj(context: self.context)
        asset2.name = "Blue Sky Image"
        asset2.type = "Image"
        asset2.isSet = false
        
        let asset3 = AsseProj(context: self.context)
        asset3.name = "Beach Image"
        asset3.type = "Image"
        asset3.isSet = true
        
        let asset4 = AsseProj(context: self.context)
        asset4.name = "Winter Street Vid"
        asset4.type = "Video"
        asset4.isSet = true
        
        let asset5 = AsseProj(context: self.context)
        asset5.name = "Chirp Bird Sound"
        asset5.type = "Sound"
        asset5.isSet = false
        
        newAsset2.addToIntoProject(asset3)
        newAsset6.addToIntoProject(asset4)
        
        dummyProject1.addToAssets(asset4)
        dummyProject1.addToAssets(asset5)
        
        dummyProject2.addToAssets(asset1)
        dummyProject2.addToAssets(asset2)
        dummyProject2.addToAssets(asset3)
        
        folder1.addToAsset(newAsset1)
        folder1.addToAsset(newAsset4)
        folder1.addToAsset(newAsset6)
        folder1.addToAsset(newAsset7)
        
        folder3.addToAsset(newAsset2)
        folder3.addToAsset(newAsset5)
        folder3.addToAsset(newAsset9)
        
        folder2.addToAsset(newAsset3)
        folder2.addToAsset(newAsset8)
        folder1.addToAsset(newAsset10)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter_image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "catalog_filter", for: indexPath) as? CatalogCategory)!
        
        if index == indexPath.row
        {
            UIView.animate(withDuration: 1) {
                cell.backgroundColor = UIColor.periwinkle
            }
            
        }
        cell.filter_icon.image = UIImage(named: filter_image[indexPath.row])
        cell.filter_name.text = filter_text[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        print(index)
        filter_catalog.reloadData()
        assetTable.reloadData()
    }
    
    @objc func openAlert()
    {
        let sheet = UIAlertController(title: "Choose Asset Type", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Image", style: .default, handler: {_ in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "image_form") as! AddImageController
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        sheet.addAction(UIAlertAction(title: "Video", style: .default, handler: {_ in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "video_form") as!
            AddVideoController
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Sounds", style: .default, handler: {_ in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "sound_form") as! AddSoundController
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            sheet.dismiss(animated: true)
        }))
        
        self.present(sheet, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if index == 1
        {
            let predicate = NSPredicate(format: "file_type CONTAINS 'Image'")
            
            return folders[section].asset?.filtered(using: predicate).count ?? 0
        }
        
        else if index == 2
        {
            let predicate = NSPredicate(format: "file_type CONTAINS 'Video'")
            return folders[section].asset?.filtered(using: predicate).count ?? 0
        }
        
        else if index == 3
        {
            let predicate = NSPredicate(format: "file_type CONTAINS 'Sounds'")
            return folders[section].asset?.filtered(using: predicate).count ?? 0
        }
        
        else
        {
            return folders[section].asset?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "asset_cell", for: indexPath) as! AssetTableCell
        
        imageArray.removeAll()
        videoArray.removeAll()
        soundsArray.removeAll()
        
        for x in 0..<folders[indexPath.section].assetArray!.count
        {
            if folders[indexPath.section].assetArray?[x].file_type == "Image"
            {
                imageArray.append(folders[indexPath.section].assetArray![x])
            }
            
            else if folders[indexPath.section].assetArray?[x].file_type == "Video"
            {
                videoArray.append(folders[indexPath.section].assetArray![x])
            }
            
            else if folders[indexPath.section].assetArray?[x].file_type == "Sounds"
            {
                soundsArray.append(folders[indexPath.section].assetArray![x])
            }
        }
        
        if index == 1
        {
            cell.imageAsset.image = UIImage(systemName: imageArray[indexPath.row].symbol ?? "snowflake")
            
            let name: String = imageArray[indexPath.row].name ?? ""
            let ext: String = imageArray[indexPath.row].file_extension ?? ""
            cell.assetName.text = "\(name).\(ext)"
            cell.imageAsset.tintColor = UIColor.periwinkle
        }
        
        else if index == 2
        {
            cell.imageAsset.image = UIImage(systemName: videoArray[indexPath.row].symbol ?? "snowflake")
            
            let name: String = videoArray[indexPath.row].name ?? ""
            let ext: String = videoArray[indexPath.row].file_extension ?? ""
            cell.assetName.text = "\(name).\(ext)"
            cell.imageAsset.tintColor = UIColor.periwinkle
        }
        
        else if index == 3
        {
            cell.imageAsset.image = UIImage(systemName: soundsArray[indexPath.row].symbol ?? "snowflake")
            
            let name: String = soundsArray[indexPath.row].name ?? ""
            let ext: String = soundsArray[indexPath.row].file_extension ?? ""
            cell.assetName.text = "\(name).\(ext)"
            cell.imageAsset.tintColor = UIColor.periwinkle
        }
        
        else
        {
            cell.imageAsset.image = UIImage(systemName: folders[indexPath.section].assetArray?[indexPath.row].symbol ?? "snowflake")
            
            let name: String = folders[indexPath.section].assetArray?[indexPath.row].name ?? ""
            let ext: String = folders[indexPath.section].assetArray?[indexPath.row].file_extension ?? ""
            cell.assetName.text = "\(name).\(ext)"
            cell.imageAsset.tintColor = UIColor.periwinkle
        }
       
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = folders[section].directory
        
        return title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        var frame = view.frame
        
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            frame.origin.y = frame.origin.y - 100
            view.frame = frame
        } completion: { success in
            frame.origin.y = frame.origin.y + 100
            view.frame = frame
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var frame = cell.contentView.frame
        
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            frame.origin.y = -50
            cell.contentView.frame = frame
        } completion: { success in
            frame.origin.y = 0
            cell.contentView.frame = frame
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        imageArray.removeAll()
        videoArray.removeAll()
        soundsArray.removeAll()
        
        for x in 0..<folders[indexPath.section].assetArray!.count
        {
            if folders[indexPath.section].assetArray?[x].file_type == "Image"
            {
                imageArray.append(folders[indexPath.section].assetArray![x])
            }
            
            else if folders[indexPath.section].assetArray?[x].file_type == "Video"
            {
                videoArray.append(folders[indexPath.section].assetArray![x])
            }
            
            else if folders[indexPath.section].assetArray?[x].file_type == "Sounds"
            {
                soundsArray.append(folders[indexPath.section].assetArray![x])
            }
        }

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "asset_detail") as! Asset_detail
        
        if index == 1
        {
            vc.asset = imageArray[indexPath.row]
        }
        
        else if index == 2
        {
            vc.asset = videoArray[indexPath.row]
        }
        
        else if index == 3
        {
            vc.asset = soundsArray[indexPath.row]
        }
        
        else
        {
            vc.asset = folders[indexPath.section].assetArray?[indexPath.row]
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchFolder()
    {
        
        let fetchReq: NSFetchRequest<Folder> = Folder.fetchRequest()
        let sortDecript = NSSortDescriptor(key: "directory", ascending: true)
        
        fetchReq.sortDescriptors = [sortDecript]
        do
        {
            folders = try context.fetch(fetchReq)
            
            DispatchQueue.main.async
            {
                self.assetTable.reloadData()
            }
        }
        
        catch
        {
            
        }
    }

}

