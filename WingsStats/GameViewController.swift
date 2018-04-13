//
//  GameViewController.swift
//  WingsStats
//
//  Created by Victor Fundberg on 2018-04-13.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    var selectedPlayers : [String] = []
    var selectedIndexPath : [IndexPath] = []
    var players : [String] = []
    var newGame = Game()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        players = ["Victor Fundberg","Claudio Agus","Joakim Örneflo","Johannes Andersson","Jacob Henriksson","Alessandro Agus","Andreas Esmyr","Christoffer Strand","Adam Broberg","Peter Morero","Tobias Bengston","Andreas Lundin","Pontus Vallin"]
    //    addPlayersToGame()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPlusStat(_ sender: Any) {
        selectedIndexPath = self.tableView.indexPathsForSelectedRows!
        for p in selectedIndexPath {
            selectedPlayers.append(p.description)
        }
        print(selectedPlayers)
        for p in selectedIndexPath {
            tableView.deselectRow(at: p, animated: true)
        }
    }
    
//    func addPlayersToGame () {
//        for p in players {
//            let newPlayer = Player()
//            newPlayer.name = p.key
//            newPlayer.position = p.value
//        }
//
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = players[indexPath.row]
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
