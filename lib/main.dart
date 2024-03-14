import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meatingless/routing/router.dart';
import 'package:meatingless/services/database.dart';
import 'package:meatingless/variables/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:payu/payu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env["STRIPE_API_KEY"]!;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Payu.pos = const POS(id: '385627');
  Payu.environment = Environment.sandbox;
  await initDatabase();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.nunitoSansTextTheme().apply(),
            colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.secondaryColor,
                background: AppColors.backgroundColor)),
        routerConfig: router,
      ),
    );
  }
}
