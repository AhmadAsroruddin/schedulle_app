part of 'Auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthHasData extends AuthState {
  final String result;

  const AuthHasData(this.result);

  @override
  List<Object> get props => [result];
}

class UserHasData extends AuthState {
  final Users user;
  const UserHasData(this.user);
  @override
  List<Object> get props => [user];
}
