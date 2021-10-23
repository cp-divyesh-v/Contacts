//
//  NameCell.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 22/09/21.
//

import UIKit
import RxSwift

class NameCell: UITableViewCell {
    static var ID: String { String(describing: Self.self) }
    static var NIB: UINib { .init(nibName: String(describing: Self.self), bundle: .main) }
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    @IBOutlet weak var characterView: UIView!
    @IBOutlet weak var charecterLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterView.makeMeCircular()
        characterView.backgroundColor = Color.colors
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var cellModel: NameCellModel? {
        didSet {
            guard let cellModel = self.cellModel else { return }
            cellModel.name.asObserver().subscribe { name in
                self.nameLabel.text = name
            } .disposed(by: disposeBag)
            
            cellModel.carecter.asObserver().subscribe { cheracter in
                self.charecterLabel.text = cheracter
            } .disposed(by: disposeBag)

        }
    }
    
    func rendomColorGen() -> UIColor {
        
    }
    
    enum Color {
        case green, blue, red, yellow, pink, purple, cyan, teal
        
        var colors: UIColor {
            switch self {
            case .green:
                return .green
            case .blue:
                return .blue
            case .red:
                return .red
            case .yellow:
                return .yellow
            case .pink:
                return .systemPink
            case .purple:
                return .purple
            case .cyan:
                return .cyan
            case .teal:
                return .systemTeal
            }
        }
    }
    
}
