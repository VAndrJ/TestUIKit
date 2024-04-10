import UIKit
import FlexLayout
import PinLayout

class MainView: BaseScrollView {
    let timeLabel = UILabel()

    private let contentView = UIView()
    private let views = (0...1000).map { RowView(image: "globe", text: "Hello, world #\($0)!") }

    override init() {
        super.init()

        addElements()
        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.pin.pinEdges().width(100%)
        contentView.flex.layout(mode: .adjustHeight)
        contentSize = contentView.frame.size
    }

    private func configure() {
        backgroundColor = .systemBackground
    }

    private func addElements() {
        addSubview(contentView)

        contentView.flex.direction(.column).padding(8).define { flex in
            flex.addItem(timeLabel).height(20)
            views.forEach {
                flex.addItem($0)
            }
        }
    }
}

class RowView: BaseView {
    private static let imageSize = CGSize(width: 20, height: 20)

    let imageView: UIImageView
    let textView = UILabel()

    init(image: String, text: String) {
        self.imageView = .init(image: .init(systemName: image))

        super.init()

        textView.text = text
        flex.direction(.row).alignItems(.center).define { flex in
            flex.addItem(imageView).size(Self.imageSize)
            flex.addItem(textView).marginLeft(8)
        }
    }
}

class ViewController: BaseController<MainView> {
    private let start = CFAbsoluteTimeGetCurrent()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let currentTime = CFAbsoluteTimeGetCurrent()
        print("init to viewDidAppear", currentTime - initTime)
        contentView.timeLabel.text = "Time to render: \(currentTime - start) seconds"
    }
}
