//
//  Configuring.swift
//  AnimatedPageView
//
//  Created by Alex K. on 12/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import Foundation

@warn_unused_result
internal func Init<Type>(value : Type, @noescape block: (object: Type) -> Void) -> Type
{
  block(object: value)
  return value
}
