//
//  SubmitVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class SubmitVC : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var collectionFlavour: UICollectionView!
    @IBOutlet weak var collectionGuests: UICollectionView!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Custome
    
    func configureUI() {
        collectionGuests.delegate = self
        collectionGuests.dataSource = self
        var identifier = String(describing: GusestsListCell.self)
        var nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        collectionGuests.register(nibCell, forCellWithReuseIdentifier: identifier)
        
        identifier = String(describing: FlavourCell.self)
        nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        collectionFlavour.register(nibCell, forCellWithReuseIdentifier: identifier)
    }
    
    //------------------------------------------------------
    
    //MARK: CollectionView Delegate Datasource Method(s)
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionFlavour {
            return 12

        }else {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 5
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionGuests {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GusestsListCell", for: indexPath) as! GusestsListCell
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlavourCell", for: indexPath) as! FlavourCell
            return cell
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
