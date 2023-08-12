import 'package:dartz/dartz.dart';
import 'package:schedulle_app/domain/repositories/auth_repos.dart';

class Logout {
  final AuthRepos repos;

  Logout({required this.repos});

  Future<Either<String, String>> execute() {
    return repos.logout();
  }
}
