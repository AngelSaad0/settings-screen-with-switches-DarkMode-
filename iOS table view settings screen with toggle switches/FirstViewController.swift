//
//  ViewController.swift
//  iOS table view settings screen with toggle switches
//
//  Created by Engy on 10/30/24.
//

import UIKit
struct SettingItem {
    var name: String
    var isOn: Bool
}

class FirstViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    //  items = (0..<1000).flatMap{ _ in item}

    var items: [SettingItem] = [
        SettingItem(name: "Notifications", isOn: false),
        SettingItem(name: "Location Access", isOn: false),
        SettingItem(name: "Auto-Update", isOn: false),
        SettingItem(name: "Dark Mode", isOn: false)
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeManager.shared.delegate = self
        setupTableView()
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }


}
extension FirstViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
   

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell(style: .default, reuseIdentifier: "cell")
        //swich setup
        let swichView = UISwitch(frame:CGRect(x: 20, y: 10, width: 10, height: 10))
        swichView.setOn(items[indexPath.row].isOn, animated: true)
        swichView.tag = indexPath.row
        swichView.addTarget(self, action: #selector(swichChanged(_ :)), for: .valueChanged)

        //content setup
        var contentView =  cell.defaultContentConfiguration()
        contentView.text = items[indexPath.row].name
        contentView.textProperties.font = UIFont(descriptor:UIFontDescriptor.preferredFontDescriptor(withTextStyle: .extraLargeTitle), size: 16)

        //cell setup
        cell.contentConfiguration = contentView
        cell.accessoryView = swichView


        return cell
    }

    @objc func swichChanged(_ sender:UISwitch) {
        //save all state
        UserDefaults.standard.setValue(sender.isOn, forKey: "\(sender.tag)")

        switch sender.tag {
        case 0:
            print("Notifications")
        case 1:
            print("Location Access")
        case 2:
            print("Auto-Update")
        default:
            print("Dark Mode")
            ThemeManager.shared.isDarkMode = sender.isOn
        }

    }


}
extension FirstViewController: ThemeDelegate {
    func didChangeTheme(isDarkMode: Bool) {
//        guard let window = UIApplication.shared.windows.first else{return}
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first{$0 is UIWindowScene} as? UIWindowScene
        windowScene?.windows.forEach{ window in
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }





    }
    

}

