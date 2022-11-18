import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';
import 'package:model_bottom/model/model.dart';

class UsersScreen extends GetView<UsersController> {
  static const pageId = "/UsersScreen";
  UserModel user = UserModel();

  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  Stream<DocumentSnapshot> getData() async* {
    FirebaseFirestore.instance
        .collection('users')
        .where("userId", isEqualTo: user.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Users")),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var userData = snapshot.data!.docs;
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            dataList("User Name : ",
                                userData[index].get('userName')),
                            dataList("email : ", userData[index].get('role')),
                            //dataList("email : ",  snapshot.data!.docs.map(user.toMap(user.))),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        );
                      })
                  : Container();
            }),
      ),
    );
  }

  Widget dataList(name, email) {
    return Padding(
      padding: const EdgeInsets.only(left: 85.0, top: 10, bottom: 4),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(name,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                )),
          ),
          Expanded(
            child: Text(
              email,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

// Widget dataList2(name, email) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 85.0, top: 10, bottom: 4),
//     child: Column(
//       // mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text(name,
//             textAlign: TextAlign.left,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.red,
//             )),
//         Text(
//           email,
//           textAlign: TextAlign.left,
//           style: const TextStyle(
//             fontSize: 15,
//             color: Colors.blue,
//           ),
//         ),
//       ],
//     ),
//   );
// }
}
