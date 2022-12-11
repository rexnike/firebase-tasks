
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks/model/task_model.dart';
import 'package:tasks/model/user_model.dart';

class MyServicesFireStore{

  String collection;
  MyServicesFireStore({required this.collection});

  late final CollectionReference _collectionReference = FirebaseFirestore.instance.collection(collection);

  //add
  Future<String> addTask(TaskModel model)async{
   DocumentReference documentReference = await _collectionReference.add({model.toJson()});
   String id = documentReference.id;
   return id;
  }

  Future<void> finishedTask(String tasksId)async{
    _collectionReference.doc(tasksId).update(
      {
        "Status": false,
      },
    );
  }

 Future<String> addUser(UserModel userModel)async{
 DocumentReference documentReference = await _collectionReference.add(userModel.ToJson());
 return documentReference.id;
  }

}


