//
//  ViewController.swift
//  Assignment
//
//  Created by Student on 28/11/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    @IBOutlet weak var MyDraw: Draw!
    
    @IBOutlet weak var MyImage: UIImageView!
    
    var startX : CGFloat = 0.0
    var startY : CGFloat = 0.0
    
    var BrushSize: CGFloat = 1.0
    
    var Red : CGFloat = 0.0
    var Green : CGFloat = 0.0
    var Blue : CGFloat = 0.0
    var Alpha : CGFloat = 1.0
    
    var erase : Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func RedSlider(_ sender: UISlider)
    {
        Red = CGFloat(sender.value)
        //MyDraw.setNeedsDisplay()
    }
    @IBAction func GreenSlider(_ sender: UISlider)
    {
        Green = CGFloat(sender.value)
        //MyDraw.setNeedsDisplay()
    }
    @IBAction func BlueSlider(_ sender: UISlider)
    {
        Blue = CGFloat(sender.value)
        //MyDraw.setNeedsDisplay()
    }
    @IBAction func SizeSlider(_ sender: UISlider)
    {
        BrushSize = CGFloat(sender.value)
    }
    
    
    @IBAction func Eraser(_ sender: UIButton)
    {
        eraser()
        
        switch erase {
        case true:
            sender.backgroundColor = UIColor.blue
            break
        case false:
            sender.backgroundColor = UIColor.white
            break
        default:
            break
        }
    }
    @IBAction func Clear(_ sender: UIButton)
    {
        clear()
    }
    
    @IBAction func SaveToGallery(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(MyImage.image!, nil, nil, nil)
    }
    
    @IBAction func LoadFromGallery(_ sender: AnyObject) {
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        MyImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first
        let p = touch?.location(in: MyImage)
        startX = (p?.x)!
        startY = (p?.y)!
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with:event)
        UIGraphicsBeginImageContext(MyImage.frame.size)
        let context = UIGraphicsGetCurrentContext()
        MyImage.draw(CGRect(x:0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        var endX : CGFloat = 0.0
        var endY : CGFloat = 0.0
        
        let touch = touches.first
        let p = touch?.location(in: MyImage)
        endX = (p?.x)!
        endY = (p?.y)!
        
        if erase == false {
            context!.setLineWidth(BrushSize)
            context!.setStrokeColor(red: Red/256.0, green: Green/256.0, blue: Blue/256.0, alpha: Alpha)
            context?.move(to: CGPoint(x:CGFloat(startX),y:CGFloat(startY)))
            context?.addLine(to: CGPoint(x:CGFloat(endX), y:CGFloat(endY)))
            context?.strokePath()
        }
        else {
            context!.setLineWidth(50.0)
            context!.setStrokeColor(red: 255.0, green: 255.0, blue: 255.0, alpha: Alpha)
            context?.move(to: CGPoint(x:CGFloat(startX),y:CGFloat(startY)))
            context?.addLine(to: CGPoint(x:CGFloat(endX), y:CGFloat(endY)))
            context?.strokePath()
        }
        
        MyImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        startX = endX
        startY = endY
    }
    
    func eraser()
    {
        switch erase {
        case true:
            erase = false
            break
        case false:
            erase = true
            break
        default:
            break
        }
    }
    
    func clear()
    {
        //var sX : Int = 0
        //var sY : Int = 0
        UIGraphicsBeginImageContext(MyImage.frame.size)
        let context = UIGraphicsGetCurrentContext()
        for i in 1...Int(MyImage.bounds.height)
        {
            context!.setLineWidth(2.0)
            context!.setStrokeColor(UIColor.white.cgColor)
            context?.move(to: CGPoint(x:0,y:i))
            context?.addLine(to: CGPoint(x:(Int(MyImage.bounds.width)), y:i))
            //print()
            context?.strokePath()
            
        }
        MyImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
}

