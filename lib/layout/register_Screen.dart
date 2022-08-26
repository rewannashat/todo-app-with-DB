import 'package:flutter/material.dart';
import 'package:todo_app/layout/home_Screen.dart';
import 'package:todo_app/style/custom_button.dart';
import 'package:todo_app/style/custom_text.dart';
import 'package:todo_app/style/custom_text_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}
TextEditingController? name ;
TextEditingController? email ;
TextEditingController? pass ;
class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return SafeArea(child: Scaffold(
      body: ListView(
        children: [
          SizedBox(height: media.size.height * 0.070,),
          Center(
            child: CustomText(
              txt: 'Register ToDo App',
              textAlign:TextAlign.left ,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: media.size.height * 0.03,

            ),
          ),
          Center(
            child: Image.asset('assets/image/calendar.png' ,
              width: media.size.width * 0.7,
              height: media.size.height * 0.2,
            ),
          ),
          SizedBox(height: media.size.height * 0.010,),
          Container(
            width: media.size.width * 0.9,
            padding: EdgeInsets.all(20),
            child: CustomTextFormField(
              hintTxt: 'Name',
              fontSize: media.size.height * 0.04,
              textAlign: TextAlign.center,
              prefexIcon: Icons.person,
              contentPadding:10.0 ,
              keyboardType: TextInputType.text,
              out: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:  BorderSide(
                  color: Color(0xffea15e1),
                ),),
              controller:name ,
              helperText: 'Enter valid Name',
              onChange: (){
                print(name);
              },
              obscureText: true,


            ),
          ),
          Container(
            width: media.size.width * 0.9,
            padding: EdgeInsets.all(20),
            child: CustomTextFormField(
              hintTxt: 'email',
              fontSize: media.size.height * 0.04,
              textAlign: TextAlign.center,
              prefexIcon: Icons.email,
              contentPadding:10.0 ,
              keyboardType: TextInputType.text,
              out: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:  BorderSide(
                  color: Color(0xffea15e1),
                ),),
              controller:email ,
              helperText: 'Enter valid Email',
              onChange: (){
                print(email);
              },
              obscureText: true,


            ),
          ),
          Container(
            width: media.size.width * 0.9,
            padding: EdgeInsets.all(20),
            child: CustomTextFormField(
              hintTxt: 'Password',
              fontSize: media.size.height * 0.04,
              textAlign: TextAlign.center,
              prefexIcon: Icons.password,
              contentPadding:10.0 ,
              keyboardType: TextInputType.visiblePassword,
              out: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:  BorderSide(
                  color: Color(0xffea15e1),
                ),),
              controller:pass ,
              helperText: 'Enter valid Password',
              onChange: (){
                print(pass);
              },

              suffexIcon: Icons.remove_red_eye ,



            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,top: 30,right: 15),
            child: CustomButton(
              txt: 'Register',
              borderRadius: 15.0,
              colorTxt: Colors.white,
              colorButton:Color(0xffea15e1) ,
              fontSize: media.size.height * 0.03,
              //colorOutLineButton: Color(0xff15EA1E),
              width:media.size.width * 0.7,
              high: media.size.height * 0.05,
              outLineBorder: false,
              onPressed: (){
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.SUCCES,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Succeful Process',
                  desc: '',
                  btnCancelOnPress: () {
                    Navigator.pop(context);
                  },
                  btnOkOnPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
                  },
                ).show();

              },
            ),
          ),
        ],
      ),
    ));
  }
}
