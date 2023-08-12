import 'package:dartz/dartz.dart';
import 'package:schedulle_app/domain/entities/request.dart';

import '../repositories/request_repos.dart';

class AddRequest {
  final RequestRepos repos;

  AddRequest({required this.repos});

  Future<Either<String, String>> execute(Request request) async {
    return repos.addRequest(request);
  }
}
