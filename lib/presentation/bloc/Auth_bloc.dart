import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:schedulle_app/domain/usecase/createAccount.dart';
import 'package:schedulle_app/domain/usecase/getUser.dart';
import 'package:schedulle_app/domain/usecase/logout.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecase/login.dart';

part 'Auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final CreateAccount _createAccount;
  final Login _login;
  final Logout _logout;
  final GetUser _getUser;

  final _dataController = StreamController<QuerySnapshot>();

  Stream<QuerySnapshot> get dataStream => _dataController.stream;

  AuthCubit(this._createAccount, this._login, this._logout, this._getUser)
      : super(AuthInitial());
  Future<void> create(String email, String password, String name) async {
    final result = await _createAccount.execute(email, password, name);

    result.fold((failure) {
      emit(
        AuthError(failure),
      );
    }, (data) {
      emit(AuthHasData(data));
    });
  }

  Future<void> login(String email, String password) async {
    final result = await _login.execute(email, password);

    result.fold((failure) {
      emit(
        AuthError(failure),
      );
    }, (data) {
      emit(
        AuthHasData(data),
      );
    });
  }

  void logout() async {
    final result = await _logout.execute();

    result.fold((failure) {
      emit(
        AuthError(failure),
      );
    }, (data) {
      emit(
        AuthHasData(data),
      );
    });
  }

  Future<void> getUser(String uid) async {
    _getUser.execute(uid).listen((event) {
      _dataController.add(event);
    });
  }

  void dispose() {
    _dataController.close();
  }
}
