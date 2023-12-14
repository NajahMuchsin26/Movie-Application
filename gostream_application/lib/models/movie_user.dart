import 'dart:convert';

class MovieUser {
  final String username;
  final String password;
  final String fullname;
  final String email;
  final String image;
  final String noHp;
  final String country;

  MovieUser({
    required this.username,
    required this.password,
    required this.fullname,
    required this.email,
    required this.image,
    required this.noHp,
    required this.country,
  });

  factory MovieUser.fromJson(Map<String, dynamic> json) {
    return MovieUser(
      username: json['username'],
      password: json['password'],
      fullname: json['fullname'],
      email: json['email'],
      image: json['image'],
      noHp: json['no_hp'],
      country: json['country'],
    );
  }
}
