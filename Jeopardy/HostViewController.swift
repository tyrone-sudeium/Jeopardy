//
//  HostViewController.swift
//  Jeopardy!
//
//  Created by Tyrone Trevorrow on 8/08/14.
//  Copyright (c) 2014 Sudeium. All rights reserved.
//

// The Host view is visible on the iPad's main screen. It is for the host
// of the game to control the game and determine when various events happen.

import UIKit

class HostViewController: UIViewController, UITextFieldDelegate {
    var game: Game?

    @IBOutlet var redScoreField: UITextField!
    @IBOutlet var blueScoreField: UITextField!
    @IBOutlet var greenScoreField: UITextField!
    
    @IBOutlet var redBuzzerButton: UIButton!
    @IBOutlet var blueBuzzerButton: UIButton!
    @IBOutlet var greenBuzzerButton: UIButton!
    
    @IBOutlet var startGameButton: UIButton!
    @IBOutlet var correctAnswerButton: UIButton!
    @IBOutlet var incorrectAnswerButton: UIButton!
    @IBOutlet var modeButton: UIButton!
    @IBOutlet var boardButton: PickerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundles = BundleLoader.availableBundles()
        let options: [String] = bundles.map { $0.bundlePath.lastPathComponent.stringByDeletingPathExtension }
        boardButton.titleTransformer = { return "Board: \($0)" }
        boardButton.options = options
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func updateGameState() {
        
    }

    
    @IBAction func startGameButtonAction(sender: UIButton) {
        
    }
    
    @IBAction func correctAnswerButtonAction(sender: UIButton) {
        
    }
    
    @IBAction func incorrectAnswerButtonAction(sender: UIButton) {
        
    }
    
    @IBAction func modeButtonAction(sender: AnyObject) {
        
    }
    
    @IBAction func boardButtonAction(sender: AnyObject) {
        
    }
    
    // MARK: - Text Field Delegate
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        let nonNumeric = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        if let range = string.rangeOfCharacterFromSet(nonNumeric, options: nil, range: string.startIndex..<string.endIndex) {
            return false // Do not allow non-numeric characters
        } else {
            return true
        }
    }

}
