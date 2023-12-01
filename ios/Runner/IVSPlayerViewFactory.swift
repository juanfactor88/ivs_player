import Foundation
import Flutter
import UIKit
import AmazonIVSPlayer

class IVSPlayerViewFactory: NSObject, FlutterPlatformViewFactory {
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return IVSPlayerFlutterView(frame: frame, viewId: viewId, args: args)
    }
}