//
//  PlaceOfBirthValidator.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class PlaceOfBirthValidator: ListValidator<String> {
  init(countryCode: String?) {
    super.init(value: countryCode, values: NSLocale.isoCountryCodes)
  }
}
