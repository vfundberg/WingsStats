//
//  AddNewTeamViewController.swift
//  WingsStats
//
//  Created by Victor Fundberg on 2018-04-16.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController {
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class AddNewTeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var addText: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startGameButton: UIButton!
    let newTeam :  Team =  Team()
    var dataBase : DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dataBase = Database.database().reference()
        self.hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func addTeam(_ sender: Any) {
        if addText.hasText {
            newTeam.teamName = addText.text!
            // ÄNDRA HÄR SÅ ATT DET HÄR SKAPAS ETT LAGNAMN DÄR SPELARNA KAN HAMNA UNDER, just nu blir det bara teams - players - Victor Fundberg
            dataBase.child("teams").child(newTeam.teamName).childByAutoId()
            teamLabel.text = newTeam.teamName
            print(newTeam.teamName)
            addButton.isHidden = true
            addText.text = ""
        } else {
            let alert = UIAlertController(title: "Error", message: "You have to give the team a name.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        if addText.hasText {
            let playerName = addText.text
            let newPlayer : Player = Player(name: playerName!)
            newTeam.playersInTeam.append(newPlayer)
            dataBase.child("teams").child(newTeam.teamName).child(playerName!).child("plusStat").setValue(0)
            dataBase.child("teams").child(newTeam.teamName).child(playerName!).child("minusStat").setValue(0)
            dataBase.child("teams").child(newTeam.teamName).child(playerName!).child("total").setValue(0)
            tableView.reloadData()
            for p in newTeam.playersInTeam {
            print(p.name)
        }
        addText.text = ""
        } else {
            let alert = UIAlertController(title: "Error", message: "You have to give the player a name.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func startGame(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newTeam.playersInTeam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerName", for: indexPath)
        cell.textLabel?.text = newTeam.playersInTeam[indexPath.row].name
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }


}
