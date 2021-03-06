import UIKit

class UserViewController: UIViewController
{
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ImageID: UIImageView!
    var NameLabelText = String()
    var IDLabelText = String()
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var background2: UIView!
    
    override func viewDidLoad()
        
    {
        super.viewDidLoad()
        NameLabel.text = NameLabelText
        print("the ID that userviewcontroller is getting is " + IDLabelText)
        ImageID.image = getProfPic(IDLabelText: IDLabelText)
        ImageID.layer.cornerRadius = 8
        background2.layer.cornerRadius = 8
        
    }
    
    override func didReceiveMemoryWarning()
        
    {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated
    }
    
    func getProfPic(IDLabelText: String) -> UIImage?
    {
        if (IDLabelText != "")
        {
            let imgURLString = "http://graph.facebook.com/" + IDLabelText + "/picture?type=large" //type=normal
            let imgURL = NSURL(string: imgURLString)
            let imageData = NSData(contentsOf: imgURL! as URL)
            let image = UIImage(data: imageData! as Data)
            return image
        }
        return nil
    }
}
