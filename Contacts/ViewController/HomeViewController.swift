//
//  HomeViewController.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 22/09/21.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNew: UIButton!
    
    var cells: [NameCellModel] = []
    
    var deleteContactIndexPath: IndexPath? = nil
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setUpRxObservers()
//        LocalRepository.INSTANCE.saveData(contact: createObject())
        
        
    }
    
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NameCell.NIB, forCellReuseIdentifier: NameCell.ID)
    }
    
    func createObject() -> ContactModel {
        let item = ContactModel(id: UUID().uuidString, firstName: "divyesh", lastName: "Vekariya", mobileNumbers: [8980807789, 9999999999], countryCode: 91, emails: ["divyesh.v@canopas.com", "123456789@gmail.com"], defaultRingtone: "tere liye", updateAt: Date(), createdAt: Date())

        return item
    }
    
    func setUpRxObservers() {
        setUpContentChangdObservers()
        setUpShouldPresentObservers()
    }
    
    func setUpContentChangdObservers() {
        viewModel.cells.asObservable().subscribe(onNext: { [weak self] cells in
            self?.cells = cells
            self?.tableView.reloadData()
        }) .disposed(by: DisposeBag())
    }
    
    func setUpShouldPresentObservers() {
        viewModel.shouldPresentSubject.asObservable().subscribe( onNext: { [weak self] viewToPresent in
            switch viewToPresent {
            case .showDetail(let model):
                let detailVc = DetailViewController()
                detailVc.viewModel = DetailViewModel(contact: model)
                self?.show(DetailViewController(), sender: nil)
            }
        }).disposed(by: DisposeBag())
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.ID, for: indexPath) as! NameCell
        let cellModel = cells[indexPath.row]
        cell.cellModel = cellModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didActionSubject.onNext(.selectRow(indexPath))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            confirmDelete(at: indexPath)
        }
    }
    
    func confirmDelete(at index: IndexPath) {
        let alert = UIAlertController(title: "Delete Contact", message: "Are you sure you want to permanently delete?", preferredStyle: .alert)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.viewModel.didActionSubject.onNext(.deleteItemAt(index))
            print("view model is nil?",self.viewModel)
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.show(alert, sender: nil)
    }

}
