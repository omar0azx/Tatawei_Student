//
//  LeaderBoardVC.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 06/11/2024.
//

import UIKit
import FirebaseFirestore
class LeaderBoardVC: UIViewController, Storyboarded {
    
    // MARK: - Variables
    
    var coordinator: MainCoordinator?
    var arrStudent: [Student] = []
    let db = Firestore.firestore()
    
    
    // MARK: - IBOutlets
    
@IBOutlet weak var filterBySchoolButton: UIButton!
@IBOutlet weak var filterByCityButton: UIButton!
@IBOutlet weak var filterByAllButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highlightSelectedButton(selectedButton: filterByAllButton)
        
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

    @IBAction func filterBySchoolBTN(_ sender: Any) {
    
        filterBySchool(schoolName: "\(Student.currentStudent?.school ?? "")")
        highlightSelectedButton(selectedButton: filterBySchoolButton)
}


    @IBAction func filterByCityBTN(_ sender: Any) {
   
        filterByCity(cityName: "\(Student.currentStudent?.city ?? "")")
        highlightSelectedButton(selectedButton: filterByCityButton)
}


    @IBAction func filterByAllBTN(_ sender: Any) {
   
        fetchAllStudents()
        highlightSelectedButton(selectedButton: filterByAllButton)
}

    
    //MARK: - Firestore Fetch Functions
    
    func fetchAllStudents() {
        db.collection("schools").getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot, error == nil else {
                print("Error fetching all students: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.arrStudent = []
            
            // Loop through all schools and fetch students
            for document in querySnapshot.documents {
                let schoolRef = document.reference
                schoolRef.collection("students").getDocuments { (studentSnapshot, error) in
                    guard let studentSnapshot = studentSnapshot else { return }
                    for studentDoc in studentSnapshot.documents {
                        if let student = try? studentDoc.data(as: Student.self) {
                            self.arrStudent.append(student)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func filterBySchool(schoolName: String) {
        db.collection("schools").whereField("name", isEqualTo: schoolName).getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot, error == nil else {
                print("Error fetching students by school: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.arrStudent = []
            
            for document in querySnapshot.documents {
                document.reference.collection("students").getDocuments { (studentSnapshot, error) in
                    guard let studentSnapshot = studentSnapshot else { return }
                    for studentDoc in studentSnapshot.documents {
                        if let student = try? studentDoc.data(as: Student.self) {
                            self.arrStudent.append(student)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func filterByCity(cityName: String) {
        db.collection("schools").whereField("city", isEqualTo: cityName).getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot, error == nil else {
                print("Error fetching students by city: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.arrStudent = []
            
            for document in querySnapshot.documents {
                document.reference.collection("students").getDocuments { (studentSnapshot, error) in
                    guard let studentSnapshot = studentSnapshot else { return }
                    for studentDoc in studentSnapshot.documents {
                        if let student = try? studentDoc.data(as: Student.self) {
                            self.arrStudent.append(student)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }



// MARK: - Helper Functions
    func highlightSelectedButton(selectedButton: UIButton) {
        filterBySchoolButton.backgroundColor = .lightGray
        filterByCityButton.backgroundColor = .lightGray
        filterByAllButton.backgroundColor = .lightGray
        selectedButton.backgroundColor = .standr
    }

}

extension LeaderBoardVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath) as! LeaderBoardCell
        
        let student = arrStudent[indexPath.row]
        let rank = indexPath.row + 1
        
        var topThreeImage: UIImage?
        
        switch rank {
        case 1:
            topThreeImage = UIImage(named: "gold-medal") // 1st place icon
        case 2:
            topThreeImage = UIImage(named: "silver-medal") // 2nd place icon
        case 3:
            topThreeImage = UIImage(named: "bronze-medal") // 3rd place icon
        default:
            topThreeImage = nil 
        }
        cell.config(numbering: rank,
                    hours: Int(student.hoursCompleted),
                    genderIcon: UIImage(named: student.gender == .male ? "manIcon" : "femaleIcon") ?? UIImage(),
                    name: student.name,
                    topThree: topThreeImage ?? UIImage()
        )
        return cell
    }
}
