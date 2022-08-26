import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/module/archived_screen.dart';
import 'package:todo_app/module/done_screen.dart';
import 'package:todo_app/module/tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/constant.dart';
import 'package:todo_app/style/defaultFromField.dart';
import 'package:intl/intl.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:bloc/bloc.dart';
class Home extends StatelessWidget {





  late var titleCont = TextEditingController() ;
  var dateCont = TextEditingController() ;
  var timeCont = TextEditingController() ;

  var scaffoldKey = GlobalKey<ScaffoldState>(); // scaffold
  var formKey = GlobalKey<FormState>(); // form in textField



  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,Appstates>(
      listener: (BuildContext context, state) => {
        if (state is AppInsertIntoDBState) {
          Navigator.pop(context),
        }
      } ,
      builder: (BuildContext context,state) => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffE31CD6),
          elevation: 0,
          title: Text(cubit.title[cubit.currentIndex] , style: TextStyle(
            fontFamily: 'Cairo' ,
            fontWeight: FontWeight.w200,
            fontSize:  media.size.height * 0.03,
          ),),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            if (cubit.show) {
              if (formKey.currentState!.validate()){
                cubit.changeIconState (icons:Icons.edit,shows: false);
                cubit.insertToDB(title:titleCont.text,date:dateCont.text,time:timeCont.text);
                // insertToDB (
                //     title: titleCont.text,
                //     date:dateCont.text ,
                //     time: timeCont.text
                // ).then((value) {
                // getDataFromDB(database).then((value) {
                //   tasks = value ;
                //   print ('the tasks data is $tasks');
                //   emit(AppGetFromDBState());
                // });
                //   show = false ;
                //   Navigator.pop(context);
                //   // setState(() {
                //   //   icon = Icons.edit;
                //   // });
                // });
              }
            } else {
              scaffoldKey.currentState!.showBottomSheet((context) =>
                  Form(
                    key:formKey ,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFromField(
                            hint: 'Title',
                            label: 'Title',
                            prefIcon: Icons.title,
                            controller: titleCont,
                            typeInput: TextInputType.text,
                            validate: (String? v){
                              if (v!.isEmpty) {
                                return 'Title must not be empty' ;
                              } else {
                                return null ;
                              }
                            },
                          ),
                          defaultFromField(
                            hint: 'Date',
                            label: 'Date',
                            prefIcon: Icons.date_range,
                            controller: dateCont,
                            typeInput: TextInputType.datetime,
                            validate: (String? v){
                              if (v!.isEmpty) {
                                return 'Date must not be empty' ;
                              } else {
                                return null ;
                              }
                            },
                            onClick:(){
                              //  print('Dateeeeeeeee OPEN');
                              showDatePicker(context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2022-12-31'),
                              ).then((value) {
                                dateCont.text = DateFormat.yMMMd().format(value!);
                                print (dateCont.text);
                              });
                            } ,
                          ),
                          defaultFromField(
                            hint: 'Time',
                            label: 'Time',
                            prefIcon: Icons.watch_later,
                            controller: timeCont,
                            typeInput: TextInputType.datetime,
                            onClick : (){
                              //  print('TIMING OPEN');
                              showTimePicker(context: context,
                                  initialTime: TimeOfDay.now()
                              ).then((value) {
                                timeCont.text = value!.format(context).toString();
                              });
                            } ,
                            validate: (String? v){
                              if (v!.isEmpty) {
                                return 'Time must not be empty' ;
                              } else {
                                return null ;
                              }
                            },
                          ),

                        ],
                      ),
                    ),
                  ) ,
                  elevation: 15.0
              ).closed.then((value) {
                cubit.changeIconState(shows: false , icons:Icons.edit );
               // show = false ;
                // setState(() {
                //   icon = Icons.edit;
                // });
              }) ;
              cubit.changeIconState(icons: Icons.add, shows: true);
             // show = true ;
              // setState(() {
              //   icon = Icons.add;
              // });
            }


          },
          elevation: 3.0,
          backgroundColor: Color(0xffE31CD6),
          child: Icon(cubit.icon),

        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 30,
          selectedItemColor: Color(0xffE31CD6) ,
          currentIndex: cubit.currentIndex,
          onTap: (v){
            cubit.changeBottomNav(v);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'Tasks'),
            BottomNavigationBarItem(icon: Icon(Icons.check_circle),label: 'Done'),
            BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label: 'Archived'),
          ],
        ),
        body:ConditionalBuilder(
          builder: (context) => cubit.screens[cubit.currentIndex],
          condition: state is! AppGetLoadingState,
          fallback:(context) => Center(
            child: CircularProgressIndicator(),
          ) ,
        ),
      ),
    );
  }

 

  
}


