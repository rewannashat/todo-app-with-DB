import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/cubit/states.dart';

import '../module/archived_screen.dart';
import '../module/done_screen.dart';
import '../module/tasks_screen.dart';

class AppCubit extends Cubit <Appstates> {

  AppCubit() : super(InitialState()) ;
 static AppCubit get (context) => BlocProvider.of(context); // easly access data and use in muliple screens

  List <Widget> screens = [
    Tasks(),
    Done(),
    Archived(),
  ];
  List <String> title = [
    'Task',
    'Done Task',
    'Archived Task',
  ];
  int currentIndex = 0 ;
  void changeBottomNav (index){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  late Database database ;
  List <Map> newTasks = [];
  List <Map> doneTasks = [];
  List <Map> archiveTasks = [];
   void createDB ()  {
     openDatabase('todo.db' , version: 1 ,
        onCreate: (database , version) async{
          print('DataBase Creating');
          await database.execute(
              'CREATE TABLE tasks (ID INTEGER PRIMARY KEY , TITLE TEXT , DATE TEXT , TIME TEXT , STATUS TEXT)'
          ).then((value) {
            print ('creating table');
          }) ;
        } ,
        onOpen: (database) {
          getDataFromDB(database);
          print('DataBase opened');
        }
    ).then((value) {
       database = value ;
       emit(AppCreateDBState());
     }) ;
  }
   insertToDB ({
    required String title ,
    required String date ,
    required String time
  }) async {
     await database.transaction((txn) async {
      txn.rawInsert('INSERT INTO tasks (TITLE,DATE,TIME,STATUS) VALUES ("$title","$date","$time","new")').then((value) {
        print ('$value inserting Done!');
        emit(AppInsertIntoDBState());
        getDataFromDB(database);

      }).catchError((error) {
        print('the error is ${error.toString()}');
      });

    });

  }
   void getDataFromDB (database) {
     newTasks = [];
     doneTasks = [];
     archiveTasks=[];
     emit(AppGetLoadingState());
     database.rawQuery('SELECT * FROM tasks').then((value) {
      // print ('the value isss $value');
       value.forEach((element) {

        if (element['STATUS'] == 'new' ) {
          newTasks.add(element) ;
        }
        else if (element['STATUS'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      }) ;

      emit(AppGetFromDBState());
    });
  }
  IconData icon = Icons.edit;
  bool show = false ;
  void changeIconState ({
    required IconData icons ,
    required bool shows}) {
    show = shows ;
    icon = icons ;
    emit(AppChangeIconState());

  }
  void update ({required String? status , required int? id}) async{
    await database.rawUpdate('UPDATE tasks SET STATUS = ? WHERE ID = ? ' ,
    ['$status' , id]
    ).then((value) {
      getDataFromDB(database);
      emit(AppUpdateDataStatusState());
    }) ;
  }

}