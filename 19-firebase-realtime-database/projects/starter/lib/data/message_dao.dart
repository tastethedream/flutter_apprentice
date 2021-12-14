import 'package:cloud_firestore/cloud_firestore.dart';
import 'message.dart';

class MessageDao {
  // 1
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('messages');
// TODO: Add saveMessage
  void saveMessage(Message message) {
    collection.add(message.toJson());
  }
// TODO: Add getMessageStream
  Stream<QuerySnapshot> getMessageStream() {
    return collection.snapshots();
  }


}
