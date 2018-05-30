//
//  ViewController.swift
//  UILabelMultiColor
//
//  Created by anoop mohanan on 28/04/17.
//  Copyright © 2017 anoop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let FONT_SIZE = 17
    @IBOutlet weak var bgColorlabel:UILabel! // Label with solid background color
    @IBOutlet weak var underline:UILabel!
    @IBOutlet weak var borderLabel:UILabel!
    @IBOutlet weak var multicolorLabel:UILabel!
    @IBOutlet weak var bgView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackgroundColoredLabel() // Sets solid highlight
        setUnderlineLabel()
        setBorderLabel()
        setMultiColoredLabel()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    func setMultiColoredLabel() {
        let str = "Here is a text with red blue green text"
        let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let string = NSMutableAttributedString(string: trimmedString)
        
        string.setColorForText("red", with: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        string.setColorForText("blue", with: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        string.setColorForText("green", with: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        multicolorLabel.attributedText = string
    }
    /**
     Method will apply a solid color to the label
     - parameter nil
     - Returns:nil
     */
    func setBackgroundColoredLabel() {
        let str = "This is a label with solid background color, Shanananana, shanananana, I am label with a different highlight"
        let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let string = NSMutableAttributedString(string: trimmedString)
        string.setHighlightColorForText(nil,with:UIColor(displayP3Red: 91.0/255.0, green: 221.0/255.0, blue: 83.0/255.0, alpha: 1.0))
        string.setHighlightColorForText("I am label with a different highlight",with:#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        bgColorlabel.attributedText = string
    }
    /**
     Method will apply a underline color to the full label or part of label
     - parameter nil
     - Returns:nil
     */
    func setUnderlineLabel() {
        let str = "Someday, we gonna break free from these chains And keep on flyin. Yeah!!, With different underline color"
        let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let string = NSMutableAttributedString(string: trimmedString)
        string.setUnderlineWith(nil, with: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        string.setUnderlineWith("Yeah!!", with: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        string.setUnderlineWith("With different underline color", with: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        underline.attributedText = string
    }
    
    func setBorderLabel() {
        let str = "This is label style with solid highlight and have gap between the texts, uses a combination of UIView and UILabel, you can have borders also per line... check comments in the code"
        let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let string = NSMutableAttributedString(string: trimmedString)
        borderLabel.attributedText = string

        let labelWidth: CGFloat = borderLabel.frame.size.width
        var lineCount: Float = 0.0
        let textSize = CGSize(width: labelWidth, height: CGFloat(MAXFLOAT))
        let rHeight: Float = Float(borderLabel.sizeThatFits(textSize).height)
        //var rWidth: Int = lroundf(Float(borderLabel.sizeThatFits(textSize).width))
        let charSize: Float = Float(borderLabel.font.lineHeight)
        lineCount =  (rHeight / charSize).rounded()
        var count = 0
        // This needs a bit of trial and error, you need to play with the FONT_SIZE value to get the desired effect
        for i in stride(from: 0, to: Int(borderLabel.frame.size.height) , by: FONT_SIZE) {
            if count >= Int(lineCount){
                break
            }
            let border = CALayer()
            border.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            border.frame = CGRect(x: 0, y: CGFloat(i), width: borderLabel.frame.size.width, height: CGFloat(FONT_SIZE - 1) )
            // Uncomment the below lines to have borders per line.
            //border.borderWidth = 1.0
            //border.cornerRadius = 6.0
            border.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            borderLabel.layer.addSublayer(border)
            bgView.layer.insertSublayer(border, at: 0)
            count = count + 1
            borderLabel.layer.masksToBounds = true
        }

    }
}

extension NSMutableAttributedString{
    // If no text is send, then the style will be applied to full text
    func setColorForText(_ textToFind: String?, with color: UIColor) {
        
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range!)
        }
    }
    // If no text is send, then the style will be applied to full text
    func setHighlightColorForText(_ textToFind:String?,with color:UIColor){
        
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        
        if range!.location != NSNotFound {
            addAttribute(NSAttributedStringKey.backgroundColor, value: color, range: range!)
        }
    }
    
    // If no text is send, then the style will be applied to full text
    func setUnderlineWith(_ textToFind:String?, with color: UIColor){
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedStringKey.underlineStyle, value:NSUnderlineStyle.styleThick.rawValue, range: range!)
            addAttribute(NSAttributedStringKey.underlineColor, value:color , range: range!)
        }
    }
}
