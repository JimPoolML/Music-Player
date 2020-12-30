//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by Jim Pool Moreno on 29/12/20.
//  Copyright © 2020 Jim Pool Moreno. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    //MARK: - Public
    public var position: Int = 0
    public var listSongs : [ListSongs] = []
    
    //MARK: - Outs
    @IBOutlet var holder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 1 {
            manage()
        }
    }
    
    func manage(){
        //manage player
        
        //manage every elements (inlcude interface)
    }

}
