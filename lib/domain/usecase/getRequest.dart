import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedulle_app/domain/repositories/request_repos.dart';

class GetRequest {
  final RequestRepos repos;

  GetRequest({required this.repos});

  Stream<QuerySnapshot> execute(String uid) {
    final result = repos.getRequest(uid);

    return result;
  }
}
