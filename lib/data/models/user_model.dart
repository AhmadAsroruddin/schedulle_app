import 'package:equatable/equatable.dart';
import 'package:schedulle_app/domain/entities/user.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  UserModel({
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.friends
  });

  String username;
  String email;
  String imageUrl;
  List<String> friends;

  Map<String, dynamic> toMap() {
    return {'username': username, 'email': email, 'imageUrl': imageUrl, 'friends' : friends};
  }

  static Users fromMap(Map<String, dynamic> map) {
    return Users(
        username: map['username'],
        email: map['email'],
        imageUrl: map['imageUrl'],
        friends: map['friends']);
  }

  Users toEntity() {
    return Users(username: username, email: email, imageUrl: imageUrl, friends: friends);
  }

  @override
  List<Object?> get props => [username, email, imageUrl, friends];
}
