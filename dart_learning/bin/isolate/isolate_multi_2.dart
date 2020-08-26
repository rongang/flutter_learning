import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

///双向通信
void main() async {
  var worker = Worker();
}

class Worker {
  SendPort _sendPort;
  Isolate _isolate;
  final _isolateReady = Completer<void>();
  final Map<Capability, Completer> _completers = {};

  static Worker get instance {
    workerInstance ?? Worker();
    return workerInstance;
  }

  static Worker workerInstance;

   Worker() {
    init();
  }

  void dispose() {
    _isolate.kill();
  }

  Future request(dynamic message) async {
    await _isolateReady.future;
    final completer = Completer();
    final requestId = Capability();
    _completers[requestId] = completer;
    _sendPort.send(_Request(requestId, message));
    return completer.future;
  }

  Future<void> init() async {
    final receivePort = ReceivePort();
    final errorPort = ReceivePort();
    errorPort.listen(print);
    receivePort.listen(_handleMessage);
    _isolate = await Isolate.spawn(
      _isolateEntry,
      receivePort.sendPort,
      onError: errorPort.sendPort,
    );
  }

  void _handleMessage(message) {
    if (message is SendPort) {
      _sendPort = message;
      _isolateReady.complete();
      return;
    }
    if (message is _Response) {
      final completer = _completers[message.requestId];
      if (completer == null) {
        print('非法请求ID');
      } else if (message.success) {
        completer.complete(message.message);
      } else {
        completer.completeError(message.message);
      }
      return;
    }
    throw UnimplementedError('未实现的方法 -> $message');
  }

  void _isolateEntry(dynamic message) {
    SendPort sendPort;
    final receivePort = ReceivePort();
    receivePort.listen((dynamic data) async {
      if (data is _Request) {
        print('子线程收到： ${data.message}');
        sendPort.send(_Response.ok(data.requestId, '处理后的消息'));
        return;
      }
    });
    if (message is SendPort) {
      sendPort = message;
      sendPort.send(receivePort.sendPort);
    }
  }
}

class _Request {
  final Capability requestId;
  final dynamic message;

  const _Request(this.requestId, this.message);
}

class _Response {
  final Capability requestId;
  final bool success;
  final dynamic message;

  const _Response.ok(this.requestId, this.message) : success = true;

  const _Response.error(this.requestId, this.message) : success = false;
}
