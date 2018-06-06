//1. Briefly explain the purpose of your app
// Draws information and data from API and gets random people and information from it.
//2. Describe the process for acquiring the API for your app.
//   It gets information by converting the rul into data then converting that data into a readable JSON file. Next The Api is a dictionary filled with dictionaries so I have to draw values from each of the seperate dictionaries by calling the dictionary then putting the value.
//    3. What data are your using from the API?
// I'm pulling all the revelant information from the people such as email, phone number, name, and address.
//4. How many hours did you honestly put into this project (we had roughly 12 in class hours)?
// about 2 to 3 hours.
//5. Comment your app, explaining your steps through the process.



import UIKit

class ViewController: UIViewController
{
    //My Outlets
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myLabelTwo: UILabel!
    @IBOutlet weak var myLabelThree: UILabel!
    //a variable that calls from the object class Persons Data
    var person = PersonsData()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //
        //draws data from the API
        jsonParseCheck()
        //sets up the information in the API
        setUp()
    }
    @IBAction func newPersonTapped(_ sender: Any)
    {
        //draws data from the API
        jsonParseCheck()
        //sets up the information in the view
        setUp()
    }

    //sets the variables equal to the outlet
    func setUp() {
        //takes the url and converts it into data
        imageurl()
        myLabel.text = person.fullName
        myLabelTwo.text = person.currentLocation
        myLabelThree.text = person.profileInfo
    }
    //takes the url converts it into data
    func imageurl() {
        if var url = NSURL(string: person.profPic) {
            if var data = NSData(contentsOf: url as URL) {
                myImage.image = UIImage(data: data as Data)
            }
        }
    }
    
    //Draws data from the given url and converts it into json Data
    func jsonParseCheck()
    {
        let urlString = "https://randomuser.me/api/"
        
        if let url = NSURL(string: urlString)
        {
            if let myData = try? NSData(contentsOf: url as URL, options: [])
            {
                let json = JSON(data: myData as Data)
                
                print("okay to parse")
                parse(json)
                
            }
        }
    }
    
    //takes the different dictionaries and values from the API and sets it equal to variables in the NSOBJECT Class
    func parse(_ json: JSON) {
        for result in json["results"].arrayValue
        {
            //calls the dictionary from the array
            let name = result["name"].dictionaryValue
            //grabs the values from the dictionary and makes them into strings
            var first = name["first"]?.stringValue
            var last = name["last"]?.stringValue
            
            person.fullName = first! + " " + last!
            print(result["name"].dictionaryValue)
            print(json["name"].arrayValue)
            
            let location = result["location"].dictionaryValue
            var street = location["street"]?.stringValue
            var city = location["city"]?.stringValue
            var state = location["state"]?.stringValue
            var postCode = location["postcode"]?.stringValue
            person.currentLocation = street! + "," + city! + "," + state! + postCode!
            
            
            var email = result["email"].stringValue
            person.peopleEmail = email
            let login = result["login"].dictionaryValue
            var username = login["username"]?.stringValue
            var password = login["password"]?.stringValue
            person.profileInfo = username!
            person.password = password!
            
            var birthday = result["dob"].stringValue
            person.DOB = birthday
            var cell = result["cell"].stringValue
            person.cellNumber = cell
            let picture = result["picture"].dictionaryValue
            var medPic = picture["medium"]?.stringValue
            print(medPic)
            person.profPic = medPic!
            
        }
    }
    //segues the information from the class to the other view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoVC = segue.destination as! InfoViewController
        infoVC.person = person
    }

}
