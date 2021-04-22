import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarPage6 extends StatefulWidget {
  @override
  _CalendarPage6State createState() => _CalendarPage6State();
}

class _CalendarPage6State extends State<CalendarPage6> {
  String singleDate = DateTime.now().toString();
  String multiDate = 'null';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExpansionTile(
              title: Text('选择单个日期'),
              children: [
                ListTile(
                  title: Text(
                    singleDate,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime select = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.parse('2000-01-01'),
                        lastDate: DateTime.parse('2100-01-01'),
                      ))!;
                      if (select != null) singleDate = select.toString();
                      setState(() {});
                    },
                  ),
                )
              ],
              initiallyExpanded: false,
            ),
            ExpansionTile(
              title: Text('选择连续日期'),
              children: [
                ListTile(
                  title: Text(
                    singleDate,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTimeRange select = (await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.parse('2000-01-01'),
                        lastDate: DateTime.parse('2100-01-01'),
                      ))!;
                      if (select != null) multiDate = select.toString();
                      setState(() {});
                    },
                  ),
                )
              ],
              initiallyExpanded: false,
            ),
            ExpansionTile(
              title: Text('选择时间'),
              children: [
                ListTile(
                  title: Text(
                    singleDate,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      showTimePicker(context: context, initialTime: TimeOfDay.now(), helpText: '选择时间');
                    },
                  ),
                )
              ],
              initiallyExpanded: false,
            ),
          ],
        )),
      ),
    );
  }
}
