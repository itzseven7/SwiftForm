//
//  PlaceOfBirthFormItem.swift
//  SwiftFormTestApp
//
//  Created by Romain on 09/08/2019.
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class PlaceOfBirthFormItem: ListFormItem<String> {
  init(countryCode: String?) {
    super.init(value: countryCode, values: NSLocale.isoCountryCodes)
  }
}
