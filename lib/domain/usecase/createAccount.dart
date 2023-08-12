import 'package:dartz/dartz.dart';
import 'package:schedulle_app/domain/repositories/auth_repos.dart';

class CreateAccount {
  final AuthRepos repos;

  CreateAccount({required this.repos});

  Future<Either<String, String>> execute(String email, String password, String name) {
    return repos.createAccount(email, password, name);
  }
}
