import 'dart:async';

import 'event_counter.dart';

// async enable
class BlocCounter{
  int _counter = 0;

  //StreamController handle input and output
  final _counterStateController = StreamController<int>();

  // Sink in Flutter can be easily stated, In Simple Words Sink = Import
  StreamSink<int> get _inCounter =>_counterStateController.sink;

  // Stream in Flutter can be easily stated, In Simple Words Stream = Output
  Stream<int> get counter =>_counterStateController.stream;

  //event controller to trigger which event has occurred
  final _counterEventController = StreamController<EventCounter>();

  Sink<EventCounter> get counterEventSink =>_counterEventController.sink;

  BlocCounter(){
    _counterEventController.stream.listen((_mapEventToState));
  }

  void _mapEventToState(EventCounter event){
    // depending on event either increment or decrement the counter variable
    if(event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }

    _inCounter.add(_counter);

  }

  // Dispose the Controller, Very important step, Otherwise you may get memory leak
  void dispose(){
    _counterStateController.close();
    _counterEventController.close();
  }
}