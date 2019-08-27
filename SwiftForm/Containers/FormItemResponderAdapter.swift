//
//  FormItemResponderContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol FormItemResponderAdapter {
  associatedtype ResponderType: UIResponder
  associatedtype ResponderInputViewType: UIView
  
  var responder: ResponderType { get }
  var responderInputView: ResponderInputViewType { get }
}

public protocol TextFieldFormItemResponderAdapter: FormItemResponderAdapter {
  var responder: UITextField { get }
}
