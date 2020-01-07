//
//  ViewController.swift
//  Test
//
//  Created by kiwan on 2020/01/03.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit
import AVKit

enum GestureDirection {
    case vertical
    case horizontal
}

enum VideoState {
    case mini
    case max
}


class PlayViewController: UIViewController {
    
    let imageList = [UIImage(named: "Unknown-1"), UIImage(named: "Unknown-2"), UIImage(named: "Unknown-3"), UIImage(named: "Unknown-4"), UIImage(named: "Unknown-5"), UIImage(named: "Unknown-6"), UIImage(named: "Unknown-7"), UIImage(named: "Unknown-8"), UIImage(named: "Unknown-9"), UIImage(named: "Unknown-10"), UIImage(named: "Unknown-11"), UIImage(named: "Unknown-12"), UIImage(named: "Unknown-13"), UIImage(named: "Unknown-14")]
    let titleList = ["동해물과 백두산이 마륵고 닳도록 하느님이 보우하사 우리나라만세", "@IBOutlet@IBOutlet@IBOutlet@IBOutlet@IBOutlet@IBOutlet@IBOutlet@IBOutlet@IBOutlet", "mageUIImageUIImageUIImageUIImage"]
    let writerList = ["Steve Jobs", "ㅎㅇ", "First"]
    let viewCountList = ["조회수 9.3천회", "조회수 10.3만회", "조회수 2천회"]
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popupView: UIView!
    
    var playerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.initPlayer()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPanGestureRecognizer(_:)))
        videoView.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapGestureRecognizer(_:)))
        videoView.addGestureRecognizer(tapGesture)
    }
    
    func initPlayer() {
        let playItem = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        let player = AVPlayer(url: playItem!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoView.bounds
        self.videoView.layer.addSublayer(playerLayer)
        
        player.play()
    }
    
    override func viewDidLayoutSubviews() {
//        playerLayer.frame = self.videoView.bounds
    }
    
    var videoState: VideoState = .max
    
    var panGestureDirection: GestureDirection = .horizontal
    @IBOutlet weak var consLeft: NSLayoutConstraint!
    @IBOutlet weak var consRight: NSLayoutConstraint!
    @IBOutlet weak var consTop: NSLayoutConstraint!
    @IBOutlet weak var consVideoHeight: NSLayoutConstraint!
    @IBOutlet weak var consBottom: NSLayoutConstraint!
    @IBOutlet weak var consVideoRightMargin: NSLayoutConstraint!
    
    var maxTopMargin: CGFloat {
        self.view.frame.size.height - ( StaticVariable.miniVideoHeight * 2 - 10 )
    }
    
    var firstLocation = CGPoint()
    
    
    @objc
    func onPanGestureRecognizer(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self.view)
        let velocity = gesture.velocity(in: self.view)
        
        switch gesture.state {
        case .began:
            if abs(Float(velocity.y)) > abs(Float(velocity.x)) {
                panGestureDirection = .vertical
                firstLocation = location
            }
            else {
                panGestureDirection = .horizontal
            }
        case .changed:
            if panGestureDirection == .vertical {
                if videoState == .max {
                    //Top
                    let deltaY = location.y - firstLocation.y
                    
                    if deltaY < 0 {
                        break
                    }
                    
                    if(deltaY > maxTopMargin) {
                        consTop.constant = maxTopMargin
                    }
                    else {
                        consTop.constant = deltaY
                    }
                
                    //left right Bottom
                    var margin = deltaY / 40
                    if margin > 10 {
                        margin = 10
                    }
                    
                    consLeft.constant = margin
                    consRight.constant = margin
                    consBottom.constant = margin
                    
                    // Alpha
                    let alpha = 1 - deltaY / 600
                    tableView.alpha = alpha
                    self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
                    
                    consVideoHeight.constant = StaticVariable.videoHeight - (deltaY / 4.5)
//                    80
                
                    //video rightMargin
                    if(maxTopMargin == consTop.constant) {
                        var consRightMargin = (deltaY - maxTopMargin) * 3
                        if consRightMargin > 201 {
                            consRightMargin = 201
                        }
                        
                        consVideoRightMargin.constant = consRightMargin
                    }
                    else {
                        consVideoRightMargin.constant = 0
                    }
                    
                    print(deltaY , self.view.frame.size.height / 5)
                }
                else {
                    let deltaY = location.y - firstLocation.y
                    if deltaY > 0 {
                        minimizeVideoView()
                        break
                    }
                    
                    var margin = 10 + deltaY / 40
                    if margin < 0 {
                        margin = 0
                    }
                    consLeft.constant = margin
                    consRight.constant = margin
                    consBottom.constant = margin

                    let alpha = deltaY / 600
                    tableView.alpha = -alpha
                    self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: -alpha)


                    var consRightMargin = 201 + deltaY * 3
                    if consRightMargin < 0 {
                        consRightMargin = 0
                    }
                    
                    consVideoRightMargin.constant = consRightMargin
                    
                    var topMargin = maxTopMargin + deltaY
                    if topMargin < 0 {
                        topMargin = 0
                    }
                    consTop.constant = topMargin
                    
                    var videoHeight = StaticVariable.miniVideoHeight - deltaY / 4.5
                    if videoHeight > 230 {
                        videoHeight = 230
                    }
                    
                    consVideoHeight.constant = videoHeight
                    
                }
                
                
            }
        case .ended:
            let deltaY = location.y - firstLocation.y
            
            if velocity.y > 200 || (velocity.y >= 0 && self.view.frame.size.height / 5 < deltaY) {
                self.minimizeVideoView()
            }
            else {
                self.maximizeVideoView()
            }
        default:
            self.maximizeVideoView()
            break
        }
    }
    
    func minimizeVideoView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.consTop.constant = self.maxTopMargin
            self.consLeft.constant = 10
            self.consRight.constant = 10
            self.consBottom.constant = 10
            self.tableView.alpha = 0
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.consVideoHeight.constant = StaticVariable.miniVideoHeight
            self.view.layoutIfNeeded()
        }) { (completion) in
            UIView.animate(withDuration: 0.2) {
                self.consVideoRightMargin.constant = 200
                self.view.layoutIfNeeded()
            }
        }
        self.videoState = .mini
    }
    
    func maximizeVideoView() {
        UIView.animate(withDuration: 0.15) {
            self.consTop.constant = 0
            self.consLeft.constant = 0
            self.consRight.constant = 0
            self.consBottom.constant = 0
            self.tableView.alpha = 1
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            self.consVideoHeight.constant = StaticVariable.videoHeight
            self.consVideoRightMargin.constant = 0
            self.view.layoutIfNeeded()
        }
        self.videoState = .max
    }
    
    // MARK: - TouchEvent
    @IBAction func onCloseTouched(_ sender: UIButton) {
        self.dismiss(animated: false) {
            
        }
    }
    
    @objc
    func onTapGestureRecognizer(_ gesture: UITapGestureRecognizer) {
        maximizeVideoView()
    }
        
}

extension PlayViewController: UITableViewDataSource, UITableViewDelegate {
    
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
