//
//  LeaderBoardVC.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 06/11/2024.
//

import UIKit
import FirebaseFirestore
class ScoreBoardVC: UIViewController, Storyboarded {
    
    enum Mode {
        case allStudents
        case studentsSchool
    }
    
    // MARK: - Variables
    
    var coordinator: MainCoordinator?
    
    var students: [Student] = []
    
    var mode: Mode = .studentsSchool
    
    // MARK: - IBOutlets
    
    @IBOutlet var filteredBTN: [DesignableButton]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if mode == .studentsSchool {
            getStudentsFromSchool()
        } else {
            getAllStudents()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didPressedFiltered(_ sender: UIButton) {
        if sender.tag == 0 {
            mode = .studentsSchool
            getStudentsFromSchool()
            filteredBTN[0].backgroundColor = .standr
            filteredBTN[1].backgroundColor = .systemGray5
        } else {
            mode = .allStudents
            getAllStudents()
            filteredBTN[1].backgroundColor = .standr
            filteredBTN[0].backgroundColor = .systemGray5
        }
    }
    
    func getStudentsFromSchool() {

        if let studentSchool = Student.currentStudent?.school {
            StudentDataServices.shared.getAllStudentsFromSchool(schoolID: studentSchool) { allstudents, error in
                if error != nil {
                    print("No students found.")
                } else {
                    self.students = allstudents.sorted { $0.hoursCompleted > $1.hoursCompleted }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        } else {
            print("No school found for the current student.")
        }
    }

    
    func getAllStudents() {

        StudentDataServices.shared.getAllStudents { allstudents, error in
            if error != nil {
                print("No students found.")
            } else {
                self.students = allstudents.sorted { $0.hoursCompleted > $1.hoursCompleted }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}

extension ScoreBoardVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath) as! LeaderBoardCell
        
        let student = students[indexPath.row]
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
        cell.config(numbering: rank, hours: Int(student.hoursCompleted), genderIcon: UIImage(named: student.gender == .male ? "man" : "women") ?? UIImage(), name: student.name, topThree: topThreeImage ?? UIImage())
        return cell
    }
}
