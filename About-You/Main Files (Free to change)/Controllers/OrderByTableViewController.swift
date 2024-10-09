import UIKit

protocol OrderByTableViewControllerDelegate: AnyObject  {
    func hasSelectedOrder(order: String)
}

 class OrderByTableViewController: UITableViewController {

     var delegate : OrderByTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        if indexPath.row == 0 {
            cell?.textLabel?.text = "Years"
        } else if indexPath.row == 1 {
            cell?.textLabel?.text = "Coffees"
        } else {
            cell?.textLabel?.text = "Bugs"
        }
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            self.delegate?.hasSelectedOrder(order: "years")
        } else if indexPath.row == 1 {
            self.delegate?.hasSelectedOrder(order: "Coffees")
        } else {
            self.delegate?.hasSelectedOrder(order: "Bugs")
        }
    }

}
