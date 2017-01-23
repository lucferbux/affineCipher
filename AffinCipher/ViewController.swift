//
//  ViewController.swift
//  AffinCipher
//
//  Created by lucas fernández on 23/01/2017.
//  Copyright © 2017 lucas fernández. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cipherText: UITextField!
    
    @IBOutlet weak var aNumber: UITextField!
    
    @IBOutlet weak var bNumber: UITextField!
    
    @IBOutlet weak var textBoxResult: UITextView!
    
    
    //Calcula la inversa del modulo
    func modular_inverse(a:Int, b:Int) -> Int{
        let aAux = a % b
        var result = 0
        for i in (0..<b){
            if ((aAux * i) % b == 1){
                result = i
                break
            }
        }
        return result
    }
    
    //mapeo de las letras para que tengan una posicion en el array y poder hacer los cálculos
    let letrasArray:[String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func decodeText(_ sender: Any) {
        let a = Int(aNumber.text ?? "2")
        let b = Int(bNumber.text ?? "2")
        let text = cipherText.text ?? ""
        
        var textAux:String = text.lowercased()
        var deCipherText:String = ""
        let inv = modular_inverse(a: a!, b: 26)
        for (index, char) in textAux.characters.enumerated() {
            if (char == " "){
                deCipherText = deCipherText + " "
            }else{
                deCipherText = deCipherText + letrasArray[offsetDecypher(a: a!, b: b!, c: letrasArray.index(of: String(char))!, d: inv)]
            }
        }
        
        textBoxResult.text = deCipherText
        
    }
    

    @IBAction func encodeText(_ sender: Any) {
        let a = Int(aNumber.text ?? "2")
        let b = Int(bNumber.text ?? "2")
        let text = cipherText.text ?? ""
        
        var textAux:String = text.lowercased()
        var cipherTextAux:String = ""
        
        for (index, char) in textAux.characters.enumerated() {
            if (char == " "){
                cipherTextAux = cipherTextAux + " "
            }else{
                cipherTextAux = cipherTextAux + letrasArray[offset(a: a!, b: b!, c: letrasArray.index(of: String(char))!)]
            }
        }
        
        textBoxResult.text = cipherTextAux
        
    }
    

    
    
    
    func offset(a:Int, b:Int, c:Int) -> Int {
        return (a*c + b) % 26
    }
    
    func offsetDecypher(a:Int, b:Int, c:Int, d:Int) -> Int {
        let op = d * (c - b)
        return op % 26 < 0 ? (op % 26) + 26 : op % 26
    }
    
    
    
}

