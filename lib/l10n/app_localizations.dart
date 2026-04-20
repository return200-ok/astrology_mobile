import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Mystic Cosmos'**
  String get appTitle;

  /// No description provided for @sidebarBrand.
  ///
  /// In en, this message translates to:
  /// **'MYSTIC COSMOS'**
  String get sidebarBrand;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settings;

  /// No description provided for @homeHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'MYSTIC COSMOS'**
  String get homeHeroTitle;

  /// No description provided for @homeHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'ANCIENT WISDOM OF THE STARS'**
  String get homeHeroSubtitle;

  /// No description provided for @featureOracleTitle.
  ///
  /// In en, this message translates to:
  /// **'ORACLE'**
  String get featureOracleTitle;

  /// No description provided for @featureOracleTagline.
  ///
  /// In en, this message translates to:
  /// **'Seek mystic signs from stars.'**
  String get featureOracleTagline;

  /// No description provided for @featureImperialTitle.
  ///
  /// In en, this message translates to:
  /// **'IMPERIAL'**
  String get featureImperialTitle;

  /// No description provided for @featureImperialTagline.
  ///
  /// In en, this message translates to:
  /// **'Chart your celestial destiny.'**
  String get featureImperialTagline;

  /// No description provided for @featureAlignmentTitle.
  ///
  /// In en, this message translates to:
  /// **'ALIGNMENT'**
  String get featureAlignmentTitle;

  /// No description provided for @featureAlignmentTagline.
  ///
  /// In en, this message translates to:
  /// **'Harmonize soul with heavens.'**
  String get featureAlignmentTagline;

  /// No description provided for @featureIChingTitle.
  ///
  /// In en, this message translates to:
  /// **'I CHING'**
  String get featureIChingTitle;

  /// No description provided for @featureIChingTagline.
  ///
  /// In en, this message translates to:
  /// **'Consult ancient book of changes.'**
  String get featureIChingTagline;

  /// No description provided for @featureSoulRevelationTitle.
  ///
  /// In en, this message translates to:
  /// **'SOUL\nREVELATION'**
  String get featureSoulRevelationTitle;

  /// No description provided for @featureSoulRevelationTagline.
  ///
  /// In en, this message translates to:
  /// **'Reveal your inner self.'**
  String get featureSoulRevelationTagline;

  /// No description provided for @featureCosmicVoidTitle.
  ///
  /// In en, this message translates to:
  /// **'COSMIC VOID'**
  String get featureCosmicVoidTitle;

  /// No description provided for @featureCosmicVoidTagline.
  ///
  /// In en, this message translates to:
  /// **'Deep reflection in silent space.'**
  String get featureCosmicVoidTagline;

  /// No description provided for @featureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Feature coming soon'**
  String get featureComingSoon;

  /// No description provided for @backTooltip.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backTooltip;

  /// No description provided for @commonReturnToSilence.
  ///
  /// In en, this message translates to:
  /// **'RETURN TO SILENCE'**
  String get commonReturnToSilence;

  /// No description provided for @alignmentTitle.
  ///
  /// In en, this message translates to:
  /// **'CELESTIAL ALIGNMENT'**
  String get alignmentTitle;

  /// No description provided for @alignmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'DETERMINING INTER-STELLAR RESONANCE'**
  String get alignmentSubtitle;

  /// No description provided for @alignmentOriginSoul.
  ///
  /// In en, this message translates to:
  /// **'ORIGIN SOUL (SELF)'**
  String get alignmentOriginSoul;

  /// No description provided for @alignmentDistantSoul.
  ///
  /// In en, this message translates to:
  /// **'DISTANT SOUL (EXTERNAL)'**
  String get alignmentDistantSoul;

  /// No description provided for @alignmentChooseSign.
  ///
  /// In en, this message translates to:
  /// **'-- CHOOSE SIGN --'**
  String get alignmentChooseSign;

  /// No description provided for @alignmentSeekButton.
  ///
  /// In en, this message translates to:
  /// **'SEEK ALIGNMENT'**
  String get alignmentSeekButton;

  /// No description provided for @alignmentAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'CELESTIAL RESONANCE ANALYSIS'**
  String get alignmentAnalysisTitle;

  /// No description provided for @alignmentScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'RESONANCE_SCORE'**
  String get alignmentScoreLabel;

  /// No description provided for @alignmentPickExternalSnack.
  ///
  /// In en, this message translates to:
  /// **'Please choose DISTANT SOUL sign'**
  String get alignmentPickExternalSnack;

  /// No description provided for @alignmentMessageOptimized.
  ///
  /// In en, this message translates to:
  /// **'OPTIMIZED ALIGNMENT: Your spiritual paths complement each other.'**
  String get alignmentMessageOptimized;

  /// No description provided for @alignmentMessageHarmonic.
  ///
  /// In en, this message translates to:
  /// **'HARMONIC ALIGNMENT: Your resonance is strong and naturally supportive.'**
  String get alignmentMessageHarmonic;

  /// No description provided for @alignmentMessageGrowth.
  ///
  /// In en, this message translates to:
  /// **'GROWTH ALIGNMENT: This bond expands through patience and dialogue.'**
  String get alignmentMessageGrowth;

  /// No description provided for @alignmentMessageChallenging.
  ///
  /// In en, this message translates to:
  /// **'CHALLENGING ALIGNMENT: Contrast is high; empathy unlocks balance.'**
  String get alignmentMessageChallenging;

  /// No description provided for @imperialTitle.
  ///
  /// In en, this message translates to:
  /// **'IMPERIAL CHART'**
  String get imperialTitle;

  /// No description provided for @imperialSubtitle.
  ///
  /// In en, this message translates to:
  /// **'EASTERN CELESTIAL MAPPING'**
  String get imperialSubtitle;

  /// No description provided for @imperialResultTitle.
  ///
  /// In en, this message translates to:
  /// **'IMPERIAL CELESTIAL CODEX'**
  String get imperialResultTitle;

  /// No description provided for @imperialResultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Eastern Celestial Mapping'**
  String get imperialResultSubtitle;

  /// No description provided for @imperialResultIdentity.
  ///
  /// In en, this message translates to:
  /// **'IDENTITY'**
  String get imperialResultIdentity;

  /// No description provided for @imperialResultDate.
  ///
  /// In en, this message translates to:
  /// **'DATE'**
  String get imperialResultDate;

  /// No description provided for @imperialResultHour.
  ///
  /// In en, this message translates to:
  /// **'HOUR'**
  String get imperialResultHour;

  /// No description provided for @imperialTabChart.
  ///
  /// In en, this message translates to:
  /// **'CHART'**
  String get imperialTabChart;

  /// No description provided for @imperialTabCompatibility.
  ///
  /// In en, this message translates to:
  /// **'COMPATIBILITY'**
  String get imperialTabCompatibility;

  /// No description provided for @imperialTabCalendar.
  ///
  /// In en, this message translates to:
  /// **'CALENDAR'**
  String get imperialTabCalendar;

  /// No description provided for @imperialSpiritId.
  ///
  /// In en, this message translates to:
  /// **'CELESTIAL IDENTITY'**
  String get imperialSpiritId;

  /// No description provided for @imperialSpiritPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'[Enter Spirit Name]'**
  String get imperialSpiritPlaceholder;

  /// No description provided for @imperialArrivalDay.
  ///
  /// In en, this message translates to:
  /// **'DATE OF DESCENT'**
  String get imperialArrivalDay;

  /// No description provided for @imperialStreamsHour.
  ///
  /// In en, this message translates to:
  /// **'HOUR OF DESTINY'**
  String get imperialStreamsHour;

  /// No description provided for @imperialCastStars.
  ///
  /// In en, this message translates to:
  /// **'CAST STARS'**
  String get imperialCastStars;

  /// No description provided for @imperialDatePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'mm/dd/yyyy'**
  String get imperialDatePlaceholder;

  /// No description provided for @imperialFillRequiredSnack.
  ///
  /// In en, this message translates to:
  /// **'Please fill Celestial Identity and Date of Descent'**
  String get imperialFillRequiredSnack;

  /// No description provided for @imperialSolarPrefix.
  ///
  /// In en, this message translates to:
  /// **'SOLAR'**
  String get imperialSolarPrefix;

  /// No description provided for @imperialLunarPrefix.
  ///
  /// In en, this message translates to:
  /// **'LUNAR'**
  String get imperialLunarPrefix;

  /// No description provided for @imperialHourPrefix.
  ///
  /// In en, this message translates to:
  /// **'HOUR'**
  String get imperialHourPrefix;

  /// No description provided for @ichingTitle.
  ///
  /// In en, this message translates to:
  /// **'I CHING'**
  String get ichingTitle;

  /// No description provided for @ichingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'ANCIENT WISDOM OF THE BOOK OF CHANGES'**
  String get ichingSubtitle;

  /// No description provided for @ichingWhisperQueryLabel.
  ///
  /// In en, this message translates to:
  /// **'WHISPER YOUR QUERY TO THE STALKS'**
  String get ichingWhisperQueryLabel;

  /// No description provided for @ichingWhisperQueryHint.
  ///
  /// In en, this message translates to:
  /// **'Whisper your query...'**
  String get ichingWhisperQueryHint;

  /// No description provided for @ichingCastYarrowStalks.
  ///
  /// In en, this message translates to:
  /// **'CAST YARROW STALKS'**
  String get ichingCastYarrowStalks;

  /// No description provided for @ichingAltarReady.
  ///
  /// In en, this message translates to:
  /// **'ALTAR READY'**
  String get ichingAltarReady;

  /// No description provided for @ichingQueryRequiredSnack.
  ///
  /// In en, this message translates to:
  /// **'Please whisper your query first'**
  String get ichingQueryRequiredSnack;

  /// No description provided for @ichingOracleResponse.
  ///
  /// In en, this message translates to:
  /// **'REFLECTIVE INTERPRETATION'**
  String get ichingOracleResponse;

  /// No description provided for @ichingCosmicAnalysis.
  ///
  /// In en, this message translates to:
  /// **'COSMIC ANALYSIS'**
  String get ichingCosmicAnalysis;

  /// No description provided for @ichingSacredGuidance.
  ///
  /// In en, this message translates to:
  /// **'SACRED GUIDANCE'**
  String get ichingSacredGuidance;

  /// No description provided for @ichingQuoteLove.
  ///
  /// In en, this message translates to:
  /// **'Heaven and Earth in flux.'**
  String get ichingQuoteLove;

  /// No description provided for @ichingAnalysisLove.
  ///
  /// In en, this message translates to:
  /// **'The transition from The Creative to The Receptive suggests a process in motion. Your inquiry reflects a need to align with cosmic timing.'**
  String get ichingAnalysisLove;

  /// No description provided for @ichingGuidanceLove1.
  ///
  /// In en, this message translates to:
  /// **'Maintain integrity in all actions'**
  String get ichingGuidanceLove1;

  /// No description provided for @ichingGuidanceLove2.
  ///
  /// In en, this message translates to:
  /// **'Wait for the natural culmination of events'**
  String get ichingGuidanceLove2;

  /// No description provided for @ichingGuidanceLove3.
  ///
  /// In en, this message translates to:
  /// **'Act only when your internal compass is steady'**
  String get ichingGuidanceLove3;

  /// No description provided for @ichingQuoteWork.
  ///
  /// In en, this message translates to:
  /// **'Thunder awakens beneath Mountain.'**
  String get ichingQuoteWork;

  /// No description provided for @ichingAnalysisWork.
  ///
  /// In en, this message translates to:
  /// **'A dormant force seeks disciplined expression. Progress is available, yet it requires patience, preparation, and precise action.'**
  String get ichingAnalysisWork;

  /// No description provided for @ichingGuidanceWork1.
  ///
  /// In en, this message translates to:
  /// **'Strengthen your foundation before expansion'**
  String get ichingGuidanceWork1;

  /// No description provided for @ichingGuidanceWork2.
  ///
  /// In en, this message translates to:
  /// **'Choose one priority and commit to it fully'**
  String get ichingGuidanceWork2;

  /// No description provided for @ichingGuidanceWork3.
  ///
  /// In en, this message translates to:
  /// **'Let timing guide intensity'**
  String get ichingGuidanceWork3;

  /// No description provided for @ichingQuoteDefault.
  ///
  /// In en, this message translates to:
  /// **'Wind moves across still water.'**
  String get ichingQuoteDefault;

  /// No description provided for @ichingAnalysisDefault.
  ///
  /// In en, this message translates to:
  /// **'Your situation is subtle and responsive. Clarity arrives through calm observation rather than forceful pursuit.'**
  String get ichingAnalysisDefault;

  /// No description provided for @ichingGuidanceDefault1.
  ///
  /// In en, this message translates to:
  /// **'Observe patterns before deciding'**
  String get ichingGuidanceDefault1;

  /// No description provided for @ichingGuidanceDefault2.
  ///
  /// In en, this message translates to:
  /// **'Remove noise from your inner dialogue'**
  String get ichingGuidanceDefault2;

  /// No description provided for @ichingGuidanceDefault3.
  ///
  /// In en, this message translates to:
  /// **'Choose the path that preserves balance'**
  String get ichingGuidanceDefault3;

  /// No description provided for @ichingHexagramLabel.
  ///
  /// In en, this message translates to:
  /// **'HEXAGRAM'**
  String get ichingHexagramLabel;

  /// No description provided for @ichingJudgmentLabel.
  ///
  /// In en, this message translates to:
  /// **'JUDGMENT'**
  String get ichingJudgmentLabel;

  /// No description provided for @ichingHexagramNumber.
  ///
  /// In en, this message translates to:
  /// **'Hexagram {number}'**
  String ichingHexagramNumber(int number);

  /// No description provided for @oracleTitle.
  ///
  /// In en, this message translates to:
  /// **'CELESTIAL ORACLE'**
  String get oracleTitle;

  /// No description provided for @oracleSelectPrompt.
  ///
  /// In en, this message translates to:
  /// **'SELECT YOUR COSMIC IDENTIFIER FOR DIVINE COMMUNION'**
  String get oracleSelectPrompt;

  /// No description provided for @oracleResetStars.
  ///
  /// In en, this message translates to:
  /// **'RESET STARS'**
  String get oracleResetStars;

  /// No description provided for @oracleMaleLabel.
  ///
  /// In en, this message translates to:
  /// **'MALE'**
  String get oracleMaleLabel;

  /// No description provided for @oracleFemaleLabel.
  ///
  /// In en, this message translates to:
  /// **'FEMALE'**
  String get oracleFemaleLabel;

  /// No description provided for @oraclePersonalityLabel.
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get oraclePersonalityLabel;

  /// No description provided for @oracleInLoveLabel.
  ///
  /// In en, this message translates to:
  /// **'In Love'**
  String get oracleInLoveLabel;

  /// No description provided for @oracleCareerLabel.
  ///
  /// In en, this message translates to:
  /// **'Career'**
  String get oracleCareerLabel;

  /// No description provided for @oracleWeaknessLabel.
  ///
  /// In en, this message translates to:
  /// **'Weakness'**
  String get oracleWeaknessLabel;

  /// No description provided for @oracleDecansTitle.
  ///
  /// In en, this message translates to:
  /// **'DECAN ANALYSIS'**
  String get oracleDecansTitle;

  /// No description provided for @oraclePlanetLabel.
  ///
  /// In en, this message translates to:
  /// **'Planetary Influence'**
  String get oraclePlanetLabel;

  /// No description provided for @oracleStrengthsLabel.
  ///
  /// In en, this message translates to:
  /// **'Strengths'**
  String get oracleStrengthsLabel;

  /// No description provided for @oracleWeaknessesLabel.
  ///
  /// In en, this message translates to:
  /// **'Weaknesses'**
  String get oracleWeaknessesLabel;

  /// No description provided for @oracleLayersTitle.
  ///
  /// In en, this message translates to:
  /// **'SUN · MOON · RISING'**
  String get oracleLayersTitle;

  /// No description provided for @oracleSunLabel.
  ///
  /// In en, this message translates to:
  /// **'SUN SIGN'**
  String get oracleSunLabel;

  /// No description provided for @oracleMoonLabel.
  ///
  /// In en, this message translates to:
  /// **'MOON SIGN'**
  String get oracleMoonLabel;

  /// No description provided for @oracleRisingLabel.
  ///
  /// In en, this message translates to:
  /// **'RISING SIGN'**
  String get oracleRisingLabel;

  /// No description provided for @oracleEssenceLabel.
  ///
  /// In en, this message translates to:
  /// **'ESSENCE'**
  String get oracleEssenceLabel;

  /// No description provided for @oracleAskAiButton.
  ///
  /// In en, this message translates to:
  /// **'ASK AI'**
  String get oracleAskAiButton;

  /// No description provided for @oracleAiTitle.
  ///
  /// In en, this message translates to:
  /// **'ASK ABOUT THIS SIGN'**
  String get oracleAiTitle;

  /// No description provided for @oracleAiHint.
  ///
  /// In en, this message translates to:
  /// **'Ask a question...'**
  String get oracleAiHint;

  /// No description provided for @oracleAiSuggest1.
  ///
  /// In en, this message translates to:
  /// **'Which sign is most compatible with this one?'**
  String get oracleAiSuggest1;

  /// No description provided for @oracleAiSuggest2.
  ///
  /// In en, this message translates to:
  /// **'What is the greatest strength of this sign?'**
  String get oracleAiSuggest2;

  /// No description provided for @oracleAiSuggest3.
  ///
  /// In en, this message translates to:
  /// **'What weakness should this sign watch out for?'**
  String get oracleAiSuggest3;

  /// No description provided for @oracleAiSessionLimit.
  ///
  /// In en, this message translates to:
  /// **'Session limit reached ({count} questions)'**
  String oracleAiSessionLimit(int count);

  /// No description provided for @soulRevelationTitle.
  ///
  /// In en, this message translates to:
  /// **'SOUL REVELATION'**
  String get soulRevelationTitle;

  /// No description provided for @enneagramTitle.
  ///
  /// In en, this message translates to:
  /// **'ENNEAGRAM_V9'**
  String get enneagramTitle;

  /// No description provided for @soulQuote.
  ///
  /// In en, this message translates to:
  /// **'\"Before the stars can guide you, the inner self must be revealed.\"'**
  String get soulQuote;

  /// No description provided for @soulBeginRevelation.
  ///
  /// In en, this message translates to:
  /// **'BEGIN TEST'**
  String get soulBeginRevelation;

  /// No description provided for @soulChanneling.
  ///
  /// In en, this message translates to:
  /// **'CHANNELING...'**
  String get soulChanneling;

  /// No description provided for @soulSignatureFound.
  ///
  /// In en, this message translates to:
  /// **'BIG FIVE RESULTS'**
  String get soulSignatureFound;

  /// No description provided for @soulPurify.
  ///
  /// In en, this message translates to:
  /// **'PURIFY'**
  String get soulPurify;

  /// No description provided for @soulSpiritualProfile.
  ///
  /// In en, this message translates to:
  /// **'PERSONALITY PROFILE'**
  String get soulSpiritualProfile;

  /// No description provided for @soulArchetypeFound.
  ///
  /// In en, this message translates to:
  /// **'PERSONALITY PATTERN IDENTIFIED'**
  String get soulArchetypeFound;

  /// No description provided for @soulEssenceProgress.
  ///
  /// In en, this message translates to:
  /// **'QUESTION: {current} / {total}'**
  String soulEssenceProgress(int current, int total);

  /// No description provided for @cosmicVoidTitle.
  ///
  /// In en, this message translates to:
  /// **'COSMIC VOID'**
  String get cosmicVoidTitle;

  /// No description provided for @cosmicVoidSubtitle.
  ///
  /// In en, this message translates to:
  /// **'ECHOES FROM THE ASTRAL PLANE'**
  String get cosmicVoidSubtitle;

  /// No description provided for @cosmicPanelTitle.
  ///
  /// In en, this message translates to:
  /// **'COMMUNE_WITH_VOID.EXE'**
  String get cosmicPanelTitle;

  /// No description provided for @cosmicSpiritAlias.
  ///
  /// In en, this message translates to:
  /// **'SPIRIT / ALIAS'**
  String get cosmicSpiritAlias;

  /// No description provided for @cosmicCelestialSign.
  ///
  /// In en, this message translates to:
  /// **'CELESTIAL SIGN'**
  String get cosmicCelestialSign;

  /// No description provided for @cosmicSpiritualEssence.
  ///
  /// In en, this message translates to:
  /// **'SPIRITUAL ESSENCE'**
  String get cosmicSpiritualEssence;

  /// No description provided for @cosmicSpiritPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'SPIRIT_ID'**
  String get cosmicSpiritPlaceholder;

  /// No description provided for @cosmicWhisperHint.
  ///
  /// In en, this message translates to:
  /// **'WHISPER TO THE STARS...'**
  String get cosmicWhisperHint;

  /// No description provided for @cosmicWhisperToVoid.
  ///
  /// In en, this message translates to:
  /// **'WHISPER TO THE VOID'**
  String get cosmicWhisperToVoid;

  /// No description provided for @cosmicEchoesTitle.
  ///
  /// In en, this message translates to:
  /// **'ECHOES OF OTHER SOULS'**
  String get cosmicEchoesTitle;

  /// No description provided for @cosmicSilentPrimary.
  ///
  /// In en, this message translates to:
  /// **'The celestial void is currently silent.'**
  String get cosmicSilentPrimary;

  /// No description provided for @cosmicSilentSecondary.
  ///
  /// In en, this message translates to:
  /// **'THE ASTRAL SILENCE IS PROFOUND.'**
  String get cosmicSilentSecondary;

  /// No description provided for @cosmicFillRequiredSnack.
  ///
  /// In en, this message translates to:
  /// **'Please fill SPIRIT_ID and SPIRITUAL ESSENCE'**
  String get cosmicFillRequiredSnack;

  /// No description provided for @cosmicSentSnack.
  ///
  /// In en, this message translates to:
  /// **'Whisper sent to the void'**
  String get cosmicSentSnack;

  /// No description provided for @settingsSectionPersonalize.
  ///
  /// In en, this message translates to:
  /// **'PERSONALIZE'**
  String get settingsSectionPersonalize;

  /// No description provided for @settingsSectionSystem.
  ///
  /// In en, this message translates to:
  /// **'SYSTEM'**
  String get settingsSectionSystem;

  /// No description provided for @settingsSectionSupport.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get settingsSectionSupport;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsAppearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsAppearanceLight;

  /// No description provided for @settingsAppearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsAppearanceDark;

  /// No description provided for @settingsAppearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsAppearanceSystem;

  /// No description provided for @settingsChooseAppearance.
  ///
  /// In en, this message translates to:
  /// **'Choose Appearance'**
  String get settingsChooseAppearance;

  /// No description provided for @settingsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get settingsComingSoon;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsSound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get settingsSound;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get settingsTerms;

  /// No description provided for @settingsContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get settingsContact;

  /// No description provided for @settingsRate.
  ///
  /// In en, this message translates to:
  /// **'Rate This App'**
  String get settingsRate;

  /// No description provided for @settingsChooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get settingsChooseLanguage;

  /// No description provided for @settingsSystemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsSystemDefault;

  /// No description provided for @settingsEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsEnglish;

  /// No description provided for @settingsVietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get settingsVietnamese;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersion(String version);

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @alignmentBondType.
  ///
  /// In en, this message translates to:
  /// **'BOND TYPE'**
  String get alignmentBondType;

  /// No description provided for @alignmentBondRomantic.
  ///
  /// In en, this message translates to:
  /// **'Romantic Connection'**
  String get alignmentBondRomantic;

  /// No description provided for @alignmentBondFriendship.
  ///
  /// In en, this message translates to:
  /// **'Friendship Bond'**
  String get alignmentBondFriendship;

  /// No description provided for @alignmentBondSoul.
  ///
  /// In en, this message translates to:
  /// **'Soul Resonance'**
  String get alignmentBondSoul;

  /// No description provided for @alignmentBondKinship.
  ///
  /// In en, this message translates to:
  /// **'Celestial Kinship'**
  String get alignmentBondKinship;

  /// No description provided for @alignmentFooterBonds.
  ///
  /// In en, this message translates to:
  /// **'∞ Bonds Available'**
  String get alignmentFooterBonds;

  /// No description provided for @alignmentFooterRecent.
  ///
  /// In en, this message translates to:
  /// **'View Recent Alignments'**
  String get alignmentFooterRecent;

  /// No description provided for @alignmentBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'WHY THIS SCORE'**
  String get alignmentBreakdownTitle;

  /// No description provided for @alignmentBreakdownBaseline.
  ///
  /// In en, this message translates to:
  /// **'Baseline 50'**
  String get alignmentBreakdownBaseline;

  /// No description provided for @alignmentBreakdownDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Analysis is based on element, modality, polarity, and aspect between the two signs. For reference only — not a prediction.'**
  String get alignmentBreakdownDisclaimer;

  /// No description provided for @alignmentFactorElement.
  ///
  /// In en, this message translates to:
  /// **'Element'**
  String get alignmentFactorElement;

  /// No description provided for @alignmentFactorModality.
  ///
  /// In en, this message translates to:
  /// **'Modality'**
  String get alignmentFactorModality;

  /// No description provided for @alignmentFactorPolarity.
  ///
  /// In en, this message translates to:
  /// **'Polarity'**
  String get alignmentFactorPolarity;

  /// No description provided for @alignmentFactorAspect.
  ///
  /// In en, this message translates to:
  /// **'Aspect'**
  String get alignmentFactorAspect;

  /// No description provided for @alignmentFactorBondType.
  ///
  /// In en, this message translates to:
  /// **'Bond type'**
  String get alignmentFactorBondType;

  /// No description provided for @alignmentElementFire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get alignmentElementFire;

  /// No description provided for @alignmentElementEarth.
  ///
  /// In en, this message translates to:
  /// **'Earth'**
  String get alignmentElementEarth;

  /// No description provided for @alignmentElementAir.
  ///
  /// In en, this message translates to:
  /// **'Air'**
  String get alignmentElementAir;

  /// No description provided for @alignmentElementWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get alignmentElementWater;

  /// No description provided for @alignmentModalityCardinal.
  ///
  /// In en, this message translates to:
  /// **'Cardinal'**
  String get alignmentModalityCardinal;

  /// No description provided for @alignmentModalityFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get alignmentModalityFixed;

  /// No description provided for @alignmentModalityMutable.
  ///
  /// In en, this message translates to:
  /// **'Mutable'**
  String get alignmentModalityMutable;

  /// No description provided for @alignmentExplainSameElement.
  ///
  /// In en, this message translates to:
  /// **'Same element {element} — shared approach to the world; tend to understand each other instinctively.'**
  String alignmentExplainSameElement(String element);

  /// No description provided for @alignmentExplainComplementElement.
  ///
  /// In en, this message translates to:
  /// **'Complementary elements — Fire+Air fuels inspiration; Water+Earth fuels stability.'**
  String get alignmentExplainComplementElement;

  /// No description provided for @alignmentExplainTensionElement.
  ///
  /// In en, this message translates to:
  /// **'Element friction — distinctly different approaches; empathy is needed for harmony.'**
  String get alignmentExplainTensionElement;

  /// No description provided for @alignmentExplainSameModality.
  ///
  /// In en, this message translates to:
  /// **'Same modality {modality} — synchronized drive, but may compete for the same role.'**
  String alignmentExplainSameModality(String modality);

  /// No description provided for @alignmentExplainDifferentModality.
  ///
  /// In en, this message translates to:
  /// **'Different modalities — complementary roles: initiator, sustainer, adapter.'**
  String get alignmentExplainDifferentModality;

  /// No description provided for @alignmentExplainSamePolarity.
  ///
  /// In en, this message translates to:
  /// **'Same polarity — energies move at the same rhythm.'**
  String get alignmentExplainSamePolarity;

  /// No description provided for @alignmentExplainOppositePolarity.
  ///
  /// In en, this message translates to:
  /// **'Opposite polarity — dynamic balance between active and receptive.'**
  String get alignmentExplainOppositePolarity;

  /// No description provided for @alignmentAspectConjunction.
  ///
  /// In en, this message translates to:
  /// **'Conjunction'**
  String get alignmentAspectConjunction;

  /// No description provided for @alignmentAspectSemisextile.
  ///
  /// In en, this message translates to:
  /// **'Semisextile'**
  String get alignmentAspectSemisextile;

  /// No description provided for @alignmentAspectSextile.
  ///
  /// In en, this message translates to:
  /// **'Sextile'**
  String get alignmentAspectSextile;

  /// No description provided for @alignmentAspectSquare.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get alignmentAspectSquare;

  /// No description provided for @alignmentAspectTrine.
  ///
  /// In en, this message translates to:
  /// **'Trine'**
  String get alignmentAspectTrine;

  /// No description provided for @alignmentAspectQuincunx.
  ///
  /// In en, this message translates to:
  /// **'Quincunx'**
  String get alignmentAspectQuincunx;

  /// No description provided for @alignmentAspectOpposition.
  ///
  /// In en, this message translates to:
  /// **'Opposition'**
  String get alignmentAspectOpposition;

  /// No description provided for @alignmentExplainAspectConjunction.
  ///
  /// In en, this message translates to:
  /// **'Same sign — strong mirroring; may amplify both shared strengths and shared blind spots.'**
  String get alignmentExplainAspectConjunction;

  /// No description provided for @alignmentExplainAspectSemisextile.
  ///
  /// In en, this message translates to:
  /// **'30° apart — neighboring but distinct; small adjustments smooth communication.'**
  String get alignmentExplainAspectSemisextile;

  /// No description provided for @alignmentExplainAspectSextile.
  ///
  /// In en, this message translates to:
  /// **'60° apart — gentle resonance; opportunities arise easily when collaborating.'**
  String get alignmentExplainAspectSextile;

  /// No description provided for @alignmentExplainAspectSquare.
  ///
  /// In en, this message translates to:
  /// **'90° apart — natural tension that drives growth; learn to compromise.'**
  String get alignmentExplainAspectSquare;

  /// No description provided for @alignmentExplainAspectTrine.
  ///
  /// In en, this message translates to:
  /// **'120° apart — most harmonious flow; mutual support feels effortless.'**
  String get alignmentExplainAspectTrine;

  /// No description provided for @alignmentExplainAspectQuincunx.
  ///
  /// In en, this message translates to:
  /// **'150° apart — feels off-rhythm; needs patience and flexibility.'**
  String get alignmentExplainAspectQuincunx;

  /// No description provided for @alignmentExplainAspectOpposition.
  ///
  /// In en, this message translates to:
  /// **'180° apart — opposites that balance each other and reflect what\'s missing.'**
  String get alignmentExplainAspectOpposition;

  /// No description provided for @alignmentExplainBondRomanticGood.
  ///
  /// In en, this message translates to:
  /// **'Romantic bond between complementary elements — emotion and energy intertwine easily.'**
  String get alignmentExplainBondRomanticGood;

  /// No description provided for @alignmentExplainBondRomanticOk.
  ///
  /// In en, this message translates to:
  /// **'Romantic bond needs investment in shared language; differences become material for growth.'**
  String get alignmentExplainBondRomanticOk;

  /// No description provided for @alignmentExplainBondFriendshipGood.
  ///
  /// In en, this message translates to:
  /// **'Friendship with an Air element — open communication, easy idea-sharing.'**
  String get alignmentExplainBondFriendshipGood;

  /// No description provided for @alignmentExplainBondFriendshipOk.
  ///
  /// In en, this message translates to:
  /// **'Friendship needs time to build trust and ease.'**
  String get alignmentExplainBondFriendshipOk;

  /// No description provided for @alignmentExplainBondSoulGood.
  ///
  /// In en, this message translates to:
  /// **'Soul resonance with Water depth — strong emotional and intuitive connection.'**
  String get alignmentExplainBondSoulGood;

  /// No description provided for @alignmentExplainBondSoulOk.
  ///
  /// In en, this message translates to:
  /// **'Soul resonance takes time for both sides to open up and listen.'**
  String get alignmentExplainBondSoulOk;

  /// No description provided for @alignmentExplainBondKinshipGood.
  ///
  /// In en, this message translates to:
  /// **'Kinship grounded in Earth/Water — durable, warm, strengthens over time.'**
  String get alignmentExplainBondKinshipGood;

  /// No description provided for @alignmentExplainBondKinshipOk.
  ///
  /// In en, this message translates to:
  /// **'Kinship needs clear boundaries and respect for personal space.'**
  String get alignmentExplainBondKinshipOk;

  /// No description provided for @chartTitle.
  ///
  /// In en, this message translates to:
  /// **'Birth Chart'**
  String get chartTitle;

  /// No description provided for @chartDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get chartDateLabel;

  /// No description provided for @chartTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get chartTimeLabel;

  /// No description provided for @chartNoStars.
  ///
  /// In en, this message translates to:
  /// **'No stars'**
  String get chartNoStars;

  /// No description provided for @chartClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get chartClose;

  /// No description provided for @chartHouseMenh.
  ///
  /// In en, this message translates to:
  /// **'Mệnh'**
  String get chartHouseMenh;

  /// No description provided for @chartHousePhuMau.
  ///
  /// In en, this message translates to:
  /// **'Phụ Mẫu'**
  String get chartHousePhuMau;

  /// No description provided for @chartHousePhuDuc.
  ///
  /// In en, this message translates to:
  /// **'Phúc Đức'**
  String get chartHousePhuDuc;

  /// No description provided for @chartHouseDienTrach.
  ///
  /// In en, this message translates to:
  /// **'Điền Trạch'**
  String get chartHouseDienTrach;

  /// No description provided for @chartHouseQuanLoc.
  ///
  /// In en, this message translates to:
  /// **'Quan Lộc'**
  String get chartHouseQuanLoc;

  /// No description provided for @chartHouseNoBoc.
  ///
  /// In en, this message translates to:
  /// **'Nô Bộc'**
  String get chartHouseNoBoc;

  /// No description provided for @chartHouseThienDi.
  ///
  /// In en, this message translates to:
  /// **'Thiên Di'**
  String get chartHouseThienDi;

  /// No description provided for @chartHouseTatAch.
  ///
  /// In en, this message translates to:
  /// **'Tật Ách'**
  String get chartHouseTatAch;

  /// No description provided for @chartHouseTaiBach.
  ///
  /// In en, this message translates to:
  /// **'Tài Bạch'**
  String get chartHouseTaiBach;

  /// No description provided for @chartHouseTuTuc.
  ///
  /// In en, this message translates to:
  /// **'Tử Tức'**
  String get chartHouseTuTuc;

  /// No description provided for @chartHousePhuThe.
  ///
  /// In en, this message translates to:
  /// **'Phu Thê'**
  String get chartHousePhuThe;

  /// No description provided for @chartHouseHuynhDe.
  ///
  /// In en, this message translates to:
  /// **'Huynh Đệ'**
  String get chartHouseHuynhDe;

  /// No description provided for @imperialPickDate.
  ///
  /// In en, this message translates to:
  /// **'CHOOSE BIRTH DATE'**
  String get imperialPickDate;

  /// No description provided for @imperialPickHour.
  ///
  /// In en, this message translates to:
  /// **'CHOOSE BIRTH HOUR'**
  String get imperialPickHour;

  /// No description provided for @cosmicEchoCount.
  ///
  /// In en, this message translates to:
  /// **'{count} echoes'**
  String cosmicEchoCount(int count);

  /// No description provided for @cosmicListening.
  ///
  /// In en, this message translates to:
  /// **'listening...'**
  String get cosmicListening;

  /// No description provided for @soulBfiSubtitle.
  ///
  /// In en, this message translates to:
  /// **'EXPLORE YOUR SOUL · BFI-44'**
  String get soulBfiSubtitle;

  /// No description provided for @soulBfiResultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'BFI-44 RESULTS'**
  String get soulBfiResultSubtitle;

  /// No description provided for @soulBfiRetake.
  ///
  /// In en, this message translates to:
  /// **'RETAKE TEST'**
  String get soulBfiRetake;

  /// No description provided for @soulBfiQuote.
  ///
  /// In en, this message translates to:
  /// **'\"Begin the journey of soul discovery.\nAnswer 44 questions.\"'**
  String get soulBfiQuote;

  /// No description provided for @soulQuestionsCount.
  ///
  /// In en, this message translates to:
  /// **'{total} questions'**
  String soulQuestionsCount(int total);

  /// No description provided for @soulQuestionsFixed.
  ///
  /// In en, this message translates to:
  /// **'44 questions'**
  String get soulQuestionsFixed;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @oracleAiDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'AI-generated content · For entertainment purposes only'**
  String get oracleAiDisclaimer;

  /// No description provided for @soulEntertainmentDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This test is for entertainment and self-reflection only. It is not a clinically validated psychological assessment.'**
  String get soulEntertainmentDisclaimer;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyPolicyBody.
  ///
  /// In en, this message translates to:
  /// **'Mystic Cosmos collects your name and birth date solely to perform astrology calculations on your device. This data is never stored on our servers or shared with third parties.\n\nWhen you use the Oracle AI Chat feature, your question and zodiac sign are sent to our secure server (Supabase) and processed by Google Gemini AI to generate a response. No personally identifiable information is retained after the session ends.\n\nWe use app preferences (theme, language) stored locally on your device via standard iOS mechanisms.\n\nThis app does not use advertising, analytics tracking, or any third-party tracking SDKs.\n\nFor questions, contact us via the Settings screen.'**
  String get privacyPolicyBody;

  /// No description provided for @termsBody.
  ///
  /// In en, this message translates to:
  /// **'Mystic Cosmos is an astrology and divination app for entertainment and personal reflection. All readings, analyses, and AI-generated content are for entertainment purposes only and do not constitute professional medical, financial, legal, or psychological advice. Do not rely on these readings for important life decisions; consult qualified professionals for serious matters.\n\nPersonality assessments (Big Five, Enneagram) are provided for self-exploration only and are not clinically validated instruments. The Big Five questions are adapted from the Big Five Inventory (BFI-44) by John, Donahue & Kentle (1991), used here for educational and entertainment purposes.\n\nWe reserve the right to update these terms at any time. Continued use of the app constitutes acceptance of the updated terms.'**
  String get termsBody;

  /// No description provided for @imperialDetailedAnalysisCta.
  ///
  /// In en, this message translates to:
  /// **'DETAILED ANALYSIS'**
  String get imperialDetailedAnalysisCta;

  /// No description provided for @imperialAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'DETAILED ANALYSIS'**
  String get imperialAnalysisTitle;

  /// No description provided for @imperialAnalysisSubtitle.
  ///
  /// In en, this message translates to:
  /// **'AI-INTERPRETED IMPERIAL CHART'**
  String get imperialAnalysisSubtitle;

  /// No description provided for @imperialAnalysisDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'AI-generated reflective interpretation · For entertainment and self-discovery only'**
  String get imperialAnalysisDisclaimer;

  /// No description provided for @imperialAnalysisLoading.
  ///
  /// In en, this message translates to:
  /// **'Interpreting your chart...'**
  String get imperialAnalysisLoading;

  /// No description provided for @imperialAnalysisError.
  ///
  /// In en, this message translates to:
  /// **'Could not generate analysis'**
  String get imperialAnalysisError;

  /// No description provided for @imperialAnalysisRetry.
  ///
  /// In en, this message translates to:
  /// **'TRY AGAIN'**
  String get imperialAnalysisRetry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
