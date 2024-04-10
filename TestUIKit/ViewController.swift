import UIKit
import FlexLayout
import PinLayout

class MainView: BaseScrollView {
    let timeLabel = UILabel()

    private let contentView = UIView()
    private let views = (0...1000).map { row(image: "globe", text: "Hello, world #\($0)!") }

    override init() {
        super.init()

        addElements()
        configure()
    }

    private func configure() {
        backgroundColor = .systemBackground
    }

    private func addElements() {
        addSubview(contentView)

        contentView.addSubview(timeLabel)
        views.forEach {
            contentView.addSubview($0)
        }
        contentView.flex.direction(.column).padding(8).define { flex in
            flex.addItem(timeLabel).height(20)
            views.forEach {
                flex.addItem($0)
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.pin.pinEdges().width(100%)
        contentView.flex.layout(mode: .adjustHeight)
        contentSize = contentView.frame.size
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

private let imageSize = CGSize(width: 20, height: 20)

private func row(image: String, text: String) -> UIView {
    let imageView = UIImageView(image: UIImage(systemName: image))
    let textView = UILabel()
    textView.text = text
    let containerView = UIView()
    containerView.addSubview(imageView)
    containerView.addSubview(textView)
    containerView.flex.direction(.row).alignItems(.center).define { flex in
        flex.addItem(imageView).size(imageSize)
        flex.addItem(textView).paddingLeft(8)
    }

    return containerView
}
