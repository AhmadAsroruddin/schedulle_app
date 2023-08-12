import 'package:dartz/dartz.dart';
import 'package:schedulle_app/domain/repositories/auth_repos.dart';

class Login {
  final AuthRepos repos;

  Login({required this.repos});

  Future<Either<String, String>> execute(String email, String password) {
    return repos.login(email, password);
  }
}
