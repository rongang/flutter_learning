import 'dart:async';

void main() async {
  var stream = countStream(1000);
  var sum = await sumStream(stream);
  print('sum: $sum');
//  var result = getEmoji(100);
//  result.forEach(print);
//  getEmojiWithTime(10).forEach(print);
//  fetchEmojis(10).listen(print);
//  fetchEmojisWithTime(10).forEach(print);
}

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  var s = stream.asBroadcastStream();

  s.handleError((e){
    print('error -> $e');
  },test: (e){
    print('error -> $e');
    return true;
  });
  StreamSubscription sub =  s.listen((event)async{
     sum += event;
  },onError: (e){
    print('error -> $e');
  });

  return sub.asFuture().then((value) => sum);
//  try{
//    await for (var value in s) {
//      sum += value;
//    }
//  }catch(e){
//    print('error -> $e');
//    return -1;
//  }
//  return sum;
//  return stream.firstWhere((element) => element>=2);
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
//    if(i==3) throw Exception('操作数等于三');
    yield i;
  }
}

///同步处理
///sync* yield
Iterable<String> getEmoji(int count) sync* {
  Runes first = Runes('\u{1f37f}');
  for (int i = 0; i < count; i++) {
    yield String.fromCharCodes(first.map((e) => e + i));
  }
}

///sync* yield*
Iterable<String> getEmojiWithTime(int count) sync* {
  yield* getEmoji(10)
      .map((e) => '$e == ${DateTime.now().millisecondsSinceEpoch}');
}

///异步处理
///async*和yield、await
Stream<String> fetchEmojis(int count) async* {
  for (int i = 0; i < count; i++) {
    yield await fetchEmoji(i);
  }
}

Future<String> fetchEmoji(int count) async {
  Runes runes = Runes('\u{1f47f}');
  print('加载开始-- ${DateTime.now().toIso8601String()}');
  await Future.delayed(Duration(seconds: 1));
  print('加载结束-- ${DateTime.now().toIso8601String()}');
  return String.fromCharCodes(runes.map((e) => e + count));
}

Stream<String> fetchEmojisWithTime(int count) async* {
  yield* fetchEmojis(10)
      .map((event) => '$event == ${DateTime.now().toString()}');
}
