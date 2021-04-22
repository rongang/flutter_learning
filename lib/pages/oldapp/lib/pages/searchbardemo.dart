import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const drugDetails = [
  {'name': '阿司匹林肠溶片（北京曙光）', 'standard': '40mg', 'factory': '北京曙光药业有限责任公司'},
  {'name': '阿司匹林肠溶片（北京燕京）', 'standard': '25mg', 'factory': '北京燕京药业有限公司'},
  {'name': '阿司匹林片（修正药业）', 'standard': '0.3g', 'factory': '修正药业集团股份有限公司'},
  {'name': '伯基（阿司匹林肠溶胶囊）', 'standard': '0.1g', 'factory': '永信药品工业（昆山）股份有限公司'},
];

class SearchBarDemo extends SearchDelegate {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<List> searchedRecord;
//  //获取文件
//  Future<File> _getLocalFile() async{
//    String dir = (await getApplicationDocumentsDirectory()).path;
//    return File('$dir/temp.txt');
//  }
//
//  //读取文件
//  Future<String> _readFile() async {
//    try{
//      File file = await _getLocalFile();
//      String contents = await file.readAsString();
//      return contents;
//    }on FileSystemException{
//      return '';
//    }
//  }
//  //写入文件
//  Future<Null> _writeIntoFile(String input) async{
//    await (await _getLocalFile()).writeAsString(input);
//  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          size: 20,
        ));
  }

  /*  Future<void> _deleteInputHistory(String input) async {
    final SharedPreferences prefs = await _prefs;
    final List<String> history = prefs.getStringList("history")??[];
    history.remove(input);

    setState(() {
      _inputList = prefs.setStringList("history", history).then((bool success) {
        return history;
      });
    });
  }*/

  Future<void> _incrementCounter(String input) async {
    final SharedPreferences prefs = await _prefs;
    final List<String> searchHistory = prefs.getStringList('searchHistory') ?? [];
    searchHistory.add(input);
    prefs.setStringList("searchHistory", searchHistory).then((bool success) {});
  }

  @override
  Widget buildResults(BuildContext context) {
//    if(query!='') _writeIntoFile(query);
    if (query != '') _incrementCounter(query);
    List result = drugDetails.where((element) => element['name']!.contains(query == '' ? '_' : query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          text: TextSpan(style: TextStyle(color: Color(0xFF555555)), children: [TextSpan(text: result[index]['name'])]),
        ),
      ),
      itemCount: result.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List result;
    searchedRecord = _prefs.then((SharedPreferences prefs) {
      return (prefs.getStringList('searchHistory') ?? []);
    });
//    _readFile().then((value) {
//      print(value);
//      searchedRecord.add(value);});
//    Future.delayed(Duration(milliseconds: 200),() {result = query != ''?drugDetails.where((element) => element['name'].startsWith(query)).toList():searchedRecord;});
//    result = query != ''?drugDetails.where((element) => element['name'].startsWith(query)).toList():searchedRecord;
    print(searchedRecord.then((value) => print(value)));
    return FutureBuilder(
      future: searchedRecord,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData)
              return ListView.builder(
                  itemCount: snapshot.requireData.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(snapshot.requireData[index]),
                      ));
            else
              return Text(snapshot.error.toString());
            break;
          default:
            return Container();
        }
      },
    );
  }
}
