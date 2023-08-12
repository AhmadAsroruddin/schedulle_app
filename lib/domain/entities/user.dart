import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Users extends Equatable {
  Users({
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.friends
  });

  String username;
  String email;
  String imageUrl;
  List<String> friends;
  @override
  List<Object?> get props => [username, email, imageUrl, friends];
}
