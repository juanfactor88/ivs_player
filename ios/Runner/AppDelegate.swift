import UIKit
import Flutter
// Import AmazonIVSPlayer if you're using it directly in the AppDelegate

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var ivsPlayerManager: IVSPlayerManager?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        ivsPlayerManager = IVSPlayerManager()
        setupIVSChannel()
        setupIVSPlayerViewFactory()

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func setupIVSChannel() {
        guard let controller = window?.rootViewController as? FlutterViewController else {
            fatalError("Invalid root view controller")
        }

        let ivsChannel = FlutterMethodChannel(name: "com.example.ivs_player", binaryMessenger: controller.binaryMessenger)
        ivsChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case "play":
                if let args = call.arguments as? [String: Any], let url = args["url"] as? String {
                    self?.ivsPlayerManager?.play(url: url)
                }
            case "dispose":
                self?.ivsPlayerManager?.dispose()
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func setupIVSPlayerViewFactory() {
        guard let registrar = self.registrar(forPlugin: "plugin-name") else {
            fatalError("Unable to get registrar")
        }
        let factory = IVSPlayerViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "ivs_player_view")
    }
}


