import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // <-- IMPORT OBBLIGATORIO PER LE LINGUE

import 'l10n/app_localizations.dart';
import 'screens/main_wrapper.dart';     
import 'screens/onboarding_screen.dart'; 
import 'providers/app_providers.dart';   

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: SoberTrackApp(),
    ),
  );
}

class SoberTrackApp extends ConsumerWidget {
  const SoberTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return MaterialApp(
      title: 'SoberTrack',
      debugShowCheckedModeBanner: false,
      
      // --- MAGIA DELLE LINGUE QUI ---
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Inglese
        Locale('it', ''), // Italiano
      ],
      // ------------------------------

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        
        colorScheme: ColorScheme.light(
          primary: Colors.orange[600]!,       
          onPrimary: Colors.white,
          secondary: Colors.orange[400]!,
          surface: Colors.white,
          onSurface: Colors.grey[900]!,       
          outline: Colors.grey[300],          
        ),
        
        cardTheme: CardThemeData(
          color: Colors.grey[50],             
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
        ),
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      home: user.isOnboarded ? const MainWrapper() : const OnboardingScreen(), 
    );
  }
}