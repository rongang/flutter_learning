import 'dart:math' as math;


void main(List<String> arguments) {
  print('${13*18}');
  print('${15.toRadixString(16)}');
  print('${hextoten('ff')}');
}
const map = {
  'a':10,
  'b':11,
  'c':12,
  'd':13,
  'e':14,
  'f':15,
};
double hextoten(String data) {
  var char = data.split('');
  var result = 0.0;
  char = List.from(char.reversed);
  for (var i = 0; i < char.length; i++) {
    var a = map[char[i]];
    var b = math.pow(16,i);
    result += a*b;
  }
  return result;
}
