// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

extension UIImage {
  enum Asset: String {
    case Banks = "Banks"
    case Hotels = "Hotels"
    case Key = "Key"
    case Shopping_Cart = "Shopping-cart"
    case Stores = "Stores"
    case Wallet = "Wallet"

    var image: UIImage {
      return UIImage(asset: self)
    }
  }

  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
