//
//  ViewController.swift
//  CoreDBLearning
//
//  Created by prashant on 29/12/22.
//

import UIKit

class ViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var profilePhotoImgView: UIImageView!
    
    
    //MARK: - Properties
    private let manager: EmployeeManager = EmployeeManager()
    
    //MARK: - Initializers
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Create Employee"
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(path[0])
    }
    
    //MARK: - Methods
    @IBAction func createAction(_ sender: Any) {
        createEmployee()
    }
    
    func createEmployee() {
        if let fileUrl = Bundle.main.url(forResource: "temp", withExtension: "json"),
           let data = try? Data(contentsOf: fileUrl) {
            do {
                let json = String(decoding: data, as: UTF8.self)
                let employee = Employee(name: nameTF.text,
                                        email: emailTF.text,
                                        profilePicture: profilePhotoImgView.image?.pngData(),
                                        id: UUID(),
                                        jsonFile: data)
                manager.createEmployee(employee: employee)
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeListVC") as! EmployeeListVC
                self.navigationController?.pushViewController(vc, animated: true)
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }

    @IBAction func selectProfilePhotoAction(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }
}


extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // MARK: Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[.originalImage] as? UIImage
        self.profilePhotoImgView.image = img
        dismiss(animated: true, completion: nil)
    }
}
