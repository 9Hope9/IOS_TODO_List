//
//  ViewController.swift
//  lab6
//


import UIKit

class ToDoListViewController: UIViewController {
    @IBOutlet weak var toDoListView: UITableView!
    var itemsData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        toDoListView.delegate = self
        toDoListView.dataSource = self
        getToDoItems()
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Details In Your Daily Activity", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Detail Please"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .destructive, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            if let newItem = textField.text, !newItem.isEmpty {
                        self.itemsData.append(newItem)
                        self.addToDoItems()
                        self.toDoListView.reloadData()
                    } else {
                        
                        let errorAlert = UIAlertController(title: "Error", message: "Please enter a valid detail.", preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
    }
    
    func getToDoItems() {
        let url = Bundle.main.url(forResource: "TodoItems", withExtension: "plist")!
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([String].self, from: data)
            self.itemsData = result
        } catch {
            print(error)
        }
    }

    func addToDoItems() {
        let url = Bundle.main.url(forResource: "TodoItems", withExtension: "plist")!
        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            let data = try encoder.encode(itemsData)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
}
extension ToDoListViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemsCell", for: indexPath) as! ToDoListTableViewCell
        cell.itemTitle.text = itemsData[indexPath.row];
        return cell;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return itemsData.count;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            itemsData.remove(at: indexPath.row)
            addToDoItems()
            toDoListView.reloadData()
        }
    }
}

