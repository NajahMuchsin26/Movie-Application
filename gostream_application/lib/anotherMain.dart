import 'package:flutter/material.dart';
import 'package:gostream_application/pages/movie_list.dart';
import 'package:gostream_application/pages/movie_category.dart';
import 'package:gostream_application/pages/movie_all.dart';
import 'package:gostream_application/pages/user_profile.dart';

class MyApp2 extends StatelessWidget {
  final String? username;

  MyApp2({required this.username});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.black54),
      initialRoute: '/home', // Change initialRoute to point to login screen
      routes: {
        '/home': (context) => MyHomePage(username: this.username),
        '/category': (context) => category(),
        '/user': (context) => ProfileScreen(username: this.username),
      },
      onUnknownRoute: (settings) {
        // Handle unknown routes
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('404 - Not Found'),
            ),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? username;

  MyHomePage({required this.username});

  @override
  _MyHomePageState createState() => _MyHomePageState(username: username);
}

class _MyHomePageState extends State<MyHomePage> {
  final String? username;

  _MyHomePageState({required this.username});

  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MovieList(),
      category(),
      MovieAll(),
      ProfileScreen(username: username),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.black87,
          ),
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
