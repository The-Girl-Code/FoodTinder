//
//  InfoViewController.swift
//  FoodTinder
//
//  Created by Aditi Gnanasekar on 7/5/17.
//  Copyright © 2017 The Girl Code. All rights reserved.
//

import UIKit
import UserNotifications
class InfoViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var veggieName = "ug"
    var veggieImage: UIImage!
    var veggieTime: Int = 0
    
    
    @IBOutlet weak var veggieImageView: UIImageView!
    
    @IBOutlet weak var veggieLabel: UILabel!
    
    var seconds: Int = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
   
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(InfoViewController.updateTimer)), userInfo: nil, repeats: true)
        pauseButton.isEnabled = true
        isTimerRunning = true
    }
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    
    
    @IBAction func startButton(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume",for: .normal)

        } else {
            runTimer()
            isTimerRunning = true
            self.resumeTapped = false
            self.pauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.invalidate()
        seconds = veggieTime * 60
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.setTitle("Pause", for: .normal)
        self.resumeTapped = false
        startButton.isEnabled = true
        pauseButton.isEnabled = false
    }
    

    
    func updateTimer() {
        if seconds < 1 {
            let content = UNMutableNotificationContent()
            content.title = "Time's Up!"
            content.subtitle = "Check your veggies!"
            content.body = "Poke a fork in to test if they are soft."
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            timer.invalidate()
            //Send alert to indicate "time's up!"
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    @IBAction func subtractOneMinute(_ sender: UIButton) {
        if seconds > 59{
            seconds -= 60
        }else{
            seconds = 0
        }
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    @IBAction func addOneMinute(_ sender: UIButton) {
        seconds += 60
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        veggieImageView.image = veggieImage
        veggieLabel.text = veggieName
        print(veggieName)
        seconds = veggieTime * 60
        pauseButton.isEnabled = false
        timerLabel.text = timeString(time: TimeInterval(seconds))

    }
    
}
