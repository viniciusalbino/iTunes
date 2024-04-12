
import Foundation
import UIKit

class DetailHeaderView: UIView {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 6
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 180).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 180).isActive = true
        return iv
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let priceView: PriceView = {
        let view = PriceView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(songNameLabel)
        stackView.addArrangedSubview(artistLabel)
        stackView.addArrangedSubview(priceView)
        
        addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    public func fill(dto: DetailHeaderViewDTO) {
        songNameLabel.text = dto.name
        artistLabel.text = dto.subtitle
        priceView.fill(price: dto.price)
        imageView.loadImageUsingCacheWithUrlString(urlString: dto.imageURL)
    }
}

public struct DetailHeaderViewDTO {
    var imageURL: String
    var name: String
    var subtitle: String
    var price: String
}
