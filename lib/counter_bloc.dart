import 'counter_event.dart';
import 'dart:async';

class CounterBloc {
  int _counter = 0;

  // Code managing the state/output of the BLOC.
  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  Stream<int> get counter => _counterStateController.stream;

  // Code managing the event/input of the BLOC.
  final _counterEventController = StreamController<CounterEvent>();
  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  // Code linking the output of event to the logic or function defined in BLOC function.
  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  // Logic of the counter.
  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    _inCounter.add(_counter);
  }

  // Dispose method.
  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
