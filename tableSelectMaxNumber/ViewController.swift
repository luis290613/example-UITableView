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
    
    var listsAddonsSelec : [Int] = []
    var addOns : [AddOns] = []
    let maxAddonsSelec : Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    
    func setupView() {
        /// cargando lista
        addOns = [
            AddOns(id: 1, name: "1 inka kola", check: false),
            AddOns(id: 2, name: "2 coca kola", check: false),
            AddOns(id: 3, name: "3 pepsi kola", check: false),
            AddOns(id: 4, name: "4 chuchi kola", check: true),
            AddOns(id: 5, name: "5 chichu kola", check: false),
            AddOns(id: 6, name: "6 pepsi kola", check: false),
            AddOns(id: 7, name: "7 chuchi kola", check: false),
            AddOns(id: 8, name: "8 chichu kola", check: false),
            AddOns(id: 9, name: "9 pepsi kola", check: false)
        ]
        
        /// registrando celda
        let nib = UINib(nibName: "addonsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "addonsTableViewCell")
        
        /// cargando data seleccionada
        addOns.forEach { item in
            if item.check {
                listsAddonsSelec.append(item.id)
            }
        }
        
        /// title
        lblNumberMaxSelec.text = "Selecciona \(maxAddonsSelec) productos como máximo"
    }
    
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addOns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addonsTableViewCell") as? addonsTableViewCell else {
            return UITableViewCell()
        }
        
        let item = addOns[indexPath.row]
        
        item.check ? cell.config(name: item.name, state: .check) : cell.config(name: item.name, state: .uncheck)

        /// se aplica un estilo difetente para las celdas no seleccionadas si se supera el número máximo de productos seleccionados
        if listsAddonsSelec.count >= maxAddonsSelec {
            if !item.check {
                cell.configState(state: .bloqueado)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.addOns[indexPath.row]
        if item.check {
            /// removemos del objeto
            if let index = listsAddonsSelec.firstIndex(of: item.id) {
                listsAddonsSelec.remove(at: index)
                self.addOns[indexPath.row].check = false
                tableView.reloadData()
            }
        } else {
            if listsAddonsSelec.count >= maxAddonsSelec {
                print("ya tienes \(maxAddonsSelec) pendej#!!!")
            } else {
                /// agregamos al nuevo array
                listsAddonsSelec.append(item.id)
                self.addOns[indexPath.row].check = true
                tableView.reloadData()
            }
        }
        
        print("check: \(listsAddonsSelec)")
    }
    
}
