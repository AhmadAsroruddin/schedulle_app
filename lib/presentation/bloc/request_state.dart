part of 'request_bloc.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestSuccess extends RequestState {
  final String message;

  RequestSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class RequestError extends RequestState {
  final String message;
  RequestError({required this.message});

  @override
  List<Object> get props => [];
}
