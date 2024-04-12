
import Foundation
import UIKit

final class SongCell: UICollectionViewCell {
    static let reuseIdentifer = "SongCell"
    
    private var icon: UIImageView = UIImageView(frame: .zero)
    private var titleLabel: UILabel = UILabel(frame: .zero)
    private var subtitleLabel: UILabel = UILabel(frame: .zero)
    private var priceView: PriceView = PriceView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.designSystem(.secondaryColor)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        addSubview(icon)
        
        titleLabel.font = .systemFont(ofSize: CGFloat.fontSize(.fontSizeSm), weight: .bold)
        titleLabel.textColor = .designSystem(.textPrimaryColor)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        addSubview(titleLabel)
        
        subtitleLabel.font = .systemFont(ofSize: CGFloat.fontSize(.fontSizeSm), weight: .regular)
        subtitleLabel.textColor = .designSystem(.textSecondaryColor)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.numberOfLines = 1
        addSubview(subtitleLabel)
        
        addSubview(priceView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat.spacing(.spacingMd)),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 50),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: CGFloat.spacing(.spacingSm)),
            titleLabel.topAnchor.constraint(equalTo: icon.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: -CGFloat.spacing(.spacingMd)),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        priceView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat.spacing(.spacingMd)),
            priceView.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceView.widthAnchor.constraint(equalToConstant: 70),
            priceView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func fill(dto: SongCellDTO) {
        titleLabel.text = dto.name
        subtitleLabel.text = dto.subtitle
        icon.loadImageUsingCacheWithUrlString(urlString: dto.imageURL)
        priceView.fill(price: dto.price)
    }
}

public struct SongCellDTO {
    var name: String
    var subtitle: String
    var imageURL: String
    var price: String
}
