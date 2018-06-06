

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTextView: UITextView!

    var person = PersonsData()
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.text = ""
        setup()
        // Do any additional setup after loading the view.
    }
    //does everything just like in the viewcontroller class
    func setup() {
        imageurl()
        myTextView.text = "Person's name: \(person.fullName) /n" + "Current Location: \(person.currentLocation) /n" + "Cell Number: \(person.cellNumber) /n" + "Date of Birth: \(person.DOB) /n" + "Email: \(person.peopleEmail) /n" + "Username: \(person.profileInfo) /n" + "Password: \(person.password) /n"
    }
    func imageurl() {
        if var url = NSURL(string: person.profPic) {
            if var data = NSData(contentsOf: url as URL) {
                myImage.image = UIImage(data: data as Data)
            }
        }
    }
}
