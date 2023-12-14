import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gostream_application/models/movie_user.dart';

class ApiService {
  var client = http.Client();

  Future<List<MovieUser>?> getProfiles() async {
    var uri = Uri.parse('http://192.168.1.15:3000/users');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      // Decode the JSON response
      List<dynamic> jsonResponse = json.decode(response.body);

      // Convert the decoded JSON into a list of MovieUser objects
      List<MovieUser> users =
          jsonResponse.map((user) => MovieUser.fromJson(user)).toList();

      return users;
    } else {
      // Return null if the request fails
      return null;
    }
  }

  Future<MovieUser?> getUserByUsername(String username) async {
    var uri = Uri.parse('http://192.168.1.15:3000/users?username=$username');

    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          return MovieUser.fromJson(jsonResponse[0]);
        } else {
          print('User with username $username not found');
          return null;
        }
      } else {
        print('Failed to get user with username $username');
        return null;
      }
    } catch (e) {
      print('Error getting user by username: $e');
      return null;
    }
  }
}
