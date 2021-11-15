// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Affirmative
  public static let affirmative = L10n.tr("InfoPlist", "affirmative")
  /// 🙂
  public static let affirmativeEmoji = L10n.tr("InfoPlist", "affirmativeEmoji")
  /// 
  public static let blankSpace = L10n.tr("InfoPlist", "blankSpace")
  /// 🧨
  public static let bombEmoji = L10n.tr("InfoPlist", "bombEmoji")
  /// Contrary
  public static let contrary = L10n.tr("InfoPlist", "contrary")
  /// 😶
  public static let contraryEmoji = L10n.tr("InfoPlist", "contraryEmoji")
  /// 😢
  public static let cryingEmoji = L10n.tr("InfoPlist", "cryingEmoji")
  /// 🔮
  public static let magicBallEmoji = L10n.tr("InfoPlist", "magicBallEmoji")
  /// Neutral
  public static let neutral = L10n.tr("InfoPlist", "neutral")
  /// 🤔
  public static let neutralEmoji = L10n.tr("InfoPlist", "neutralEmoji")
  /// Magic doesn't happen. You can add some in Settings.
  public static let noMagic = L10n.tr("InfoPlist", "noMagic")
  /// Shake your iPhone better
  public static let shakeBetter = L10n.tr("InfoPlist", "shakeBetter")
  /// https://8ball.delegator.com/magic/JSON/<question_string>
  public static let url = L10n.tr("InfoPlist", "url")
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
