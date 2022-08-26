import 'package:flutter/material.dart';
import 'package:todo_app/layout/home_Screen.dart';
import 'package:todo_app/layout/register_Screen.dart';
import 'package:todo_app/style/custom_button.dart';

import '../style/custom_text.dart';
import '../style/custom_text_field.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
 TextEditingController? email ;
TextEditingController? pass ;

class _LoginState extends State<Login> {
  bool check = true  ;
  bool preVisible = true;
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
   // print('the is $media');
    return SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              SizedBox(height: media.size.height * 0.070,),
              Center(
                child: CustomText(
                  txt: 'Login ToDo App',
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
              Container(
                width: media.size.width * 0.9,
                padding: EdgeInsets.all(20),
                child: CustomTextFormField(
                  hintTxt: 'Email',
                  fontSize: media.size.height * 0.04,
                  textAlign: TextAlign.center,
                  prefexIcon: Icons.email,
                  contentPadding:10.0 ,
                  keyboardType: TextInputType.emailAddress,
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
              SizedBox(height: media.size.height * 0.010,),
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
                  obscureText: preVisible,
                  suffexIcon: check ? Icons.remove_red_eye : Icons.visibility_off ,
                  onPressedSuffexIcon:(){
                    setState(() {
                      preVisible = !preVisible ;
                      check  = !check;
                      //   print ('the check isssss $check');
                    });
                  },


                ),
              ),
              SizedBox(height: media.size.height * 0.010,),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 30,right: 20),
                child: CustomButton(
                  txt: 'Login',
                  borderRadius: 15.0,
                  colorTxt: Colors.white,
                  colorButton:Color(0xffea15e1) ,
                  fontSize: media.size.height * 0.03,
                  //colorOutLineButton: Color(0xff15EA1E),
                  width:media.size.width * 0.8,
                  high: media.size.height * 0.05,
                  outLineBorder: false,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 30,right: 20),
                child: CustomButton(
                  txt: 'Register',
                  borderRadius: 15.0,
                  colorTxt: Colors.white,
                  colorButton:Color(0xffea15e1) ,
                  fontSize: media.size.height * 0.03,
                  //colorOutLineButton: Color(0xff15EA1E),
                  width:media.size.width * 0.8,
                  high: media.size.height * 0.05,
                  outLineBorder: false,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                  },
                ),
              ),
              SizedBox(height: media.size.height * 0.040,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    txt: 'Don\'t Have Any Account ?',
                    textAlign:TextAlign.left ,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: media.size.height * 0.02,
                  ),
                  CustomText(
                    txt: 'Regist Now !',
                    textAlign:TextAlign.left ,
                    color: Color(0xff15EA1E),
                    fontWeight: FontWeight.w400,
                    fontSize: media.size.height * 0.02,
                  ),
                ],)
            ],

          ),
        )

    );
  }
}
