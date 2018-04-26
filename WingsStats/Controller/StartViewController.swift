//
//  StartViewController.swift
//  WingsStats
//
//  Created by Victor Fundberg on 2018-04-13.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    
    @IBOutlet weak var existingTeamButton: UIButton!
    var dataBase : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataBase = Database.database().reference()
        checkIfTeamsExist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkIfTeamsExist() {
        // kolla igenom databasen ifall det finns några lag med i den, i sånna fall så ska knappen med starta med lag visas, annars inte
        //if lag finns {
        // print("Teams are existing in the database")
        //} else {
        //existingTeamButton.isHidden = true
        //}
        
    }
    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view
//    }
    
}
