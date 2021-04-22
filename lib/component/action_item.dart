import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int count = 0;

class ActionItem extends StatelessWidget {
  final String title;
  final Widget page;

  const ActionItem({Key? key, required this.title, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        ++count;
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => page,
            settings: RouteSettings(
              name: '$count',
              arguments: {
                'key1': 'value1',
                'key2': 'value2',
              },
            ),
          ),
        );
      },
    );
  }
}
