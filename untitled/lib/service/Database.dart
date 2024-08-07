// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DatabaseMethods{
//   Future addEmployeeDetails(Map<String,dynamic> employeeInfoMap, String id) async{
//     return await FirebaseFirestore.instance
//         .collection(("Employee")
//         .doc(id)
//         .set(employeeInfoMap);
//   }
// }



// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DatabaseMethods {
//   Future<void> addEmployeeDetails(Map<String, dynamic> employeeInfoMap, String id) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("Employee")  // Correct collection reference
//           .doc(id)
//           .set(employeeInfoMap);
//     } catch (e) {
//       print("Error adding employee details: $e");
//       // Handle error as needed
//     }
//     Stream<QuerySnapshot> getEmployeeDetailsStream() {
//       return FirebaseFirestore.instance.collection("Employee").snapshots();
//     }
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addEmployeeDetails(Map<String, dynamic> employeeInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("Employee")
          .doc(id)
          .set(employeeInfoMap);
    } catch (e) {
      print("Error adding employee details: $e");
      // Handle error as needed
    }
  }
  Stream<QuerySnapshot> getEmployeeDetails() {
    return FirebaseFirestore.instance.collection("Employee").snapshots();
  }
  Future updateEmployeeDetail(Stream id,Map<String,dynamic> updateInfo) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id as String?).update(updateInfo);
  }
}
