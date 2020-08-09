import 'package:my_calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class AlarmIndexPage extends StatefulWidget {
  @override
  _AlarmIndexPageState createState() => _AlarmIndexPageState();
}

class _AlarmIndexPageState extends State<AlarmIndexPage> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 2000));
  DateTime endDate = DateTime.now().add(Duration(days: 200));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 2));
  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];

  final colors = [Colors.green, Colors.red, Colors.blue];

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    int nowIndex = getNowState(date);
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];
    _children.add(getMarkedIndicatorWidget(isDateMarked, nowIndex));
    return dayItem(date, isSelectedDate, _children);
  }

  Container dayItem(
      DateTime date, bool isSelectedDate, List<Widget> _children) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isToday(date, DateTime.now())
            ? Colors.blue[500]
            : !isSelectedDate ? Colors.transparent : Colors.blue[100],
//            borderRadius: BorderRadius.all(Radius.circular(60)),60
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  bool isToday(DateTime dateTime1, DateTime dateTime2) {
    if (dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime2.day == dateTime1.day) return true;
    return false;
  }

  getMarkedIndicatorWidget(bool isDateMarked, int nowIndex) {
    return Opacity(
      opacity: isDateMarked ? 1.0 : 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(colors.length, (index) {
          return Visibility(
            visible: nowIndex == index,
            child: Container(
              margin: EdgeInsets.only(left: 1, right: 1),
              width: 7,
              height: 7,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: colors[index]),
            ),
          );
        }),
      ),
    );
  }

  int getNowState(date) {
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('服药提醒'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: null,
            icon: Icon(Icons.alarm),
            label: Text('添加'),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
                child: CalendarStrip(
              locale: Locale('zh', 'CN'),
              startDate: startDate,
              endDate: endDate,
              onDateSelected: (data) {
                print("Selected Date -> $data");
              },
              dateTileBuilder: dateTileBuilder,
              iconColor: Colors.black87,
              markedDates: markedDates,
              containerDecoration: BoxDecoration(color: Colors.white),
              addSwipeGesture: true,
            )
//            Calendar(
//              dayBuilder: (context,day){
//                print('$day');
//              },
//              isExpandable: true,true
//            ),
                ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('item 1'),
                          ),
                          ListTile(
                            title: Text('item 2'),
                          ),
                          ListTile(
                            title: Text('item 3'),
                          ),
                          ListTile(
                            title: Text('item 4'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
