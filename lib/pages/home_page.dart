import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasks/ui/general/colors.dart';
import 'package:tasks/ui/widgets/general_widget.dart';
import 'package:tasks/ui/widgets/textfield_search.dart';

class HomePage extends StatelessWidget {
  
  CollectionReference tasksReference = FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandSecondColor,
      floatingActionButton: InkWell(
        onTap: () {
          
        },
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: kBrandPrimaryColor,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add, color: Colors.white,),
              Text("Nueva tarea", style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.85),
                      blurRadius: 12,
                      offset: const Offset(4, 4),
                    ),
                  ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bienvenido, Ryoko", style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: kBrandPrimaryColor,
                        ),
                      ),
                
                    Text("Mis tareas", style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w600,
                      color: kBrandPrimaryColor,
                      ),
                    ),

                    divider10(),

                    TextFieldSearchWidget(),
                  ],
                ),
              ),
            ),

              Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
              "Todas mis tareas",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: kBrandPrimaryColor.withOpacity(0.85),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(4, 4),
                      blurRadius: 12.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: Color(0xff3E80FF),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        "Personal",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
                    divider3(),

                    Text(
                      "Lorem ipsum dolor sit amet",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: kBrandPrimaryColor.withOpacity(0.85),
                      ),
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, coonsectetur adipiscing alit, sed to eiusmod tempor incididunt",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: kBrandPrimaryColor.withOpacity(0.75),
                      ),
                    ),
                    divider6(),
                    Text(
                      "10/12/2022",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: kBrandPrimaryColor.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
     
    

      //body: StreamBuilder(
        //stream: tasksReference.snapshots(),
        //builder: (BuildContext context, AsyncSnapshot snap){
          //if(snap.hasData){
            //QuerySnapshot collection = snap.data;
            //List<QueryDocumentSnapshot> docs = collection.docs;
            //List<Map<String, dynamic>> docsMap = docs.map((e) => e.data() as Map<String, dynamic>).toList();
            //print(docsMap);
            //return ListView.builder(
              //itemCount: docsMap.length,
              //itemBuilder: (BuildContext contex, int index){
                //return ListTile(
                  //title: Text(docsMap[index]["title"]),
                //);
              //},
            //);
          //}
          //return Center(child: CircularProgressIndicator(),);
        //},
      //),

    
  }
}
