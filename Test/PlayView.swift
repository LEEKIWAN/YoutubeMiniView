//
//  ViewController.swift
//  Test
//
//  Created by kiwan on 2020/01/03.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit
import AVKit

class PlayView: UIView {

    let imageList = [UIImage(named: "Unknown-1"), UIImage(named: "Unknown-2"), UIImage(named: "Unknown-3"), UIImage(named: "Unknown-4"), UIImage(named: "Unknown-5"), UIImage(named: "Unknown-6"), UIImage(named: "Unknown-7"), UIImage(named: "Unknown-8"), UIImage(named: "Unknown-9"), UIImage(named: "Unknown-10"), UIImage(named: "Unknown-11"), UIImage(named: "Unknown-12"), UIImage(named: "Unknown-13"), UIImage(named: "Unknown-14")]
    let titleList = ["동해물과 백두산이 마륵고 닳도록 하느님이 보우하사 우리나라만세", "@IBOutlet@IBOutlet@IBOutlet@IBOutlet@IBOutlet@IBOutlet@IBOutlet@IBOutlet@IBOutlet", "mageUIImageUIImageUIImageUIImage"]
    let writerList = ["Steve Jobs", "ㅎㅇ", "First"]
    let viewCountList = ["조회수 9.3천회", "조회수 10.3만회", "조회수 2천회"]
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomButton: UIButton!
    
    var playerLayer: AVPlayerLayer!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.initPlayer()
//    }
//
//    func initPlayer() {
//        let playItem = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
//        let player = AVPlayer(url: playItem!)
//        playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.videoView.bounds
//        self.videoView.layer.addSublayer(playerLayer)
//
//        player.play()
//    }
//
//    override func viewDidLayoutSubviews() {
//        playerLayer.frame = self.videoView.bounds
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension PlayView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier") as! YouTubeTableViewCell
        cell.thumbnailImageView?.image = imageList[indexPath.row]
        
        if indexPath.row % 3 == 1 {
            cell.titleLabel.text = titleList[0]
            cell.writerLabel.text = writerList[0]
            cell.viewCountLabel.text = viewCountList[0]
        }
        else if indexPath.row % 3 == 2 {
            cell.titleLabel.text = titleList[1]
            cell.writerLabel.text = writerList[1]
            cell.viewCountLabel.text = viewCountList[1]
        }
        else if indexPath.row % 3 == 0 {
            cell.titleLabel.text = titleList[2]
            cell.writerLabel.text = writerList[2]
            cell.viewCountLabel.text = viewCountList[2]
        }
        
        return cell
    }
}
