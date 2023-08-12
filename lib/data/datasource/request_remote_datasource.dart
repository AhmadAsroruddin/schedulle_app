import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedulle_app/data/models/request_model.dart';

abstract class RequestRemote {
  Future<void> addRequest(RequestModel requestModel);
}

class RequestRemoteImpl extends RequestRemote {
  CollectionReference collection =
      FirebaseFirestore.instance.collection("request");

  @override
  Future<void> addRequest(RequestModel data) async {
    return await collection
        .add(data.toMap())
        .then((value) => print(value))
        .catchError((e) => print(e));
  }

  
}
