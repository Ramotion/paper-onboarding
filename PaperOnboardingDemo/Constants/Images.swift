// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

extension UIImage {
  enum Asset: String {
    case BigIconFird = "bigIconFird"
    case BigIconFirst = "bigIconFirst"
    case BigIconSecond = "bigIconSecond"
    case IconFirst = "iconFirst"
    case IconSecond = "iconSecond"
    case IconThird = "iconThird"

    var image: UIImage {
      return UIImage(asset: self)
    }
  }

  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
