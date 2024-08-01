import 'package:firebase_auth/firebase_auth.dart';
import 'package:waste_management/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:waste_management/pages/homepage.dart';
import 'package:waste_management/screens/loginpage.dart';
import 'package:waste_management/services/firebaseApi.dart';
// import 'package:waste_management/services/local_notifcation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await LocalNofications.init();

  await FirebaseApi().iniNotifcation();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
