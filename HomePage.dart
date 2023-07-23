import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_to_app/Models/DatabaseNote.dart';
import 'package:to_to_app/Screens/AddTaskScreen.dart';
import 'package:to_to_app/Screens/CalenderScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseNote.getNotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xffEFEDF4),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70),bottomRight: Radius.circular(70)),
              image: DecorationImage(
                image: ExactAssetImage("assets/back.png"),
                fit: BoxFit.cover,
              )
            ),
          ),
          SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 10,left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(Icons.calendar_today,color: Colors.white,size: 26,),
                              onPressed: (){
                                DatabaseNote.getNotesOfDay(DateFormat.yMd().format(DateTime.now()), 0);
                                Get.to(CalenderScreen());
                              }
                          ),
                          IconButton(
                              icon: Icon(Icons.add_box_outlined,color: Colors.white,size: 28,),
                              onPressed: (){
                                Get.to(AddTask());
                                DatabaseNote.getNotes();
                                print(DatabaseNote.notesListe[0].title);
                              }
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text("Tasks",
                      style: TextStyle(color: Colors.white,fontSize: 35),
                      ),
                    ),
                    SizedBox(height: 40,),
                    Flexible(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: DatabaseNote.notesListe.length,
                          itemBuilder: (context,int index){
                            return Container(
                              margin: EdgeInsets.only(top: 10,right: 30,left: 30,bottom: 10),
                              //height: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                    blurRadius: 5,
                                  ),
                                ]
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 20,bottom: 15,right: 25,left: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.note_rounded,color: Color(0xff9A7FDD),),
                                        SizedBox(width: 8,),
                                        Text(DatabaseNote.notesListe[index].title,
                                          style: TextStyle(fontSize: 20,),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Row(
                                      children: [
                                        Icon(Icons.timer_sharp,color: Color(0xff9A7FDD),),
                                        SizedBox(width: 8,),
                                        Text(DatabaseNote.notesListe[index].time,
                                          style: TextStyle(fontSize: 16,),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(DatabaseNote.notesListe[index].date,
                                          style: TextStyle(color: Colors.grey[700]),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Get.bottomSheet(
                                              Container(
                                                height: 230,
                                                color: Colors.white,
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 20,),
                                                    /**** Completed button ****/
                                                    DatabaseNote.notesListe[index].isCompleted==1?Container():
                                                    GestureDetector(
                                                      onTap: (){
                                                        DatabaseNote.updateNote(DatabaseNote.notesListe[index]);
                                                       setState(() {
                                                         DatabaseNote.getNotes();
                                                       });

                                                       // Get.back();
                                                        Get.back();
                                                        DatabaseNote.getNotes();
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 300,
                                                        decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: Center(
                                                          child: Text("Completed",
                                                            style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    /**** Delete Button ****/
                                                    GestureDetector(
                                                      onTap: (){
                                                        DatabaseNote.deleteNote(DatabaseNote.notesListe[index]);
                                                        setState(() {
                                                          DatabaseNote.getNotes();
                                                        });
                                                        //Get.back();
                                                        Get.back();
                                                        DatabaseNote.getNotes();
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 300,
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: Center(
                                                          child: Text("Delete",
                                                            style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 40,),
                                                    /**** Cancel Button ****/
                                                    GestureDetector(
                                                      onTap: (){
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 300,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15),
                                                          border: Border.all(width: 1,color: Colors.grey[800]),
                                                        ),
                                                        child: Center(
                                                          child: Text("Cancel",
                                                            style: TextStyle(fontSize: 20,color: Colors.grey[800],fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 33,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              color: DatabaseNote.notesListe[index].isCompleted==0?Color(0xff9A7FDD):Colors.green,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                                child: Text(DatabaseNote.notesListe[index].isCompleted==0?"To do":"Completed",
                                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16),
                                                ),
                                            ),

                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),

    );
  }
}
