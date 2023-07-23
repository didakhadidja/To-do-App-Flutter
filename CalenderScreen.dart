import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_to_app/Models/DatabaseNote.dart';
import 'package:to_to_app/Screens/AddTaskScreen.dart';

class CalenderScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  int couleur1=0xff9A7FDD;
  int bleu=0xff3b00ff;
  int back=0xffEFEDF4;
  int clair=0xffccccff;
  DateTime selecteDate=DateTime.now();
  CalendarController _controller=CalendarController();
  List<String> _types=["All","To do","Completed"];
  int _selectedType=0;

/***** List Of tasks Of day *****/
  _Body(DateTime date,int type){
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: DatabaseNote.notesListeOfDay.length,
          itemBuilder: (context,int index){
            return Container(
              margin: EdgeInsets.only(top: 10,right: 20,left: 20,bottom: 10),
              //height: 140,
              decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    blurRadius: 5,
                  ),
                ],
                border: Border(
                  left: BorderSide(width: 5,color: DatabaseNote.notesListeOfDay[index].isCompleted==0?Colors.pinkAccent:Color(bleu)),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 20,bottom: 15,right: 25,left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.note_rounded,color: Colors.grey[700],),
                            SizedBox(width: 8,),
                            Text(DatabaseNote.notesListeOfDay[index].title,
                              style: TextStyle(fontSize: 20,color: Colors.grey[900]),
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Row(
                          children: [
                            Icon(Icons.timer_sharp,color: Colors.grey[700],),
                            SizedBox(width: 8,),
                            Text(DatabaseNote.notesListeOfDay[index].date,
                              style: TextStyle(fontSize: 16,),
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),


                      ],
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
                                DatabaseNote.notesListeOfDay[index].isCompleted==1?Container():
                                GestureDetector(
                                  onTap: (){
                                    DatabaseNote.updateNote(DatabaseNote.notesListeOfDay[index]);
                                    setState(() {
                                      DatabaseNote.getNotesOfDay(DateFormat.yMd().format(date).toString(), type);
                                    });

                                    // Get.back();
                                    Get.back();
                                    DatabaseNote.getNotesOfDay(DateFormat.yMd().format(date).toString(), type);
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
                                    DatabaseNote.deleteNote(DatabaseNote.notesListeOfDay[index]);
                                    setState(() {
                                      DatabaseNote.getNotesOfDay(DateFormat.yMd().format(date).toString(), type);
                                    });
                                    //Get.back();
                                    Get.back();
                                    DatabaseNote.getNotesOfDay(DateFormat.yMd().format(date).toString(), type);
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
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: DatabaseNote.notesListeOfDay[index].isCompleted==0?Colors.pinkAccent:Color(bleu),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(Icons.done_outlined,color: Colors.white,),
                      ),
                    ),
                  ],
                )
              ),
            );
          }
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selecteDate=DateTime.now();
      _selectedType=0;
    });
    DatabaseNote.getNotesOfDay(DateFormat.yMd().format(selecteDate),_selectedType);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Color(bleu),size: 28,),
          onPressed: (){
            Get.back();
          },
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Icon(Icons.add_box_outlined,color: Color(bleu),size: 28,),
            onPressed: (){
              Get.to(AddTask());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /****** TabBar ******/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                            3,
                                (int index){
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _selectedType=index;
                                    DatabaseNote.getNotesOfDay(DateFormat.yMd().format(selecteDate), _selectedType);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5,),
                                  padding: EdgeInsets.only(right: 15,left: 15,top: 6,bottom: 6),
                                  decoration: BoxDecoration(
                                      color: index==_selectedType?Color(bleu):Color(back),
                                      borderRadius: BorderRadius.circular(20),
                                      border: index!=_selectedType?Border.all(color: Color(bleu),width: 1.5):null,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[500],
                                          blurRadius: 2,
                                          spreadRadius: 0,
                                        ),
                                      ]
                                  ),
                                  child: Center(
                                    child: Text(_types[index],
                                      style: TextStyle(color: index==_selectedType?Colors.white:Color(bleu),fontSize: 18,fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ],
                  ),
                  /****** Calendar ******/
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      margin: EdgeInsets.only(right: 20,left: 20,bottom: 15,top: 10),
                      decoration: BoxDecoration(
                       // color: Colors.white,
                          //borderRadius: BorderRadius.circular(20),
                       /* boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500],
                            blurRadius: 5,
                          ),
                        ],*/
                      ),
                      child: TableCalendar(
                        onDaySelected: (date,events,holidays){
                          setState(() {
                            selecteDate=date;
                            DatabaseNote.getNotesOfDay(DateFormat.yMd().format(selecteDate),_selectedType);
                          });
                        },
                        initialSelectedDay: DateTime.now(),
                        calendarController: _controller,
                        calendarStyle: CalendarStyle(
                          holidayStyle: TextStyle(color: Colors.grey),
                          weekdayStyle: TextStyle(color: Colors.grey[900],fontSize: 17),
                          weekendStyle: TextStyle(color: Colors.grey[900],fontSize: 17),
                          selectedColor: Color(couleur1),
                        ),
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          formatButtonDecoration: BoxDecoration(
                            color: Color(couleur1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                          formatButtonVisible: false,
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: TextStyle(color: Color(couleur1)),
                        ),
                        builders: CalendarBuilders(
                          selectedDayBuilder: (context,date,events){
                            return Container(
                              margin: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: Color(0xff3b00ff),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(date.day.toString(),
                              style: TextStyle(color: Colors.white,fontSize: 17),
                              ),
                              ),
                            );
                          },
                          dayBuilder: (context,date,events){
                            return Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(date.day.toString(),
                                style: TextStyle(color: Colors.black,fontSize: 17),
                              ),
                              ),
                            );
                          },
                          outsideDayBuilder: (context,date,events){
                            return Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(back),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(date.day.toString(),
                                style: TextStyle(color: Colors.grey[400],fontSize: 17),
                              ),
                              ),
                            );
                          },
                          todayDayBuilder: (context,date,events){
                            return Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(clair),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 2,color: Color(bleu)),
                              ),
                              child: Center(child: Text(date.day.toString(),
                                style: TextStyle(color: Colors.black,fontSize: 17),
                              ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  /****** Text Date Of Day ******/
                  Container(
                    margin: EdgeInsets.only(left: 22,bottom: 10),
                    child: Text(DateFormat.yMMMMd().format(selecteDate),
                    style: TextStyle(fontSize: 23,color: Colors.black,fontWeight: FontWeight.w600),
                    ),
                  ),
                  /****** List Of Tasks ******/
                  DatabaseNote.notesListeOfDay.length==0?
                  Container(
                    height: 100,
                    child: Center(child: Text("No tasks",style: TextStyle(color: Colors.grey[600],fontSize: 17),)),
                  )
                      : _Body(selecteDate,_selectedType),
                ],
              ),
            ),
            //DatabaseNote.getNote
    );
  }
}
