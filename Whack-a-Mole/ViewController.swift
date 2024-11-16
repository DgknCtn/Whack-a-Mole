//
//  ViewController.swift
//  Whack-a-Mole
//
//  Created by Doğukan Çetin on 27.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var moleArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    // Labels
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    // Mole Views
    @IBOutlet weak var Mole1: UIImageView!
    @IBOutlet weak var Mole2: UIImageView!
    @IBOutlet weak var Mole3: UIImageView!
    @IBOutlet weak var Mole4: UIImageView!
    @IBOutlet weak var Mole5: UIImageView!
    @IBOutlet weak var Mole6: UIImageView!
    @IBOutlet weak var Mole7: UIImageView!
    @IBOutlet weak var Mole8: UIImageView!
    @IBOutlet weak var Mole9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Highscore check
        highScore = UserDefaults.standard.integer(forKey: "HighScore")
        highScoreLabel.text = "HighScore: \(highScore)"
        
        scoreLabel.text = "Score: \(score)"
        
        // Mole images
        moleArray = [Mole1, Mole2, Mole3, Mole4, Mole5, Mole6, Mole7, Mole8, Mole9]
        
        // Click Active
        for mole in moleArray {
            mole.isUserInteractionEnabled = true
            mole.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(increaseScore)))
        }
        
        // Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideMole), userInfo: nil, repeats: true)
        
        hideMole()
    }
    
    // Hide Mole
    @objc func hideMole() {
        for mole in moleArray {
            mole.isHidden = true
        }
        
        let randomIndex = Int.random(in: 0..<moleArray.count)
        moleArray[randomIndex].isHidden = false
    }
    
    // Increase Score func
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    // Countdown func
    @objc func countdown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            // Update highscore
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "HighScore")
            }
            showAlert()
        }
    }
    
    // Show Alert func
    func showAlert() {
        let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: .alert)
        
        // Alert actions
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let replayButton = UIAlertAction(title: "Replay", style: .default) { _ in
            self.restartGame()
        }
        
        alert.addAction(okButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Restart Game
    func restartGame() {
        score = 0
        scoreLabel.text = "Score: \(score)"
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideMole), userInfo: nil, repeats: true)
    }
}
