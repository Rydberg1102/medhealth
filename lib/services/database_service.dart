import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medhealth/model/todo.dart';

const String TODO_COLLECTION_REF = "category_product";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _category_productRef;

  DatabaseService() {
    _category_productRef =
        _firestore.collection(TODO_COLLECTION_REF).withConverter<Todo>(
            fromFirestore: (snapshots, _) => Todo.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (todo, _) => todo.toJson());
  }

  Stream<QuerySnapshot> getCategory() {
    return _category_productRef.snapshots();
  }

  void addCategory(Todo todo) async {
    _category_productRef.add(todo);
  }
}
