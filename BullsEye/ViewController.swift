//
//  ViewController.swift
//  BullsEye
//
//  Created by Buják László on 2019. 07. 28..
//  Copyright © 2019. Buják László. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var currentValue = 0
    private var targetValue = 0
    private var score = 0
    private var round = 0
    
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var targetLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = Int(slider.value.rounded())
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    @IBAction func showAlert() {
        var score = 100 - abs(targetValue-currentValue)
        let title = generateTitle(score)

        updateScore(&score)
        
        let message = "You scored: \(score)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = Int(slider.value.rounded());
        
        print(currentValue)
        
    }
    
    @IBAction func newGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    private func startNewRound() {
        //targetValue = Int.random(in: 1...100)
        targetValue = Int(arc4random_uniform(100) + 1)
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        updateLabels()
    }
    
    private func updateLabels() {
        targetLabel.text = String(targetValue);
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    private func generateTitle(_ score: Int) -> String {
        let title: String
        if(score < 90) {
            title = "Not even close..."
        } else if(score < 95) {
            title = "Pretty good!"
        } else if(score < 100) {
            title = "You almost had it!"
        } else {
             title = "Perfect!"
        }
        return title
    }
    
    private func updateScore(_ score: inout Int) {
        if(score == 100) {
            score += 100
        } else if(score == 99) {
            score += 50
        }
        self.score += score
    }
    
}

