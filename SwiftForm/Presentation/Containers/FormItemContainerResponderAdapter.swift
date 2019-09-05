//
//  FormItemResponderContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol FormItemContainerResponderAdapter {
  associatedtype ResponderType: UIResponder
  associatedtype ResponderInputViewType: UIView
  
  var responder: ResponderType { get }
  var responderInputView: ResponderInputViewType { get }
}

public protocol TextFieldFormItemContainerResponderAdapter: FormItemContainerResponderAdapter {
  var responder: UITextField { get }
}
