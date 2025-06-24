// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethod {
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance
        .collection('Blogs')
        .add(blogData)
        .catchError((e) {
      // ignore: invalid_return_type_for_catch_error
      return e.toString();
    });
  }
}
