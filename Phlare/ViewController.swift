//
//  ViewController.swift
//  Phlare
//
//  Created by Brian Li on 2/13/17.
//  Copyright © 2017 Brian Li. All rights reserved.
//
import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate
{
    var myString = "dog"

    // MARK: Properties
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var flameImage: UIImageView!
    
    override func viewDidLoad()
    {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start
            {
                (connection, result, err) in
                if err != nil
                {
                    print("fail:", err)
                    return
                }
                
                guard let data = result as? [String:Any] else { return }
                let fbid = data["id"]
                let username = data["name"]
                print("Your Facebook ID is: \(fbid!)")
                print("Your UserName is: \(username!)")
                
                self.myString = fbid! as! String
                print("This is the value of mystring: \(self.myString) ")
                print(result!)
        }
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //facebook login button
        
        let loginButton = FBSDKLoginButton()
        loginButton.alpha = 0.95
        loginButton.frame = CGRect(x: 85, y: 410, width: 200, height: 40)
        
        view.addSubview(loginButton)
        loginButton.delegate = self
        
        // background image
        backgroundImage.image = #imageLiteral(resourceName: "background")
            
        // flame image
        flameImage.image = #imageLiteral(resourceName: "burn2")
        flameImage.alpha = 0.8
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    {
        if error != nil
        {
            print("Something went wrong...\(error)")
            return
        }
        
        print("Successfully logged in Facebook")
        
        
        self.performSegue(withIdentifier: "showMap", sender: self)
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        print("Successfully logged out of Facebook")
    }

    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "showMap")
        {
            let DestViewController : MapViewController = segue.destination as! MapViewController
            DestViewController.LabelText = self.myString
            print("This is the value of mystring in prepareforsegue: \(self.myString) ")
        }
    }
}


