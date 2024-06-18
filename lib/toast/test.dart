import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Center(
              child: Column(
                children: [
                  OutlinedButton(
                      onPressed: (){
                        Fluttertoast.showToast(msg: 'Heyyy',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.red,
                          textColor: Colors.green
                        );
                      },
                      child: Text('toast')),
                  OutlinedButton(
                      onPressed: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Like a snackbar'),
                              duration: Duration(days: 1),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: (){
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                },
                              ),
                            ));
                      },
                      child: Text('toast')),
                ],
              )
            );
          }
        ),
      ),
    );
  }
}