import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedulle_app/domain/repositories/auth_repos.dart';

class GetUser {
  final AuthRepos repos;
  GetUser({required this.repos});

  Stream<QuerySnapshot> execute(String uid) {
    final result = repos.getUser(uid);
    return result;
  }
}
