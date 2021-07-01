import 'package:flutter_bloc/color_bloc.dart';
import 'package:flutter_bloc/textfield_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorBloc _bloc = ColorBloc();
  TextFieldBloc _textFieldBloc = TextFieldBloc();

  @override
  void dispose() {
    _bloc.dispose();
    _textFieldBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC'),
        centerTitle: true
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder(
              stream: _textFieldBloc.outputTextStream,
              builder: (context, AsyncSnapshot<String> snapshot) {
                return TextField(
                  onChanged: (String text) => _textFieldBloc.inputTextSink.add(text),
                  decoration: InputDecoration(
                    errorText: snapshot.hasError ? snapshot.error : null,
                      fillColor: Colors.grey[100],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey
                          ),
                          borderRadius: BorderRadius.circular(6.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent, width: 0.0
                          ),
                          borderRadius: BorderRadius.circular(6.0)
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 0.0),
                          borderRadius: BorderRadius.circular(6.0)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red, width: 0.0
                          ),
                          borderRadius: BorderRadius.circular(6.0)
                      )
                  ),
                );
              }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: StreamBuilder(
                  stream: _bloc.outputStateStream,
                  initialData: Colors.red,
                  builder: (context, snapshot) {
                    return AnimatedContainer(
                        height: 100,
                        width: 100,
                        color: snapshot.data,
                        duration: Duration(milliseconds: 500)
                    );
                  },
                ),
              )
            ]
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.red,
              onPressed: () {
                _bloc.inputEventSink.add(ColorEvent.event_red);
              }
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Colors.green,
              onPressed: () {
                _bloc.inputEventSink.add(ColorEvent.event_green);
              }
          )
        ],
      ),
    );
  }
}
