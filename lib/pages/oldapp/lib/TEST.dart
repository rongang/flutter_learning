import 'dart:convert';


String content = '[{\"【药品名称】\":\"&nbsp;&nbsp;通用名称：健胃消食片&nbsp;&nbsp;商品名称：健胃消食片&nbsp;&nbsp;拼音全码：JianWeiXiaoShiPian\"}]';
String content2 = '[{\"1"\:\"1"\},{\"2"\:\"2"\},3]';
//class entry
main(List<String> args) {
  print(content);
//  print(content.indexOf('【'));
//  content = content.replaceAll('【','')..replaceAll('】', '');
//  content = content.replaceAll("】", '');
//  List list = jsonDecode(content);
//
//  print(list[0].keys.toString().substring(1,list[0].keys.toString().length-1));
//  print(content);

  RegExp exp = new RegExp(r"[\u4e00-\u9fa5+0-9+a-z]");
  Iterable<RegExpMatch> matches = exp.allMatches(content);
  for(RegExpMatch r in matches){
    print(r[0]);
  }
}


