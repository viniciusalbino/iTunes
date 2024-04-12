
import Foundation
import UIKit

final class PriceView: UIView {
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat.fontSize(.fontSizeSm), weight: .regular)
        label.textAlignment = .center
        label.textColor = UIColor.systemBlue
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 6
        backgroundColor = .white
        
        addSubview(priceLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
    
    func fill(price: String) {
        priceLabel.text = price
    }
}
