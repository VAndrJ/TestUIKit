//
//  Base.swift
//  TestUIKit
//
//  Created by Volodymyr Andriienko on 11.04.2024.
//

import UIKit

class BaseController<V: UIView>: UIViewController {
    let contentView: V

    init(view: V) {
        self.contentView = view

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }
}

class BaseScrollView: UIScrollView {

    init() {
        super.init(frame: .init(x: 0, y: 0, width: 240, height: 128))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
