import 'dart:async';

class TextFieldBloc {
  // var _textController = StreamController<String>();
  //
  // Stream<String> get textStream => _textController.stream;
  //
  // updateTextField(String text) {
  //   (text == null || text == " ") ? _textController.sink.addError("Invalid value entered!")
  //       : _textController.sink.add(text);
  // }
  //
  // dispose() {
  //   _textController.close();
  // }

  TextFieldBloc() {
    _inputTextController.stream.listen(_mapEventToState);
  }

  final _inputTextController = StreamController<String>();
  StreamSink<String> get inputTextSink => _inputTextController.sink;

  final _outputTextController = StreamController<String>();
  Stream<String> get outputTextStream => _outputTextController.stream;

  void _mapEventToState(String text) {
    (text == null || text == " ")
        ? _outputTextController.sink.addError("Invalid value entered!")
        : _outputTextController.sink.add(text);
  }

  void dispose() {
    _inputTextController.close();
    _outputTextController.close();
  }
}