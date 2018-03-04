//
//  ContactDetailController.swift
//  contacts
//
//  Created by Robin Taylor on 02/03/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class ContactDetailController: UITableViewController {
    var contact: Contact?
    //outlets
    @IBOutlet weak var phoneNumberLabel: UILabel?
    @IBOutlet weak var emailLabel: UILabel?
    @IBOutlet weak var streetLabel: UILabel?
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var zipCodeLabel: UILabel?
    @IBOutlet weak var stateLabel: UILabel?
    @IBOutlet weak var nameLabel:UILabel?
    @IBOutlet weak var profileImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contact = contact
        {
            print(contact)
        }
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
   
    
    //MARK: - custom methods
    func configureView()
    {
        guard let contact = contact else {return}
        nameLabel?.text = "\(contact.firstName)  \(contact.lastName)"
        phoneNumberLabel?.text = contact.phone
        emailLabel?.text = contact.email
        streetLabel?.text = contact.street
        cityLabel?.text = contact.city
        zipCodeLabel?.text = contact.zip
        stateLabel?.text = contact.state
        
        if let image = contact.image
        {
            profileImage?.image = image
        }
        
    }
    
}
