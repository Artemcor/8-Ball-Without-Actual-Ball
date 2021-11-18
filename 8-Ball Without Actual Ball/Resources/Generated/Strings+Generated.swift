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
  /// Cancel
  public static let cancel = L10n.tr("InfoPlist", "cancel")
  /// Contrary
  public static let contrary = L10n.tr("InfoPlist", "contrary")
  /// 😶
  public static let contraryEmoji = L10n.tr("InfoPlist", "contraryEmoji")
  /// 😢
  public static let cryingEmoji = L10n.tr("InfoPlist", "cryingEmoji")
  /// Done
  public static let done = L10n.tr("InfoPlist", "done")
  /// 📱
  public static let iPhoneEmoji = L10n.tr("InfoPlist", "iPhoneEmoji")
  /// 🔮
  public static let magicBallEmoji = L10n.tr("InfoPlist", "magicBallEmoji")
  /// Neutral
  public static let neutral = L10n.tr("InfoPlist", "neutral")
  /// 🤔
  public static let neutralEmoji = L10n.tr("InfoPlist", "neutralEmoji")
  /// MAGIC DOESN'T HAPPEN. YOU CAN ADD SOME IN SETTINGS.
  public static let noMagic = L10n.tr("InfoPlist", "noMagic")
  /// Pick type of answer👇
  public static let pickType = L10n.tr("InfoPlist", "pickType")
  /// Shake Your iPhone
  public static let shake = L10n.tr("InfoPlist", "shake")
  /// SHAKE YOUR PHONE BETTER
  public static let shakeBetter = L10n.tr("InfoPlist", "shakeBetter")
  /// https://8ball.delegator.com/magic/JSON/<question_string>
  public static let url = L10n.tr("InfoPlist", "url")
  /// Write your variant of answer
  public static let writeYouVariant = L10n.tr("InfoPlist", "writeYouVariant")
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
