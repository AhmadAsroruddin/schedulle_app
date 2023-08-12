import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedulle_app/data/datasource/request_remote_datasource.dart';
import 'package:schedulle_app/data/models/request_model.dart';
import 'package:schedulle_app/domain/repositories/request_repos.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/request.dart';

class RequestReposImpl extends RequestRepos {
  RequestReposImpl({required this.requestRemote});

  final RequestRemote requestRemote;
  @override
  Future<Either<String, String>> addRequest(Request request) async {
    try {
      await requestRemote.addRequest(RequestModel.fromEntity(request));
      return const Right("Request Successfully Sent");
    } catch (e) {
      return const Left("Request Unsuccessfully Sent");
    }
  }

  @override
  Stream<QuerySnapshot> getRequest(String uid) {
    return FirebaseFirestore.instance
        .collection("request")
        .where('penerima', isEqualTo: uid)
        .snapshots();
  }
}
