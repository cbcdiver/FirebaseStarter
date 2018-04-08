//
//  MessagesTableViewController.swift
//  FirebaseStarter
//
//  Created by Chris Chadillon on 2018-03-05.
//  Copyright © 2018 Chris Chadillon. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {

    var theMessages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func enableDisableTextField(_ theTextField:UITextField) {
        let length = theTextField.text!.count
        let theController = self.presentedViewController as? UIAlertController
        theController?.actions.first?.isEnabled = length > 0
    }
    
    @IBAction func doAddMessage(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Message", message: "Message", preferredStyle: .alert)
        alert.addTextField(configurationHandler: ({ (textField:UITextField) in
            textField.placeholder = "The Message"
        }))
        
        alert.textFields?.first?.addTarget(self, action: (#selector(enableDisableTextField(_:))), for: .editingChanged)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            self.theMessages.append(Message(theMessage: alert.textFields!.first!.text!))
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.actions.first?.isEnabled = false
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theMessages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheCell", for: indexPath)

        cell.textLabel?.text = theMessages[indexPath.row].theMessage

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            theMessages.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
