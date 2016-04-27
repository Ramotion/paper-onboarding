#!/usr/bin/env xcrun swift

import Foundation

// MARK: NSUserDefaults extension
extension NSUserDefaults {
    var arguments: (String, String, String) {
        guard let assetPath  = stringForKey("path") else {
            fatalError("An asset catalog path must be specified by \"-path\".")
        }
        guard let outputPath = stringForKey("exportPath") else {
            fatalError("An output path must be specified by \"-exportPath\".")
        }
        // enumName is optional and "ImageAsset" is used for enum as default value.
        let enumName = stringForKey("enumName") ?? "ImageAsset"
        return (assetPath, outputPath, enumName)
    }
}
// MARK: NSFileManager
extension NSFileManager {
    func imagesets(inAssetsPath path: String) -> [String]? {
        do {
            let subpaths = try subpathsOfDirectoryAtPath(path)
            return subpaths
                .filter {
                    $0.hasSuffix("imageset")
                }
                .map {
                    ($0 as NSString).lastPathComponent.componentsSeparatedByString(".")[0]
                }
        }
        catch {
            print("\n[Error] An error occurred in \(#function).\n\t error: \(error)\n")
        }
        return nil
    }
}

// MARK: - Functions
func build(assets: [String], _ exportPath: String, _ enumName: String) -> Bool {
    let indent = "    " // indent is 4 spaces
    var file: String = ""
    /// file header
    file += "// Generated with Misen by tasanobu - https://github.com/tasanobu/Misen" + "\n"
    file += "\n"
    file += "import UIKit" + "\n"
    file += "\n"
    
    /// UIImage extension
    file += "// MARK: - UIImage extension" + "\n"
    file += "extension UIImage {" + "\n"
    // initializer
    file += indent + "convenience init!(assetName: \(enumName)) {" + "\n"
        file += indent + indent + "self.init(named: assetName.rawValue)" + "\n"
    file += indent + "}" + "\n"
    ///end of UIImage extension
    file += "}" + "\n"
    
    file += "\n"
    
    /// enum
    file += "// MARK: - " + enumName + "\n"
    file += "enum \(enumName): String {" + "\n"
    assets.forEach {
        file += indent + "case \($0) = \"\($0)\"" + "\n"
    }
    file += "\n"
    file += indent + "var image: UIImage {" + "\n"
    file += indent + indent + "return UIImage(named: self.rawValue)!" + "\n"
    file += indent + "}" + "\n"
    /// end of enum
    file += "}" + "\n"
    
    let data = file.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
    return NSFileManager.defaultManager().createFileAtPath(exportPath, contents: data, attributes: nil)
}

// MARK: - Main
let (path, exportPath, enumName) = NSUserDefaults.standardUserDefaults().arguments
let fm = NSFileManager.defaultManager()

guard let imagesets = fm.imagesets(inAssetsPath: path) where !imagesets.isEmpty else {
    fatalError("\n[Error] No imageset is found and failed to export a file...\n")
}
//let result = fm.build(imagesets, exportPath, enumName)
let result = build(imagesets, exportPath, enumName)
let resultStr = result ? "Succeeded" : "Failed"
print("\n\(resultStr) to generate enum and UIImage extension file at \(exportPath).\n")
