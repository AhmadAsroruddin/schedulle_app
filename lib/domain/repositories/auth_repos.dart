import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepos {
  Future<Either<String, String>> createAccount(
      String email, String password, String name);
  Future<Either<String, String>> login(String email, String password);
  Future<Either<String, String>> logout();
  Stream<QuerySnapshot> getUser(String uid);
}
