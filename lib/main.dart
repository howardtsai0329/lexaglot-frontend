import 'package:flutter/material.dart';
import 'package:lexaglot/constants/routes.dart';
import 'package:lexaglot/database/fetch_user_detail.dart';
// import 'package:lexaglot/database/fetch_user_detail.dart';
// import 'package:lexaglot/database/login.dart';
import 'package:lexaglot/utilities/providers/theme_provider.dart';
import 'package:lexaglot/views/home_page_view.dart';
import 'package:lexaglot/views/login_view.dart';
import 'package:lexaglot/views/register_view.dart';
import 'package:lexaglot/views/start_menu_view.dart';
import 'package:lexaglot/views/verify_email_view.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        startMenuRoute: (context) => const StartMenuView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        matchingPairsRoute: (context) => const Scaffold(),
        homePageRoute: (context) => const HomePageView(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<UserDetail?> _fetchUser() async {
    try {
      final userDetail = await fetchUserDetail();
      return userDetail;
    } catch (e) {
      dev.log('Error fetching user: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetail?>(
      future: _fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return const LoginView(); // Redirect to login on error or null user.
        } else {
          return const HomePageView(); // Show home page if user is valid.
        }
      },
    );
  }
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MaterialApp(
//     title: 'Flutter Demo',
//     theme: ThemeData.dark(),
//     debugShowCheckedModeBanner: false,
//     home: const Test(),
//     routes: {
//       loginRoute: (context) => const LoginView(),
//       registerRoute: (context) => const RegisterView(),
//       startMenuRoute: (context) => const StartMenuView(),
//       verifyEmailRoute: (context) => const VerifyEmailView(),
//       matchingPairsRoute: (context) => const MatchingPairsView(),
//     },
//   ));
// }

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   late Future<UserDetail> futureUserDetail;

//   @override
//   void initState() {
//     super.initState();
//     testLogin();
//     futureUserDetail = fetchUserDetail();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fetch User Detail Example'),
//       ),
//       body: Center(
//         child: FutureBuilder<UserDetail>(
//           future: futureUserDetail,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               return Text(snapshot.data!.toString());
//             } else {
//               return const Text('No data available.');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
