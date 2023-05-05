import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Fitpocket/db/share_pref.dart';
// import 'package:Fitpocket/child/bottom_screens/child_home_page.dart';
import 'package:Fitpocket/child/child_login_screen.dart';
import 'package:Fitpocket/parent/parent_home_screen.dart';
import 'package:Fitpocket/utils/constants.dart';
import 'child/bottom_page.dart';
import 'new/core/const/color_constants.dart';
import 'new/screens/onboarding/page/onboarding_page.dart';
import 'new/screens/tab_bar/page/tab_bar_page.dart';
import 'new/screens/workouts/page/workouts_page.dart';

final navigatorkey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPrefference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Fitness',
    //   theme: ThemeData(
    //     textTheme: TextTheme(bodyText1: TextStyle(color: ColorConstants.textColor)),
    //     fontFamily: 'NotoSansKR',
    //     scaffoldBackgroundColor: Colors.white,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   home: isLoggedIn ? WorkoutsPage() : OnboardingPage(),
    // );z
    return MaterialApp(
      title: 'Flutter Demo',
      // scaffoldMessengerKey: navigatorkey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: MySharedPrefference.getUserType(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == "") {
            return LoginScreen();
          }
          if (snapshot.data == "child") {
            return BottomPage();
          }
          if (snapshot.data == "parent") {
            return ParentHomeScreen();
          }

          return progressIndicator(context);
        },
      ),
    );
  }
}

class CheckAuth extends StatelessWidget {
  // const CheckAuth({Key? key}) : super(key: key);

  checkData() {
    if (MySharedPrefference.getUserType() == 'parent') {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}