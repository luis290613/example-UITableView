//
//  ViewController.swift
//  tableSelectMaxNumber
//
//  Created by Diego on 28/07/22.
//

import UIKit

struct AddOns {
    var id: Int
    var name: String
    var check: Bool
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNumberMaxSelec: UILabel!
    
    var listsAddonsOne : [Int] = []
    var listsAddonsTwo : [Int] = []
    var titleSecction : [String] = []
    var addOnsOne : [AddOns] = []
    var addOnsTwo : [AddOns] = []
    let maxAddonsSelec : Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    
    func setupView() {
        /// cargando lista
        addOnsOne = [
            AddOns(id: 1, name: "1 inka kola", check: true),
            AddOns(id: 2, name: "2 coca kola", check: false),
            AddOns(id: 3, name: "3 pepsi kola", check: true),
            AddOns(id: 4, name: "4 chuchi kola", check: false),
            AddOns(id: 5, name: "5 chichu kola", check: false)
        ]
        
        addOnsTwo = [
            AddOns(id: 11, name: "11 inka kola", check: false),
            AddOns(id: 22, name: "22 coca kola", check: true),
            AddOns(id: 33, name: "33 pepsi kola", check: false)
        ]
        
        titleSecction = ["Seccion uno", "Seccion dos"]
        
        /// registrando celda
        let nib = UINib(nibName: "addonsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "addonsTableViewCell")
        
        /// cargando data seleccionada
        addOnsOne.forEach { item in
            if item.check {
                listsAddonsOne.append(item.id)
            }
        }
        
        addOnsTwo.forEach { item in
            if item.check {
                listsAddonsTwo.append(item.id)
            }
        }
        
        /// title
        lblNumberMaxSelec.text = "Selecciona \(maxAddonsSelec) productos como máximo"
    }
    
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleSecction.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return titleSecction[section]
        } else {
            return titleSecction[section]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return addOnsOne.count
        } else {
            return addOnsTwo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addonsTableViewCell") as? addonsTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            let item = addOnsOne[indexPath.row]
            item.check ? cell.config(name: item.name, state: .check) : cell.config(name: item.name, state: .uncheck)

            /// se aplica un estilo difetente para las celdas no seleccionadas si se supera el número máximo de productos seleccionados
            if listsAddonsOne.count >= maxAddonsSelec {
                if !item.check {
                    cell.configState(state: .bloqueado)
                }
            }
        } else {
            let item = addOnsTwo[indexPath.row]
            item.check ? cell.config(name: item.name, state: .check) : cell.config(name: item.name, state: .uncheck)

            /// se aplica un estilo difetente para las celdas no seleccionadas si se supera el número máximo de productos seleccionados
            if listsAddonsTwo.count >= maxAddonsSelec {
                if !item.check {
                    cell.configState(state: .bloqueado)
                }
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let item = self.addOnsOne[indexPath.row]
            
            if item.check {
                /// removemos del objeto
                if let index = listsAddonsOne.firstIndex(of: item.id) {
                    listsAddonsOne.remove(at: index)
                    self.addOnsOne[indexPath.row].check = false
                    tableView.reloadData()
                }
            } else {
                if listsAddonsOne.count >= maxAddonsSelec {
                    print("ya tienes \(maxAddonsSelec) pendej#!!!")
                } else {
                    /// agregamos al nuevo array
                    listsAddonsOne.append(item.id)
                    self.addOnsOne[indexPath.row].check = true
                    tableView.reloadData()
                }
            }
            
        } else {
            let item = self.addOnsTwo[indexPath.row]
            
            if item.check {
                /// removemos del objeto
                if let index = listsAddonsTwo.firstIndex(of: item.id) {
                    listsAddonsTwo.remove(at: index)
                    self.addOnsTwo[indexPath.row].check = false
                    tableView.reloadData()
                }
            } else {
                if listsAddonsTwo.count >= maxAddonsSelec {
                    print("ya tienes \(maxAddonsSelec) pendej#!!!")
                } else {
                    /// agregamos al nuevo array
                    listsAddonsTwo.append(item.id)
                    self.addOnsTwo[indexPath.row].check = true
                    tableView.reloadData()
                }
            }
        }
        print("-------------------------------------")
        print("check ONE: \(listsAddonsOne)")
        print("check TWO: \(listsAddonsTwo)")
    }
    
}
