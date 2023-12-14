import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gostream_application/anotherMain.dart';
import 'package:gostream_application/pages/user_profile.dart';
import 'package:gostream_application/models/movie_user.dart';
import 'package:gostream_application/service/koneksi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.black54),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        // Add other routes as needed
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  ApiService _apiService = ApiService(); // Make sure ApiService is imported

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  try {
                    List<MovieUser>? users = await _apiService.getProfiles();
                    if (users != null) {
                      // Check if the entered username and password match any MovieUser
                      MovieUser? user = users.firstWhereOrNull(
                        (MovieUser user) =>
                            user.username == username &&
                            user.password == password,
                      );

                      if (user != null) {
                        // If a matching user is found, navigate to the home screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyApp2(username: user.username),
                          ),
                        );
                      } else {
                        // If no matching user is found, show an error dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Login Gagal"),
                              content: Text("Username atau password salah."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  } catch (e) {
                    print("Error: $e");
                    // Handle error fetching data from the API
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              // TextButton(
              //   onPressed: () {
              //     // Navigasi ke halaman pendaftaran
              //     Navigator.pushReplacementNamed(
              //       context,
              //       '/register',
              //     );
              //   },
              //   child: Text(
              //     "Belum punya akun? Daftar disini",
              //     style: TextStyle(
              //       color: Colors.white,
              //       decoration: TextDecoration.underline,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
