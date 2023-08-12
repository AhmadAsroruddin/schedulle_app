import 'package:equatable/equatable.dart';

class Request extends Equatable {
  const Request(
      {required this.penerima, required this.pengirim, required this.status});

  final String penerima;
  final String pengirim;
  final String status;

  @override
  List<Object> get props => [penerima, pengirim, status];
}
