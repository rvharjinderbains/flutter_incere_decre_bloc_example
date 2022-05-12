import 'dart:developer';

import 'package:flutter/material.dart';

import 'block_counter.dart';
import 'event_counter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bloc = BlocCounter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Bloc Example"),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.counter,
          initialData: 0,
          builder: (BuildContext context,AsyncSnapshot<int> snapshot){
            log(snapshot.data.toString());
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network("https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/flutter_bloc_logo_full.png",width: 250,height: 200,),
                const Text("Flutter Bloc Example", style: TextStyle(fontStyle: FontStyle.italic,fontSize: 25),),
                const Text("Press Below Button "),
                Text(
                    '${snapshot.data}',
                    style: const TextStyle(fontSize: 30)
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child:const Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: (){
              log("Increment");
              //class bloc class by passing IncrementEvent
              _bloc.counterEventSink.add(IncrementEvent());
            },
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            backgroundColor: Colors.red,
            onPressed: (){
              log("Decrement");
              //class bloc class by passing DecrementEvent
              _bloc.counterEventSink.add(DecrementEvent());
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //dispose all the controller
    _bloc.dispose();
  }
}