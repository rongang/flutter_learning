import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Utils/customrotute.dart';
import 'animation/animation_1.dart';
import 'generated/l10n.dart';
import 'homePage.dart';
import 'news.dart';
import 'pages/i18n/localization_demo.dart';
import 'personal.dart';
import 'settings.dart';

void main() {
  runApp(MyOldApp());
}

class MyOldApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('en', 'US'),
      supportedLocales: [const Locale('en', 'US'), const Locale('zh', 'CN')],
      localeResolutionCallback: (locale, list) {
        print('locale2:${locale.toString()}');
        return locale;
      },
      localizationsDelegates: [
        S.delegate,
        LocalizationDemo.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Theme.of(context).copyWith(
        primaryColor: Colors.blue[300],
      ),
      home: animation_1(
        child: MyHomePage(title: 'demo'),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 1), vsync: this);
    _animation = Tween(begin: .4, end: 1.0).animate(_animationController);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        Navigator.of(context)
            .pushAndRemoveUntil(CustomRoute(widget: MyHomePage(title: 'FLUTTER Demo'), settings: null), (route) => false);
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        body: AspectRatio(
          aspectRatio: 9 / 16,
          child: FadeTransition(
            opacity: _animation,
            child: Image.network(
              'http://img.netbian.com/file/2020/0504/548dbd05bb6f47f2224fa2744bf9d17a.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _index;
  List<Widget> tabs = [HomePage(), NewsPage(), PersonalPage(), SettingsPage()];
  List<IconData> tabsIcon = [
    Icons.home,
    Icons.fiber_new,
    Icons.person,
    Icons.settings,
  ];

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  Future<DateTime> getTimeNow() async {
    return DateTime.now();
  }

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
//          IndexedStack(
//            index: _index,
//            children: tabs,
//          ),
          PageView(
        onPageChanged: (index) {
          setState(() {
            _index = index;
          });
        },
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: tabs,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
//          shape: CircularNotchedRectangle(),
          child: SizedBox(
        height: 60,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabsIcon
                .asMap()
                .keys
                .map((index) => GestureDetector(
                      child: Icon(
                        tabsIcon[index],
                        color: _index == index ? Theme.of(context).primaryColor : Colors.blueGrey,
                      ),
                      onTap: () {
                        setState(() {
                          _index = 0;
                        });
                        _pageController.jumpToPage(index);
                      },
                    ))
                .toList()),
      )),
    );
  }
}

class SliverPage extends StatefulWidget {
  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  bool isLoading = false;
  bool isRefresh = false;

  bool _handleScrollNotification(ScrollNotification notification) {
//    notification.metrics.axis
    if (notification is ScrollEndNotification) {
//      print('距离底部 ${notification.metrics.extentAfter}');
//      print('距离顶部 ${notification.metrics.extentBefore}');
      //下滑到最底部
      if (notification.metrics.extentAfter == 0.0) {
        print('下滑到最底部');
        _loadMore();
      }
      //滑动到最顶部
      if (notification.metrics.extentBefore == 0.0) {
        print('滑动到最顶部');
      }
    }
    return false;
  }

  int num = 0;

/*
  new NotificationListener<ScrollNotification>(
    onNotification: _handleScrollNotification,
    child: new ListView.builder(
    controller: scrollController,
    itemBuilder: (BuildContext ctx, int index) {
      return new BookItemView(
          book: _items[index],
          searchKey: _searchText,
          words: _words,
      );
    },
    itemCount: _items?.length ?? 0,
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('sliverDemo'),
        ),
        body: new NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: RefreshIndicator(
                displacement: 40,
//              backgroundColor: Colors.deepPurple,
//                color: Colors.red,
                onRefresh: _refresh,
                child: Stack(
                  children: <Widget>[
                    CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          expandedHeight: 230.0,
                          automaticallyImplyLeading: false,
                          pinned: false,
                          flexibleSpace: _ImageNewsScroll(),
                        ),
//                      SliverFixedExtentList(
//                        itemExtent: 50.0,
//                        delegate: SliverChildBuilderDelegate(
//                                (BuildContext context, int index) {
//                              return Center(
//                                child: CircularProgressIndicator(
//                                  backgroundColor: Colors.transparent,
//                                ),
//                              );
//                            }, childCount: 1),
//                      ),
                        SliverGrid(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 4.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                alignment: Alignment.center,
                                color: Colors.teal[100 * (index % 9)],
                                child: Text('Grid Item $index'),
                              );
                            },
                            childCount: 20,
                          ),
                        ),
                      ],
                    ),
                    Offstage(
                      offstage: !isLoading,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(bottom: 30),
                        alignment: Alignment.bottomCenter,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ],
                ))));
  }

  Future<void> _refresh() async {
    if (isRefresh) return null;
    setState(() {
      isRefresh = true;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      print('获取新数据');
      setState(() {
        isRefresh = false;
      });
    });
  }

  Future<void> _loadMore() async {
    if (isLoading) return null;
    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      print('获取更多数据');
      setState(() {
        isLoading = false;
      });
    });
  }
}

class CardBox extends StatefulWidget {
  final int input;

  CardBox(this.input);

  @override
  _CardBoxState createState() => _CardBoxState();
}

class _CardBoxState extends State<CardBox> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      child: Center(
        child: Text(
          widget.input.toString(),
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

String image1 = 'http://pic.netbian.com/uploads/allimg/200428/230003-158808600315ad.jpg';
String image2 = 'http://pic.netbian.com/uploads/allimg/190211/235228-154990034846a9.jpg';
String image3 = 'http://pic.netbian.com/uploads/allimg/200107/230332-1578409412a2f8.jpg';

final List scrollNews = [
  {'cover': image1, 'id': 1},
  {'cover': image2, 'id': 2},
  {'cover': image3, 'id': 3},
  {'cover': image1, 'id': 4},
  {'cover': image2, 'id': 5},
  {'cover': image3, 'id': 6},
];
final List scrollNewsBar = [
  Icons.looks_one,
  Icons.looks_two,
  Icons.looks_3,
  Icons.looks_4,
  Icons.looks_5,
  Icons.looks_6,
];

class _ImageNewsScroll extends StatefulWidget {
//  final VoidCallback onTap;
//  final NewsListInfo item;
//  final bool expanded;
//  final NewsProvider provider;
//
//  const _ImageNewsScroll(
//      {Key key,
//      this.onTap,
//      @required this.item,
//      @required this.expanded,
//      this.provider})
//      : assert(item != null),
//        assert(expanded != null),
//        super(key: key);

  @override
  _ImageNewsScrollState createState() => _ImageNewsScrollState();
}

class _ImageNewsScrollState extends State<_ImageNewsScroll> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: scrollNews.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TabBarView(
            controller: tabController,
            children: scrollNews
                .map((scrollNews) => GestureDetector(
                      onTap: () {
                        print(scrollNews['id']);
//                Navigator.of(context).push(MaterialPageRoute(
//                    builder: (context) =>
//                        NewsDetailPage(scrollNews['id'])));
                      },
                      child: AspectRatio(
                        aspectRatio: 21 / 9,
                        child: Image.network(scrollNews['cover'], fit: BoxFit.cover),
                      ),
                    ))
                .toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              height: 30,
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TabBar(
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: Colors.white30,
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      controller: tabController,
                      tabs: scrollNews
                          .asMap()
                          .keys
                          .map((index) => Icon(
                                Icons.fiber_manual_record,
                                size: 12,
                              ))
                          .toList()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
