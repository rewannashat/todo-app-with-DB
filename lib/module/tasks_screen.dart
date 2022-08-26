import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/shared/constant.dart';
import 'package:todo_app/widget/list_widget.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {

    MediaQueryData media = MediaQuery.of(context);
    //print ('tasks ${tasks.length}');
    //print ('tasks $tasks');
    return BlocConsumer<AppCubit,Appstates>(
      listener: (context, state) {} ,
      builder: (context , state) {
        var cubit = AppCubit.get(context).newTasks;
     //   print ('taskslength ${cubit.length}');
        return Padding(
          padding: const EdgeInsets.all(14),
          child: ListView.separated(
              itemBuilder: (context, index) => ListWidget(
                model: cubit[index],
              ),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
                margin: EdgeInsets.all(15),
              ),
              itemCount: cubit.length),
        );
      } ,
    );
  }
}
