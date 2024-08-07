import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/pages/employee.dart';
import 'package:untitled/service/Database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController agecontroller = new TextEditingController();
  TextEditingController locationcontroller = new TextEditingController();
  late Stream<QuerySnapshot> employeeStream;

  @override
  void initState() {
    super.initState();
    getOnLoad();
  }

  Future<void> getOnLoad() async {
    employeeStream = DatabaseMethods().getEmployeeDetails();
    setState(() {});
  }

  Widget allEmployeeDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: employeeStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No employees found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Name : ${ds["Name"]}",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            namecontroller.text=ds["Name"];
                            agecontroller.text=ds["Age"];
                            locationcontroller.text=ds["Location"];
                            EditEmployeeDetail(ds["id"]);
                          },
                            child: Icon(Icons.edit,color: Colors.orange,))
                      ],
                    ),
                    Text(
                      "Age : ${ds["Age"]}",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Location: ${ds["Location"]}",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Employee()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter ",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Firebase ",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }
  // Future EditEmployeeDetail(String id) => showDialog(context: context, builder: (context)=>AlertDialog(
  //   content: Container(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             GestureDetector(
  //               onTap: (){
  //                 Navigator.pop(context);
  //               },
  //               child: Icon(Icons.cancel),),
  //             SizedBox(width: 60.0),
  //             Text(
  //               "Edit ",
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 fontSize: 24.0,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             Text(
  //               "Details ",
  //               style: TextStyle(
  //                 color: Colors.orange,
  //                 fontSize: 24.0,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],),
  //         SizedBox(height: 20.0,),
  //         Text("Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),),
  //         SizedBox(height: 20.0,),
  //         Container(
  //           padding: EdgeInsets.only(left: 5.0),
  //           decoration: BoxDecoration(
  //             border: Border.all(),
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           child: TextField(
  //             controller: namecontroller,
  //             decoration: InputDecoration(
  //                 border: InputBorder.none
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 20.0,),
  //         Text("Age",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),),
  //         SizedBox(height: 20.0,),
  //         Container(
  //           padding: EdgeInsets.only(left: 5.0),
  //           decoration: BoxDecoration(
  //             border: Border.all(),
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           child: TextField(
  //             controller: agecontroller,
  //             decoration: InputDecoration(
  //                 border: InputBorder.none
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 20.0,),
  //         Text("Location",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),),
  //         SizedBox(height: 20.0,),
  //         Container(
  //           padding: EdgeInsets.only(left: 5.0),
  //           decoration: BoxDecoration(
  //             border: Border.all(),
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           child: TextField(
  //             controller: locationcontroller,
  //             decoration: InputDecoration(
  //                 border: InputBorder.none
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 30.0,),
  //         Center(child: ElevatedButton(onPressed: (){
  //
  //         }, child: Text("Updata"),))
  //       ],
  //     ),
  //   ),
  // ));
  Future EditEmployeeDetail(String id) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Dismiss the dialog
                  },
                  child: Icon(Icons.cancel),
                ),
                SizedBox(width: 60.0),
                Text(
                  "Edit ",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Details ",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Text(
              "Name",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              "Age",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: agecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              "Location",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: locationcontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 30.0,),
            ElevatedButton(
              onPressed: () async{
                Map<String ,dynamic>updateInfo={
                  "Name":namecontroller.text,
                  "Age":agecontroller.text,
                  "Id":id,
                  "Location": locationcontroller.text,
                };
                await DatabaseMethods().updateEmployeeDetail(id as Stream, updateInfo).then((value) => Navigator.pop(context));
              }, child: Text("Update"),
            )
          ],
        ),
      ),
    ),
  );

}


