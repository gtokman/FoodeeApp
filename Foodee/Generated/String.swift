// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Detail {
    internal enum Nav {
      /// Favorites
      internal static let title = L10n.tr("Localizable", "detail.nav.title")
    }
  }

  internal enum Home {
    internal enum Cat {
      /// Categories
      internal static let title = L10n.tr("Localizable", "home.cat.title")
      internal enum All {
        /// All
        internal static let text = L10n.tr("Localizable", "home.cat.all.text")
      }
      internal enum Beer {
        /// Beer
        internal static let text = L10n.tr("Localizable", "home.cat.beer.text")
      }
      internal enum Breakfast {
        /// Breakfast
        internal static let text = L10n.tr("Localizable", "home.cat.breakfast.text")
      }
      internal enum Coffee {
        /// Coffee
        internal static let text = L10n.tr("Localizable", "home.cat.coffee.text")
      }
      internal enum Donuts {
        /// Donuts
        internal static let text = L10n.tr("Localizable", "home.cat.donuts.text")
      }
      internal enum Icecream {
        /// Ice Cream
        internal static let text = L10n.tr("Localizable", "home.cat.icecream.text")
      }
    }
    internal enum Placeholder {
      /// Search food . . .
      internal static let text = L10n.tr("Localizable", "home.placeholder.text")
    }
  }

  internal enum Permission {
    internal enum Button {
      /// Get Started
      internal static let title = L10n.tr("Localizable", "permission.button.title")
    }
    internal enum Desc {
      /// Find new cool spots to eat
      internal static let text = L10n.tr("Localizable", "permission.desc.text")
    }
    internal enum Title {
      /// Foodee
      internal static let text = L10n.tr("Localizable", "permission.title.text")
    }
  }
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
