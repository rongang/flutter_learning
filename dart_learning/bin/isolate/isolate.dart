import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

///单向通信
void main() async {
//  await start();
}




int getInt(int a){
  return a;
}
Isolate isolate;

void start() async{
  var receivePort = ReceivePort();
  isolate = await Isolate.spawn(entryPoint,receivePort.sendPort);
  receivePort.listen((data) {
    print('data -> $data');
  });
}
void entryPoint(SendPort sendPort) async {
  var jsonString = '''{ "id":"123", "name":"张三", "score" : 95}''';
  var student = Student.formJson(jsonDecode(jsonString));
  await Timer(Duration(seconds: 5),(){});
  sendPort.send(student);
}

class Student {
  String id;
  String name;
  int score;

  @override
  String toString() {
    return 'Student{id: $id, name: $name, score: $score}';
  }

  Student.formJson(Map<String,dynamic> json) {
    id = json["id"];
    name = json["name"];
    score = json["score"];
  }
}


