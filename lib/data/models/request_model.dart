import 'package:equatable/equatable.dart';
import 'package:schedulle_app/domain/entities/request.dart';

class RequestModel extends Equatable {
  const RequestModel(
      {required this.penerima, required this.pengirim, required this.status});

  final String penerima;
  final String pengirim;
  final String status;

  Map<String, dynamic> toMap() {
    return {'penerima': penerima, 'pengirim': pengirim, 'status': status};
  }

  factory RequestModel.fromEntity(Request request) => RequestModel(
        penerima: request.penerima,
        pengirim: request.pengirim,
        status: request.status,
      );

  @override
  List<Object> get props => [penerima, pengirim, status];
}
