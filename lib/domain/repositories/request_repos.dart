import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../entities/request.dart';

abstract class RequestRepos {
  Future<Either<String, String>> addRequest(Request request);
  Stream<QuerySnapshot> getRequest(String uid);
}
