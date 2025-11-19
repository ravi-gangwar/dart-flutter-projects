import 'package:flutter/material.dart';

void main() {
  runApp(MyCounterApp());
}

class MyCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
        title: Text("First app counter"),
        backgroundColor: Colors.amber,
      ),
      body: CounterState()
    ),
    );
  }
}

class CounterState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyCounter();
}

class _MyCounter extends State<CounterState> {

  int _counter = 0;

  void hanleClick(bool isInc){
    if(isInc) {
      setState(() {
        _counter++;
      });
    }else{
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.red, Colors.yellow
        ],
        begin: Alignment.centerRight,
        end: Alignment.bottomCenter 
        )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter', style: TextStyle(fontSize: 80, color: Colors.green),),
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(click: hanleClick, label: "+ Increase", value: true,),
                SizedBox(width: 10,),
                MyButton(click: hanleClick, label: "+ Descrease", value: false,)
              ],
            )
          ],

        ),
        ),
    );
  }
}


class MyButton extends StatelessWidget {
    final String label;
    final bool value;
    final Function(bool) click;

    const MyButton({required this.label, required this.value, required this.click});
    @override
    Widget build(BuildContext context) {
        return ElevatedButton(onPressed: () => click(value), style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 50), textStyle: TextStyle(fontSize: 20), backgroundColor: Colors.amber,
                  ), child: Text(label),);
    }
}