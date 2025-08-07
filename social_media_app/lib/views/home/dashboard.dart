import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/navigation_provider.dart';
import 'package:social_media_app/views/friends/friends_Screen.dart';
import 'package:social_media_app/views/home/home_feeds.dart';
import 'package:social_media_app/views/home/posts/create_newpost.dart';
import 'package:social_media_app/views/profile/profile_Screen.dart';
import 'package:social_media_app/views/settings/settings_Screen.dart';
import 'package:social_media_app/controllers/theme_provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationbarProvider = Provider.of<NavigationProvider>(context);
    final theme = Theme.of(context);
    final pages = [
      HomeFeedScreen(),
      FriendsScreen(),
      ProfileScreen(),
      SettingsScreen(),
    ];
    final titles = ['VIETALK', 'friend List', 'profiles', 'settings'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        title: Text(
          titles[navigationbarProvider.currentIndex],
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
              return IconButton(
                icon: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: theme.iconTheme.color,
                ),
                onPressed: () {
                  themeProvider.toggleTheme(!isDarkMode);
                },
              );
            },
          ),
          SizedBox(width: 12), // khoảng cách phải
        ],
      ),
      body: SafeArea(child: pages[navigationbarProvider.currentIndex]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostCreationScreen()),
          );
        },
        backgroundColor: Colors.purpleAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 9),
        child: BottomNavigationBar(
          currentIndex: navigationbarProvider.currentIndex,
          onTap: (index) => navigationbarProvider.setIndex(index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Friend"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
