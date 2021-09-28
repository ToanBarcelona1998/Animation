import Flutter
import UIKit
import Photos


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
  let saveImageChannel = FlutterMethodChannel(name: "save-file" , binaryMessenger : controller.binaryMessenger)

  saveImageChannel.setMethodCallHandler({
  (call: FlutterMethodCall , result : @escaping FlutterResult) ->
          if call.method == "save_file"{
            self.saveMedia
          }
   })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

   func saveMedia(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
         let args = call.arguments as? Dictionary<String, Any>
         let path = args![self.path] as! String
         let albumName = args![self.albumName] as? String

         let status = PHPhotoLibrary.authorizationStatus()
         if status == .notDetermined {
             PHPhotoLibrary.requestAuthorization({status in
                 if status == .authorized{
                     self._saveMediaToAlbum(path, albumName, result)
                 } else {
                     result(false);
                 }
             })
         } else if status == .authorized {
             self._saveMediaToAlbum(path, albumName, result)
         } else {
             result(false);
         }
     }

     private func _saveMediaToAlbum(_ imagePath: String, _ albumName: String?,
                                    _ flutterResult: @escaping FlutterResult) {
         if(albumName == nil){
            self.saveFile(imagePath,, nil, flutterResult)
         } else if let album = fetchAssetCollectionForAlbum(albumName!) {
              self.saveFile(imagePath, album, flutterResult)
         } else {
             // create photos album
             createAppPhotosAlbum(albumName: albumName!) { (error) in
                 guard error == nil else {
                     flutterResult(false)
                     return
                     }
                 if let album = self.fetchAssetCollectionForAlbum(albumName!){
                     self.saveFile(imagePath, album, flutterResult)
                 } else {
                     flutterResult(false)
                 }
             }
         }
     }

     private func saveFile(_ filePath: String, _ mediaType: MediaType, _ album: PHAssetCollection?,
                           _ flutterResult: @escaping FlutterResult) {
         let url = URL(fileURLWithPath: filePath)
         PHPhotoLibrary.shared().performChanges({
             let assetCreationRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
             if (album != nil) {
                 guard let assetCollectionChangeRequest = PHAssetCollectionChangeRequest(for: album!),
                     let createdAssetPlaceholder = assetCreationRequest?.placeholderForCreatedAsset else {
                             return
                     }
                 assetCollectionChangeRequest.addAssets(NSArray(array: [createdAssetPlaceholder]))
             }
         }) { (success, error) in
             if success {
                 flutterResult(true)
             } else {
                 flutterResult(false)
             }
         }
     }

     private func fetchAssetCollectionForAlbum(_ albumName: String) -> PHAssetCollection? {
         let fetchOptions = PHFetchOptions()
         fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
         let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)

         if let _: AnyObject = collection.firstObject {
             return collection.firstObject
         }
         return nil
     }

     private func createAppPhotosAlbum(albumName: String, completion: @escaping (Error?) -> ()) {
         PHPhotoLibrary.shared().performChanges({
             PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)
         }) { (_, error) in
             DispatchQueue.main.async {
                 completion(error)
             }
         }
     }
}

