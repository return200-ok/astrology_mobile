/// App-level configuration loaded from compile-time environment.
///
/// Run / build with secrets injected from .env_prod:
///   flutter run --dart-define-from-file=.env_prod
///   flutter build apk --dart-define-from-file=.env_prod
///
/// .env_prod is gitignored — see .env.example for the required keys.
class AppConfig {
  const AppConfig._();

  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static void assertConfigured() {
    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      throw StateError(
        'Missing SUPABASE_URL / SUPABASE_ANON_KEY. '
        'Run with: flutter run --dart-define-from-file=.env_prod',
      );
    }
  }
}
