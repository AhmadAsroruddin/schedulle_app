import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:schedulle_app/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> createUser(String email, String password, String name);
  Future<void> login(String email, String password);
  Future<void> logout();
}

class AuthRemoteImpl implements AuthRemoteDataSource {
  @override
  Future<void> createUser(String email, String password, String name) async {
    UserCredential result =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    String photoUrl =
        "https://cdn.pixabay.com/photo/2023/05/21/07/47/horse-8008038_1280.jpg";
    User? user = result.user;
    user?.updateDisplayName(name);
    user?.updatePhotoURL(photoUrl);

    await FirebaseFirestore.instance.collection("users").doc(user!.uid).set(
            UserModel(
                username: name,
                email: email,
                imageUrl: photoUrl,
                friends: [
              'Lor7xbMxHAUoRNGNZydf64kqwZh1',
              '1PZ33emF7BeQJ1FeInelcmspjwY2'
            ]).toMap());

    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
