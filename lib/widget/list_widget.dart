import 'package:flutter/material.dart';
import 'package:todo_app/cubit/cubit.dart';
class ListWidget extends StatelessWidget {

  @required late Map model ;

  ListWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Row(
      children:
      [
        CircleAvatar(
          child: Center(
            child: Text('${model['TIME']}' , style: TextStyle(
              fontSize: media.size.height*0.02,
              fontFamily: 'Cairo' , color: Colors.grey
            ),),
          ),
          backgroundColor: Color(0xffE31CD6),
          radius: 45.0,
        ) ,
        SizedBox(width: media.size.width*0.03,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children:
            [
              Text('${model['TITLE']}',style: TextStyle(
                  fontSize: media.size.height*0.02,
                  fontFamily: 'Cairo' , color: Colors.black , fontWeight: FontWeight.bold
              ), ) ,
              Text('${model['DATE']}',style: TextStyle(
                  fontSize: media.size.height*0.02,
                  fontFamily: 'Cairo' , color: Colors.grey , fontWeight: FontWeight.w100
              ), ) ,
            ],
          ),
        ),
        SizedBox(width: media.size.width*0.03,),
        IconButton(
          onPressed: (){
            AppCubit.get(context).update(status: 'done' , id:model['ID']);

          },
          icon: Icon(Icons.check_box) ,
          color: Colors.green,
        ),
        IconButton(
          onPressed: (){
            AppCubit.get(context).update(status: 'archive' , id:model['ID']);
          },
          icon: Icon(Icons.archive_outlined) ,
          color: Colors.black38,
        )

      ],
    );
  }


}
