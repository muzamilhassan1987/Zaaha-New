//
//  NumberPickerViewController.swift
//  PickerView
//
//  Created by Filipe Alvarenga on 09/08/15.
//  Copyright (c) 2015 Filipe Alvarenga. All rights reserved.
//

import UIKit

enum PickerType : Int {
    case cultureList
    case typeList
    
}

protocol PickerViewControllerSelectedDataDelegate : class  {
    func getSelectedArrayIndex(selectedIndex:Int , andSelectedValue:String, andPickerType : PickerType)
}

class PickerViewController: UIViewController {
    weak var pickerViewControllerSelectedDataDelegate: PickerViewControllerSelectedDataDelegate?
    // MARK: - Nested Types

    enum PresentationType {
        case numbers(Int, Int), names(Int, Int) // NOTE: (Int, Int) represent the rawValue's of PickerView style enums.
    }

    // MARK: - Properties

    @IBOutlet weak var examplePicker: PickerView!
    
    let numbers: [String] = {
        var numbers = [String]()
        
        for index in 1...10 {
            numbers.append(String(index))
        }

        return numbers
    }()

    var arrayOfData :[String] = []
    
    var presentationType = PresentationType.numbers(0, 0)
    var pickerType : PickerType = PickerType.cultureList
    
    var currentSelectedValue: String?
    var updateSelectedValue: ((_ newSelectedValue: String) -> Void)?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureExamplePicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Configure Subviews
    
    fileprivate func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    fileprivate func configureExamplePicker() {
        examplePicker.dataSource = self
        examplePicker.delegate = self
        
        let scrollingStyle: PickerView.ScrollingStyle
        let selectionStyle: PickerView.SelectionStyle
        
            scrollingStyle = PickerView.ScrollingStyle(rawValue: 0)!
            selectionStyle = PickerView.SelectionStyle(rawValue: 0)!
            
            examplePicker.scrollingStyle = scrollingStyle
            examplePicker.selectionStyle = selectionStyle
            
            if let currentSelected = currentSelectedValue, let indexOfCurrentSelectedValue = arrayOfData.index(of: currentSelected) {
                examplePicker.currentSelectedRow = indexOfCurrentSelectedValue
            }
        
        if selectionStyle == .image {
            examplePicker.selectionImageView.image = UIImage(named: "SelectionImage")!
        }
    }
    
    // MARK: Actions
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func setNewPickerValue(_ sender: UIBarButtonItem) {
        if let updateValue = updateSelectedValue, let currentSelected = currentSelectedValue {
            updateValue(currentSelected)
        }
        
         self.navigationController?.popViewController(animated: true)
    }
}

extension PickerViewController: PickerViewDataSource {
    
    // MARK: - PickerViewDataSource
    
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
            return arrayOfData.count
    }
    
    func pickerView(_ pickerView: PickerView, titleForRow row: Int) -> String {
            return arrayOfData[row]
        }
    
}

extension PickerViewController: PickerViewDelegate {
    
    // MARK: - PickerViewDelegate
    
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 50.0
    }

    func pickerView(_ pickerView: PickerView, didSelectRow row: Int) {
            currentSelectedValue = arrayOfData[row]
        print(currentSelectedValue ?? "")
        self.pickerViewControllerSelectedDataDelegate?.getSelectedArrayIndex(selectedIndex: row, andSelectedValue: currentSelectedValue!, andPickerType: pickerType)
    }
    
    func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
        label.textAlignment = .center
        if #available(iOS 8.2, *) {
            if (highlighted) {
                label.font = UIFont.systemFont(ofSize: 26.0, weight: UIFont.Weight.light)
            } else {
                label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.light)
            }
        } else {
            if (highlighted) {
                label.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
            } else {
                label.font = UIFont(name: "HelveticaNeue-Light", size: 26.0)
            }
        }
        
        if (highlighted) {
            label.textColor = view.tintColor
        } else {
            label.textColor = UIColor(red: 161.0/255.0, green: 161.0/255.0, blue: 161.0/255.0, alpha: 1.0)
        }
    }
    
}
