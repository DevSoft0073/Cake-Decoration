//
//  DailyInventoryVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class DailyInventoryVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblList: UITableView!
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
    
    func configureUI(){
                
        let identifier = String(describing: DailyInventoryCell.self)
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblList.register(nibCell, forCellReuseIdentifier: identifier)
        tblList.delegate = self
        tblList.dataSource = self
        tblList.separatorStyle = .none
    }
    
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyInventoryCell.self)) as? DailyInventoryCell {
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
