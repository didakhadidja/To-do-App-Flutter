import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_to_app/Models/DatabaseNote.dart';
import 'package:to_to_app/Models/Note.dart';
import 'package:to_to_app/Screens/HomePage.dart';
import 'package:to_to_app/Widgets/MyInputField.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  int couleur1=0xff9A7FDD;
  int bleu=0xff3b00ff;
  int back=0xffEFEDF4;
  int clair=0xffccccff;
  TextEditingController _titleController=TextEditingController();
  TextEditingController _descriptionController=TextEditingController();
  DateTime _selectedDate=DateTime.now();
  String _selectedTime="10:30 AM";
  String _reminder="never";
  List<String> _reminderList=["never","everyday"];

  void _getDate() async{
    DateTime datePicker=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2029),
      builder: (context,child){
          return Theme(
              data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(couleur1), // header background color
                //onPrimary: Colors.black, // header text color
                //onSurface: Colors.green, // body text color
              ),
              ),
              child: child);
      }
    );
    if(datePicker!=null){
      setState(() {
        _selectedDate=datePicker;
      });
    }else{
      print("date non selected");
    }
  }

  void _getTime() async{
    var timePicker=await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: 10,
            minute: 00
        ),
      builder: (context,child){
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Color(couleur1)
                ),
              ),
              child: child
          );
      }
    );
    if(timePicker!=null){
      setState(() {
        _selectedTime=timePicker.format(context);
      });
    }else{
      print("time non selected");
    }

  }

  void _validate(){
    if(_titleController.text.isEmpty || _descriptionController.text.isEmpty){
      Get.snackbar(
          "Error",
          "Fill all the fields please!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: 10,right: 10,left: 10),
        icon: Icon(Icons.error,color: Colors.white,),
      );
    }else{
      if(_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty){
        _addNote();
      }
    }
  }

  void _addNote()async{
    Note note=new Note(
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateFormat.yMd().format(_selectedDate),
        time: _selectedTime,
        reminder: _reminder,
      isCompleted: 0,
    );
    await DatabaseNote.insertNote(note);
    //print("insertion: $valeur");
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Color(bleu),size: 28,),
          onPressed: (){
            Get.back();
            DatabaseNote.getNotes();
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: 20,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /**** title ****/
              MyField(title: "Title",hint: "title",controller: _titleController,),
              SizedBox(height: 15,),
              /**** description ****/
              MyField(title: "Description",hint: "description...",controller: _descriptionController,),
              SizedBox(height: 15,),
              /**** date ****/
              MyField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: GestureDetector(
                  onTap: (){
                    _getDate();
                  },
                  child: Container(
                    child: Icon(Icons.calendar_today_outlined,color: Color(bleu),),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              /**** time ****/
              MyField(
                title: "Time",
                hint: _selectedTime,
                widget: GestureDetector(
                  onTap: (){
                    _getTime();
                  },
                  child: Container(
                    child: Icon(Icons.timer_sharp,color: Color(bleu),),
                  ),
                ),
              ),
              /**** reminder ****/
              SizedBox(height: 15,),
              MyField(
                title: "Reminder",
                hint: _reminder,
                widget: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down_sharp,color: Color(bleu)),
                  elevation: 0,
                  onChanged: (String newValue){
                    setState(() {
                      _reminder=newValue;
                    });
                  },
                  items: _reminderList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                        child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30,),
              /***** Create Button *****/
              GestureDetector(
                onTap: (){
                  _validate();
                  //Get.back();
                  DatabaseNote.getNotes();
                  DatabaseNote.getNotesOfDay(DateFormat.yMd().format(DateTime.now()), 0);
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: 170,
                  decoration: BoxDecoration(
                    color: Color(bleu),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                      child: Text("Add task",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
