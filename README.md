# UILabelStyles
A sample app applying multiple styles to UIlabel using Attributed String.

![img_9242](https://user-images.githubusercontent.com/6782228/40703744-ca413c3e-6403-11e8-9558-41378c0aaabb.PNG)

![img_d10bd9d553fd-1](https://user-images.githubusercontent.com/6782228/40704906-1e1e11da-6407-11e8-85a1-e5940ec40d9c.jpeg)



For these styles to work, first all the labels need to be vertically adjusted. So I use a subclass `VerticalTopAlignLabel`
Most styles are applied using `NSMutableAttributedString` extensions
##Styles

#### Multicolor

```
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
```

*Usage:*

```

        let string = NSMutableAttributedString(string: trimmedString)
        
        string.setColorForText("red", with: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
 ```


#### Underline

```
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
 ```
 
 *Usage:*
 
 ```
 
         let string = NSMutableAttributedString(string: trimmedString)
        string.setUnderlineWith(nil, with: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        string.setUnderlineWith("Yeah!!", with: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        string.setUnderlineWith("With different underline color", with: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
```

#### Solid Highlight

```

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
 ```
 
 Usage:
 
 ```
 
         let string = NSMutableAttributedString(string: trimmedString)
        string.setHighlightColorForText(nil,with:UIColor(displayP3Red: 91.0/255.0, green: 221.0/255.0, blue: 83.0/255.0, alpha: 1.0))
        string.setHighlightColorForText("I am label with a different highlight",with:#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        bgColorlabel.attributedText = string
 ```
 
 #### Border and Higlight on every line
 
 For this style, you need to add a UIView and add a UILabel to it. Constrain the label and make sure it is Vertical top aligned.
 (Check the storyboard), I used a stack view for auto size adjustment. I then calculate the number of lines, with fontsize and line height and create
 CALayers and add it.
 
 ```
 
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
    
 ```
 
