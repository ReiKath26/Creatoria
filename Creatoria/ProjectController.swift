//
//  ProjectController.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 27/04/22.
//

import UIKit
import CoreData


class ProjectController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate
{
    
    var projects = [Projects]()
    var allAssets = [AsseProj]()

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var projects_progress : UICollectionView!
    
    private let bookImage: UIImageView =
    {
        let imageView = UIImageView(frame: CGRect(x: 46, y: 300, width: 307, height: 206))
        imageView.image = UIImage(named: "Book Blue")
        return imageView
        
    }()
    
    private let textEmpty: UILabel =
    {
        let textLabel = UILabel(frame: CGRect(x: -30, y: 500, width: 500, height: 100))
        textLabel.text = "No Project added yet...."
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.lightGray
        return textLabel
    }()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//    func viewdidload{
//
//    }
//
//    func numberOfsECTION(){
//        folders.count
//    }
//
//    func numberofrow(indexpath: IndexPath){
//        folders[indexpath.section].asset?.count
//    }
//
//    func cell(indexpath: IndexPath){
//        let asset = folders[indexpath.section].assetArray[indexpath.row]
//
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchProject()
        checkData()
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var projAssets: [AsseProj] = []
        
        for x in 0..<allAssets.count
        {
            if allAssets[x].project == projects[indexPath.row]
            {
                projAssets.append(allAssets[x])
            }
        }
        
        let assetCount = projAssets.count
        var setAssetCount = 0
        
        if !projAssets.isEmpty
        {
            for y in 0..<projAssets.count
            {
                if projAssets[y].isSet
                {
                    setAssetCount = setAssetCount + 1
                }
            }
            
          
        }
        
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "project_bar", for: indexPath) as! ProjectCell)
        cell.imageIcon.image = UIImage(systemName: projects[indexPath.row].symbol ?? "snowflake")
        cell.imageIcon.tintColor = UIColor.periwinkle
        cell.buttonTitle.setTitle(projects[indexPath.row].name, for: .normal)
        cell.assetSet.text = "\(setAssetCount)/\(assetCount) Assets Setted"
//        let shapeLayer = CAShapeLayer()
//
//        let center = cell.center
//
//        let circularPath = UIBezierPath(arcCenter: center, radius: 60, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
//        shapeLayer.path = circularPath.cgPath
//        shapeLayer.fillColor = UIColor.white.cgColor
//        shapeLayer.strokeColor = UIColor.periwinkle.cgColor
//        shapeLayer.lineWidth = 5
//
//        shapeLayer.strokeEnd = CGFloat(decimal)

//        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        basicAnimation.toValue = decimal
//        basicAnimation.duration = 2
//
//        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
//        basicAnimation.isRemovedOnCompletion = false
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "project_detail") as! Project_detail
        vc.project = projects[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProject))
          
          addButton.tintColor = UIColor.periwinkle
          
          navigationItem.rightBarButtonItem = addButton
        
        checkData()
        view.addSubview(bookImage)
        view.addSubview(textEmpty)
        // Do any additional setup after loading the view.
    }
    
  
    
    func checkData()
    {
        fetchProject()
        fetchProjectAsset()
        
        if projects.isEmpty
        {
            searchBar.isHidden = true
            projects_progress.isHidden = true
            bookImage.isHidden = false
            textEmpty.isHidden = false
        }
        
        else
        {
            searchBar.isHidden = false
            projects_progress.isHidden = false
            bookImage.isHidden = true
            textEmpty.isHidden = true
        }
    }
    
    func fetchProject()
    {
        let fetchRequest: NSFetchRequest<Projects> = Projects.fetchRequest()
        
        do
        {
            projects = try context.fetch(fetchRequest)
            
            DispatchQueue.main.async
            {
                self.projects_progress.reloadData()
            }
        }
        
        catch
        {
            
        }
    }
    
    func fetchProjectAsset()
    {
        do
        {
            allAssets = try context.fetch(AsseProj.fetchRequest())
            
        }
        
        catch
        {
            
        }
        
    }
    
    @objc func addProject()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "project_form") as!
        AddProjectController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        
        if searchText == ""
        {
            fetchProject()
        }
        
        else
        {
            projects = []
            
            do
            {
                let filteredRequest:NSFetchRequest<Projects> = Projects.fetchRequest()
                let pred = NSPredicate(format: "name CONTAINS '\(searchText)'")
                
                filteredRequest.predicate = pred
                
                self.projects = try context.fetch(filteredRequest)
                
                DispatchQueue.main.async {
                    self.projects_progress.reloadData()
                }
            }
            
            catch
            {
                
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        fetchProject()
        searchBar.showsCancelButton = false
    }

}
