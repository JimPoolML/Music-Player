//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Jim Pool Moreno on 29/12/20.
//  Copyright © 2020 Jim Pool Moreno. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
        
    // MARK: - Out
    @IBOutlet var myTable: UITableView!
    
    // MARK: - Private
    private var listSongs = [ListSongs]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSong()
        
        myTable.delegate = self
        myTable.dataSource = self
        
    }
    
    func loadSong(){
        listSongs.append(ListSongs(name : "Background music",
                                   albumName: "123 Others",
                                   singerName: "Random",
                                   imgName: "cover1",
                                   trackName: "song1"))
        listSongs.append(ListSongs(name : "Havana",
                                   albumName: "Havana album",
                                   singerName: "Camilla Cabello",
                                   imgName: "cover2",
                                   trackName: "song2"))
        listSongs.append(ListSongs(name : "Viva la vida",
                                   albumName: "123 Something",
                                   singerName: "ColdPlay",
                                   imgName: "cover3",
                                   trackName: "song3"))
    }
    
    // MARK: - Table View options
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let auxSong = listSongs[indexPath.row]
        //Configuration
        cell.textLabel?.text = auxSong.name
        cell.detailTextLabel?.text = auxSong.albumName
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 16)
        cell.imageView?.image = UIImage(named: auxSong.imgName)
        cell.accessoryType = .disclosureIndicator
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTable.deselectRow(at: indexPath, animated: true)
        
        //Show the player (present)
        let position = indexPath.row
        //listSongs
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController else {
            return
        }
        //Constructor ??
        vc.listSongs = listSongs
        vc.position = position
        present(vc, animated: true)
    }
    
    


}

// MARK: - Struct
struct ListSongs {
    let name: String
    let albumName: String
    let singerName: String
    let imgName: String
    let trackName: String
}
