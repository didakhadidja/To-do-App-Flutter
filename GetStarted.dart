import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_to_app/Screens/CalenderScreen.dart';

class GetStarted extends StatelessWidget {
  int couleur1=0xff9A7FDD;
  int bleu=0xff3b00ff;
  int back=0xffEFEDF4;
  int clair=0xffccccff;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(bleu),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 340,
            width: 340,
            //child: Image.asset("assets/ground.png",width: 350,),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/ground.png"),
                fit: BoxFit.cover,
              )
            ),
          ),
          SizedBox(height: 50,),
          Container(
            margin: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height/3,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                  child: Text("Tasks Manager",style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                  ),),
                  margin: EdgeInsets.only(top: 20),
                ),
                Container(
                  child: Text("Organize your tasks and dont miss any meeting with tis application. Add tasks and you will get notifications",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),),
                  margin: EdgeInsets.only(top: 20,right: 30,left: 30),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(CalenderScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.all( 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(bleu),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Get started  ",style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),
                          ),
                          Icon(Icons.arrow_forward,color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
