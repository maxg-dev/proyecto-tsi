import 'package:cliente_nebu_pos/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyC_MJErTQSEmjWQMwNS3_p4fSoESGekVSQ",
    appId: "1:439539492915:web:93da2a3dd1271b4d839b46",
    messagingSenderId: "439539492915",
    projectId: "tsi-nebupos-project",
    storageBucket: "tsi-nebupos-project.appspot.com",
    authDomain: "tsi-nebupos-project.firebaseapp.com",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [const Locale('es')],
      debugShowCheckedModeBanner: false,
      title: 'Nebu pos',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AuthService().handleAuthState(),
    );
  }
}
