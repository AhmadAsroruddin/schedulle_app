import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedulle_app/domain/usecase/addRequest.dart';
import 'package:schedulle_app/domain/usecase/getRequest.dart';

import '../../domain/entities/request.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  final AddRequest _addRequest;
  final GetRequest _getRequest;

  RequestCubit(this._addRequest, this._getRequest) : super(RequestInitial());

  final _dataController = StreamController<QuerySnapshot>();

  Stream<QuerySnapshot> get dataStream => _dataController.stream;

  Future<void> addRequest(Request request) async {
    final result = await _addRequest.execute(request);

    result.fold(
      (failure) => {
        emit(
          RequestError(message: failure),
        ),
      },
      (r) => {
        emit(
          RequestSuccess(message: r),
        ),
      },
    );
  }

  Future<void> getRequest(String uid) async {
    final result = _getRequest.execute(uid);

    result.listen((data) {
      _dataController.add(data);
    });
  }
  void dispose() {
    _dataController.close();
  }
}
