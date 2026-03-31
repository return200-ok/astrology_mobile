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
  /// **'ORACLE RESPONSE'**
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

  /// No description provided for @oracleSoulPanelHeader.
  ///
  /// In en, this message translates to:
  /// **'SOUL_REVELATION_V4.2'**
  String get oracleSoulPanelHeader;

  /// No description provided for @oracleEssence.
  ///
  /// In en, this message translates to:
  /// **'ESSENCE'**
  String get oracleEssence;

  /// No description provided for @oracleSpiritualFlow.
  ///
  /// In en, this message translates to:
  /// **'SPIRITUAL FLOW'**
  String get oracleSpiritualFlow;

  /// No description provided for @oracleDrawnTo.
  ///
  /// In en, this message translates to:
  /// **'DRAWN TO'**
  String get oracleDrawnTo;

  /// No description provided for @oracleRadiatesTo.
  ///
  /// In en, this message translates to:
  /// **'RADIATES TO'**
  String get oracleRadiatesTo;

  /// No description provided for @oracleDharmaPath.
  ///
  /// In en, this message translates to:
  /// **'DHARMA PATH'**
  String get oracleDharmaPath;

  /// No description provided for @oracleSacredNeeds.
  ///
  /// In en, this message translates to:
  /// **'SACRED NEEDS'**
  String get oracleSacredNeeds;

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
  /// **'SOUL ARCHETYPE FOUND'**
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
