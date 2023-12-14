import 'package:flutter/material.dart';
import 'package:gostream_application/models/movie_user.dart';
import 'package:gostream_application/service/koneksi.dart';

class ProfileScreen extends StatefulWidget {
  final String? username;

  ProfileScreen({required this.username});

  @override
  _ProfileScreenState createState() => _ProfileScreenState(username: username);
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  final String? username;
  MovieUser? user;
  late ApiService service;

  _ProfileScreenState({required this.username});

  @override
  void initState() {
    super.initState();
    service = ApiService();
    initialize();
  }

  Future<void> initialize() async {
    try {
      // Fetch user data and handle potential errors
      user = await service.getUserByUsername(username!);
      if (user == null) {
        // Handle user not found, show a message, or navigate back
      }
    } catch (e) {
      // Handle other potential errors (e.g., network issues)
    } finally {
      // Always update the UI, even if there's an error
      setState(() {
        isLoading = true; // Set loading to true when starting the data fetching
      });
      setState(() {
        user = user;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "GoStream",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.redAccent.shade700,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    // Display user profile picture or icon
                    radius: 50,
                    backgroundImage: NetworkImage(user!.image),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Name: ${user!.fullname}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Email: ${user!.email}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Phone Number: ${user!.noHp}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Country: ${user!.country}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  // Add more profile information widgets here as needed
                ],
              ),
            ),
          );
  }
}
