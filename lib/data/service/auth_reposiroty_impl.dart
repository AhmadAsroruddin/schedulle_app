import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:schedulle_app/data/datasource/auth_remote_datasource.dart';
import 'package:schedulle_app/domain/repositories/auth_repos.dart';

class AuthReposImpl implements AuthRepos {
  final AuthRemoteDataSource authRemoteDataSource;
  final FirebaseFirestore firebaseFirestore;

  AuthReposImpl(
      {required this.authRemoteDataSource, required this.firebaseFirestore});

  @override
  Future<Either<String, String>> createAccount(
      String email, String password, String name) async {
    try {
      await authRemoteDataSource.createUser(email, password, name);
      return const Right("Your Account Created");
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, String>> login(String email, String password) async {
    try {
      await authRemoteDataSource.login(email, password);
      return const Right("Success");
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, String>> logout() async {
    try {
      await authRemoteDataSource.logout();
      return const Right("Logout Success");
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Stream<QuerySnapshot> getUser(String key) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('username', isEqualTo: key)
        .snapshots();
  }
}
