//
//  AppLabels.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import UIKit

struct Style<T> {
    let apply: (T) -> Void
    
    init(apply: @escaping (T) -> Void ) {
        self.apply = apply
    }
}

protocol LabelStyleProvider {
    var style: Style<UILabel> { get }
}

// MARK: - BaseLabel
class BaseLabel: UILabel {
    init(provider: LabelStyleProvider) {
        super.init(frame: .zero)
        provider.style.apply(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Impt")
    }
}

// MARK: - HeaderStyle
struct HeaderStyle: LabelStyleProvider {
    var style: Style<UILabel> {
        Style { label in
            label.font = .systemFont(ofSize: 24, weight: .bold)
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 0
        }
    }
}

// MARK: - BodyStyle
struct BodyStyle: LabelStyleProvider {
    var style: Style<UILabel> {
        Style { label in
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textColor = .darkGray
            label.numberOfLines = 0
        }
    }
}

// MARK: - Headerlabel
final class HeaderLabel: BaseLabel {
    init() {super.init(provider: HeaderStyle())}
    required init?(coder: NSCoder) { fatalError() }
}

// MARK: - BodyLabel
final class BodyLabel: BaseLabel {
    init() { super.init(provider: BodyStyle()) }
    required init?(coder: NSCoder) { fatalError() }
}
