//
//  EmployeeListVC.swift
//  CoreDBLearning
//
//  Created by prashant on 30/12/22.
//

import UIKit

class EmployeeListVC: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var employeesTV: UITableView!
    
    //MARK: - Properties
    private let manager = EmployeeManager()
    var employees : [Employee]? = nil
    
    //MARK: - Initializers
    //MARK: - View Life Cycle Methods
    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "List of Employees"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        employees = manager.fetchEmployee()
        if(employees != nil && employees?.count != 0) {
            self.employeesTV.reloadData()
        }
    }
}

extension EmployeeListVC : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.employees!.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as? EmployeeTVCell {
            let employee = self.employees![indexPath.row]
           
            cell.nameLabel.text = employee.name
            cell.profilePhotoImgView.image = UIImage(data: employee.profilePicture!)
            
            do {
                let teamDataArray = try JSONDecoder().decode([User].self, from: employee.jsonFile!)
                print(teamDataArray)
            }catch(let error) {
                print(error)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailVC") as? EmployeeDetailVC
        detailsView?.selectedEmployee = self.employees![self.employeesTV.indexPathForSelectedRow!.row]
        self.navigationController?.pushViewController(detailsView!, animated: true)
    }
    
    // Convert from NSData to json object
    func nsdataToJSON(data: NSData) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as AnyObject
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}
