//
//  PickerButton.swift
//  Jeopardy!
//
//  Created by Tyrone Trevorrow on 10/08/2014.
//  Copyright (c) 2014 Sudeium. All rights reserved.
//

import UIKit

class PickerButton: UIButton, UIPickerViewDelegate, UIPickerViewDataSource, UIPopoverControllerDelegate {
    var options: [String] = [] {
        didSet {
            if selectedIndex > options.count {
                selectedIndex = 0
            } else {
                updateTitle()
            }
        }
    }
    var titles: [String]?
    var selectedIndex: Int = 0 {
        didSet {
            updateTitle()
            sendActionsForControlEvents(.ValueChanged)
        }
    }
    lazy var titleTransformer: String -> String = { return $0 }
    
    private var picker: UIPickerView!
    private var pickerPopover: UIPopoverController!
    private var pickerController: UIViewController!
    
    override init() {
        super.init()
        setup()
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.showsSelectionIndicator = true
        
        pickerController = UIViewController()
        pickerController.view.frame = picker.frame
        pickerController.view.addSubview(picker)
        pickerController.preferredContentSize = picker.frame.size
        
        pickerPopover = UIPopoverController(contentViewController: self.pickerController)
        pickerPopover.delegate = self
        
        addTarget(self, action: "touchAction:", forControlEvents: .TouchUpInside)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        // Show the popover
        if super.becomeFirstResponder() {
            selected = true
            pickerPopover.presentPopoverFromRect(self.bounds, inView: self, permittedArrowDirections: .Any, animated: true)
            sendActionsForControlEvents(.EditingDidBegin)
            return true
        }
        return false
    }
    
    override func resignFirstResponder() -> Bool {
        if super.resignFirstResponder() {
            updateTitle()
            // Hide the popover if visible
            pickerPopover.dismissPopoverAnimated(true)
            sendActionsForControlEvents(.EditingDidEnd)
            selected = false
            return true
        }
        return false
    }
    
    func updateTitle() {
        if titles == nil {
            setTitle(titleTransformer(options[selectedIndex]), forState: .Normal)
        } else {
            setTitle(titleTransformer(titles![selectedIndex]), forState: .Normal)
        }
    }
    
    func touchAction(sender: PickerButton!) {
        if self.isFirstResponder() {
            resignFirstResponder()
        } else {
            picker.reloadAllComponents()
            becomeFirstResponder()
        }
    }
    
    // MARK: - Picker View
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        let ts = titles ?? options
        return ts[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
    
    // MARK: - Popover
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController!) {
        resignFirstResponder()
    }
    
}
