
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(),
          body: HomeScreen()
      ),
    );
  }
}

// DatePickerDialog
// showDatePicker() 사용. 사용자가 선택한 날짜가 반환됨

// TimePickerDialog
// showTimePicker() 사용. 사용자가 선택한 시간이 반환됨
class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  DateTime dateValue = DateTime.now();
  TimeOfDay timeValue = TimeOfDay.now();

  Future datePicker() async {
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
       initialDate: dateValue
    );
    if(picked != null) setState(() => dateValue = picked);
  }

  Future timePicker() async {
    TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: timeValue,
    );
    if(selectedTime != null) setState( () => timeValue = selectedTime );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: datePicker,
              child: Text('DatePicker')
          ),
          // DateFormat 사용을 위해서는 intl 패키지 설치 필요
          Text('date: ${DateFormat('yyyy-MM-dd').format(dateValue)}'),

          ElevatedButton(
              onPressed: timePicker,
              child: Text('TimePicker')
          ),
          Text('time: ${timeValue.hour}:${timeValue.minute}'),
        ],
      ),
    );
  }
}