//
//  ContactListController.swift
//  contacts
//
//  Created by Robin Taylor on 02/03/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

extension Contact {
    var firstLetterForSort: String {
        return String(firstName.characters.first!).uppercased()
    }
}

extension ContactsSource {
   static var sortedUniqueFirstLetters: [String]
   {
    let firstLetters = contacts.map{$0.firstLetterForSort}
    let uniqueFirstLetters = Set(firstLetters)
    return Array(uniqueFirstLetters).sorted()
    }
    
    static var sectionContacts: [[Contact]]
    {
        return  sortedUniqueFirstLetters.map {firstLetter in
            let fillteredContacts = contacts.filter{ $0.firstLetterForSort == firstLetter}
            return fillteredContacts.sorted(by: {$0.firstName < $1.firstName})
        }
        
    }
}

class ContactListController: UITableViewController {
    var sections = ContactsSource.sectionContacts
    let sectionTitles = ContactsSource.sortedUniqueFirstLetters
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // creates instance of tableviewcell and uses prototype with identifier passed
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = sections[indexPath.section][indexPath.row]
        cell.textLabel?.text = contact.firstName
        cell.detailTextLabel?.text = contact.lastName
        cell.imageView?.image = contact.image
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    //MARK: - table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if (segue.identifier == "showContact") {
            // gets row clicked on
            if let indexPath = tableView.indexPathForSelectedRow
            {
                // access contact using index of row clicked on
                let contact = sections[indexPath.section][indexPath.row]
                guard let navigationController = segue.destination as? UINavigationController, let contactDetailController = navigationController.topViewController as? ContactDetailController
                    else {return}
                // set value of stored property on contactdetail controller to that of the selected contact
                contactDetailController.contact = contact
            }
            
        }
    }
   
}
