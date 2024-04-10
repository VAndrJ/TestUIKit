# A simple project to render a UI Layout in UIKit getting the rendering time to compare against SwiftUI

The layout consist in a simple UIScrollView having a content View and a nested UIStackView containing 100 rows.
Each row has its own layout consisting in a UIStackView containing an UIImageView and a UILabel.

No UITableView, UICollectionView or any other optimization is implemented because the purpose is to stress the system forcing the render of all Views happens before the `viewDidAppear`.

This test project has been implemented to do an high level comparison rendering a simple UI in SwiftUI.
There is a companion project in which the same layout has been implemented in UIKit trying to replicate the same View hierarchy:
https://github.com/maxbellucci69/TestSwiftUI

The time to render is calculated on the onAppear for SwiftUI and viewDidAppear for UIKit.
A start time retrieved with `CFAbsoluteTimeGetCurrent()` is stored at initialization of properties happening on creation of the View for SwiftUI, similarly it is stored at UIViewController properties initialization for UIKit.
The elapsed time is calculate as the difference between the `CFAbsoluteTimeGetCurrent()` value read when the view is appear.

You can increase the number of rows generated simply changing the upper bound in the ForEach, but take care that the rendering time will increase dramatically in UIKit:

## Values measured on physical device iPhone 7 - 128GB - iOS 15.8.2
Project built as Release target with optimization and directly deployed on the device.

| Number of rows | Rendering time SwiftUI | Rendering time UIKit |
| --- | --- | --- |
| 100 rows | 0.056s | 0.14s | 
| 500 rows | 0.2s | 4.0s | 
| 1000 rows | 0.33s | 29.34s | *** The rendering time for UIKit is so long that Apple close the app if you don't build and run directly from XCode ***

Full measurement time iOS 17.2 simulator (on M1)
| Number of rows | Time SwiftUI | Time UIKit |
| --- | --- | --- |
| 100 rows | 0.0918s | 0.0806s | 
| 500 rows | 0.1386s | 0.9491s | 
| 1000 rows | 0.2062s | 10.4252s |

Full measurement time without nested UIStackView iOS 17.2 simulator (on M1)
| Number of rows | Time SwiftUI | Time UIKit | UIStackView slower |
| --- | --- | --- | --- |
| 100 rows | 0.0918s | 0.0682s | 1.18x |
| 500 rows | 0.1386s | 0.2484s | 3.82x |
| 1000 rows | 0.2062s | 0.6104s | 17.08x |

Full measurement time Flex+PinLayout iOS 17.2 simulator (on M1)
| Number of rows | Time UIKit | UIStackView slower |
| --- | --- | --- |
| 100 rows | 0.0512s | 1.57x |
| 500 rows | 0.1348s | 7.04x |
| 1000 rows | 0.2454s | 42.48x |
