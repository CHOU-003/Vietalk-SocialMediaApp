import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/controllers/auth_provider.dart';
import 'package:social_media_app/controllers/expandedText_provider.dart';
import 'package:social_media_app/controllers/navigation_provider.dart';
import 'package:social_media_app/controllers/post_provider.dart';
import 'package:social_media_app/controllers/theme_provider.dart';
import 'package:social_media_app/views/auth/login_screen.dart';
import 'package:social_media_app/views/home/dashboard.dart';

void main() {
  runApp(const MyApp());

  //chau@gmail.com
  //abc789
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokens = prefs.getString("token");
    return tokens == null ? false : true;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authprovider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => ExpandedtextProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fingering',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            themeMode: themeProvider.themeMode,
            home: FutureBuilder<bool>(
              future: isUserLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return snapshot.data! ? Dashboard() : Loginscreen();
                }
                return Loginscreen();
              },
            ),

            // Loginscreen(),
          );
        },
      ),
    );
  }
}
