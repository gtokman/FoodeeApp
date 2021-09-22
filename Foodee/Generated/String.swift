// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// home.cat.all.text
  internal static let all = L10n.tr("Localizable", "All")
  /// home.cat.beer.text
  internal static let beer = L10n.tr("Localizable", "Beer")
  /// home.cat.breakfast.text
  internal static let breakfast = L10n.tr("Localizable", "Breakfast")
  /// home.cat.title
  internal static let categories = L10n.tr("Localizable", "Categories")
  /// home.cat.coffee.text
  internal static let coffee = L10n.tr("Localizable", "Coffee")
  /// home.cat.donuts.text
  internal static let donuts = L10n.tr("Localizable", "Donuts")
  /// detail.nav.title
  internal static let favorites = L10n.tr("Localizable", "Favorites")
  /// permission.desc.text
  internal static let findNewCoolSpotsToEat = L10n.tr("Localizable", "Find new cool spots to eat")
  /// permission.title.text
  internal static let foodee = L10n.tr("Localizable", "Foodee")
  /// permission.button.title
  internal static let getStarted = L10n.tr("Localizable", "Get Started")
  /// home.cat.icecream.text
  internal static let iceCream = L10n.tr("Localizable", "Ice Cream")
  /// home.placeholder.text
  internal static let searchFood = L10n.tr("Localizable", "Search food...")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
