//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by Jim Pool Moreno on 29/12/20.
//  Copyright © 2020 Jim Pool Moreno. All rights reserved.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {

    //MARK: - Public
    public var position: Int = 0
    public var listSongs : [ListSongs] = []
    
    //MARK: - Outs
    @IBOutlet var holder: UIView!
//    var player = AVAudioPlayer()
    var player: AVAudioPlayer? = AVAudioPlayer()
    
    //MARK: interface elments
    private let albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songLabel: UILabel = {
        let label = UILabel()
        //Single Line
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let albumLabel: UILabel = {
        let label = UILabel()
        //Single Line
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        //Single Line
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let playPauseButton = UIButton()
    
    //MARK: - Begin
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            manage()
        }
    }
    
    func manage(){
        //manage player
        let mySong = listSongs[position]
        //Get url song
        let url = Bundle.main.path(forResource: mySong.trackName, ofType: "mp3")
        //let urlString = URL(string: url!)
//        let url = Bundle.main.url(forResource: mySong.trackName, withExtension: "mp3")
//        let urlString = url
        
        //Secure operation
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            //
            guard let url = url else{
                print("urlString is null")
                return
            }
            //Set player
            //let urlString = URL(string: url)
//            player = try AVAudioPlayer(contentsOf: URL(string: url)!)
////            player = try AVAudioPlayer(contentsOf: urlString)
//            guard let player = player else{
//                print("player is null")
//                return
//            }
            do{
                try player = AVAudioPlayer(contentsOf: URL(
                    fileURLWithPath: url))
                //Cast and set the maximus value
            }catch{
                print("Error to load file")
            }
            
            player?.volume = 0.5
            player?.play()
            
        }catch {
            print("Error ocurred")
        }
        //manage every elements (inlcude interface)
        albumImage.frame = CGRect(x: 10, y: 10, width: holder.frame.size.width-20, height: holder.frame.size.width-20)
        
        albumImage.image = UIImage(named: mySong.imgName)
        holder.addSubview(albumImage)
        
        //Labels
        songLabel.frame = CGRect(x: 10, y: albumImage.frame.size.height+10, width: holder.frame.size.width-20, height: 70)
        albumLabel.frame = CGRect(x: 10, y: albumImage.frame.size.height+80, width: holder.frame.size.width-20, height: 70)
        artistLabel.frame = CGRect(x: 10, y: albumImage.frame.size.height+150, width: holder.frame.size.width-20, height: 70)
        
        songLabel.text = mySong.name
        albumLabel.text = mySong.albumName
        artistLabel.text = mySong.singerName
        
        holder.addSubview(songLabel)
        holder.addSubview(albumLabel)
        holder.addSubview(artistLabel)
        
        // Button controls
        let nextButton = UIButton()
        let backButton = UIButton()
        
        // Button Position in frame
        let yPosition = artistLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 50

        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)

        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)

        backButton.frame = CGRect(x: 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        // Add button actions
        playPauseButton.addTarget(self, action: #selector(didPPButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didBackButton), for: .touchUpInside)
        
        // Set image buttons
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)

        playPauseButton.tintColor = .purple
        backButton.tintColor = .purple
        nextButton.tintColor = .purple

        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        //Simple slider
        let mySlider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height-60, width: holder.frame.size.width-40, height: 45))
        mySlider.value = 0.5
        mySlider.addTarget(self, action: #selector(didSlideVolume(_:)), for: .valueChanged)
        holder.addSubview(mySlider)
    }
    
    func reloadSong(){
        player?.stop()
        for subview in holder.subviews {
            subview.removeFromSuperview()
        }
        manage()
    }
    
    @objc func didBackButton() {
        if position > 0 {
            position = position - 1
        }else{
            position = listSongs.count
        }
        reloadSong()
    }

    @objc func didNextButton() {
        if position < (listSongs.count - 1) {
            position = position + 1
        }else{
            position = 0
        }
        reloadSong()
    }

    @objc func didPPButton() {
        if player?.isPlaying == true {
            // pause
            player?.pause()
            // show play button
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)

            // shrink image
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImage.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: self.holder.frame.size.width-60,
                                                   height: self.holder.frame.size.width-60)
            })
        }
        else {
            // play
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)

            // increase image size
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImage.frame = CGRect(x: 10,
                                              y: 10,
                                              width: self.holder.frame.size.width-20,
                                              height: self.holder.frame.size.width-20)
            })
        }
    }
    
    @objc func didSlideVolume(_ slider: UISlider){
        //adjust player volume
        let volume = slider.value
        player?.volume = volume
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        if let player = player{
            player.stop()
        }
    }
    
}
