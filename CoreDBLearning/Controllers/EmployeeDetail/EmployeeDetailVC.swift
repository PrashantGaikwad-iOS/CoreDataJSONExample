//
//  EmployeeDetailVC.swift
//  CoreDBLearning
//
//  Created by prashant on 30/12/22.
//

import UIKit

class EmployeeDetailVC: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var profilePhotoImgView: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    //MARK: - Properties
    private let manager = EmployeeManager()
    var selectedEmployee: Employee? = nil
    
    //MARK: - Initializers
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillSetUp()
    }
    
    //MARK: - Methods
    func viewWillSetUp() {
        self.nameTF.text = selectedEmployee?.name
        self.emailTF.text = selectedEmployee?.email
        self.profilePhotoImgView.image = UIImage(data: (selectedEmployee?.profilePicture)!)
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
//        let nsData: NSData = ... // your NSData object
//
//        if let jsonObject = try? JSONSerialization.jsonObject(with: nsData as Data, options: []) as? [String: Any] {
//            // jsonObject is now a Dictionary containing the JSON object
//        }
//
//        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: []), let jsonString = String(data: jsonData, encoding: .utf8) {
//            // jsonString is now a String containing the JSON object
//        }
        
        
        let employee = Employee(name: self.nameTF.text,
                                email: self.emailTF.text,
                                profilePicture: self.profilePhotoImgView.image?.pngData(),
                                id: selectedEmployee!.id,
                                jsonFile: self.selectedEmployee!.jsonFile)

        if(manager.updateEmployee(employee: employee)) {
           displayAlert(alertMessage: "Record Updated")
        } else {
            displayErrorAlert()
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        if(manager.deleteEmployee(id: selectedEmployee!.id)) {
            displayAlert(alertMessage: "Record deleted")
        } else {
            displayErrorAlert()
        }
    }
    

    // MARK: Private functions
    private func displayAlert(alertMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

    private func displayErrorAlert()
    {
        let errorAlert = UIAlertController(title: "Alert", message: "Something went wrong, please try again later", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
    }
}
