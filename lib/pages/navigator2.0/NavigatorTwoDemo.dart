import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorTwoDemo extends StatelessWidget {
  final _navigatorTwoRouterDelegate = NavigatorTwoRouterDelegate();
  final _navigatorTwoRouteInformationParser =
      NavigatorTwoRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return BooksApp();
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: MaterialApp.router(
        routeInformationParser: _navigatorTwoRouteInformationParser,
        routerDelegate: _navigatorTwoRouterDelegate,
        title: 'Navigator 2.0',
      ),
    );
  }
}

class NavigatorTwoRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  final GlobalKey<NavigatorState> navigatorKey;

  static NavigatorTwoRouterDelegate of(BuildContext context){
    return Router.of(context).routerDelegate as NavigatorTwoRouterDelegate;
  }

  NavigatorTwoRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  bool canPop = false;

  @override
  Future<void> setNewRoutePath(configuration) async {
    // if (configuration == '/') {
    //   canPop = true;
    // } else if (configuration == '/child') {
    //   canPop = false;
    // }
  }

  // String get currentConfiguration => !canPop ? '/' : '/child';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        CupertinoPage(
          key: ValueKey('Home'),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Text('Home'),
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        canPop = true;
                        notifyListeners();
                      },
                      child: Text('childPage'))
                ],
              ),
            ),
          ),
        ),
        if (canPop)
          CupertinoPage(
            child: Scaffold(
              appBar: AppBar(
                title: Text('child'),
              ),
              body: Center(
                child: ElevatedButton(
                  onPressed: (){
                    NavigatorTwoRouterDelegate.of(context);
                  },
                ),
              ),
            ),
          )
      ],
      onPopPage: (route, result) {
        print('${route.didPop(result)}');
        print('$result');
        return true;
      },
    );
  }
}


class NavigatorTwoRouteInformationParser
    extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(
      RouteInformation routeInformation) async {
    // var result = Uri.parse('https://www.ctrlhealth.com?id=111&userId=3443sd');
    // print('${result.data}');
    // print('${result.queryParameters}');
    // print('${result.pathSegments}');
    return routeInformation.toString();
  }

  // @override
  // RouteInformation restoreRouteInformation(String configuration) {
  //   return RouteInformation(location: configuration);
  // }
}

void main() {
  runApp(BooksApp());
}

class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}

class BooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  BookRouterDelegate _routerDelegate = BookRouterDelegate();
  BookRouteInformationParser _routeInformationParser =
      BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    // Handle '/'
    // if (uri.pathSegments.length == 0) {
      return BookRoutePath.home();
    // }
    //
    // // Handle '/book/:id'
    // if (uri.pathSegments.length == 2) {
    //   if (uri.pathSegments[0] != 'book') return BookRoutePath.unknown();
    //   var remaining = uri.pathSegments[1];
    //   var id = int.tryParse(remaining);
    //   if (id == null) return BookRoutePath.unknown();
    //   return BookRoutePath.details(id);
    // }
    //
    // // Handle unknown routes
    // return BookRoutePath.unknown();
  }

  // @override
  // RouteInformation restoreRouteInformation(BookRoutePath path) {
  //   if (path.isUnknown) {
  //     return RouteInformation(location: '/404');
  //   }
  //   if (path.isHomePage) {
  //     return RouteInformation(location: '/');
  //   }
  //   if (path.isDetailsPage) {
  //     return RouteInformation(location: '/book/${path.id}');
  //   }
  //   return null;
  // }
}

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  Book _selectedBook;
  bool show404 = false;

  List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  // BookRoutePath get currentConfiguration {
  //   if (show404) {
  //     return BookRoutePath.unknown();
  //   }
  //   return _selectedBook == null
  //       ? BookRoutePath.home()
  //       : BookRoutePath.details(books.indexOf(_selectedBook));
  // }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('BooksListPage'),
          child: BooksListScreen(
            books: books,
            onTapped: _handleBookTapped,
          ),
        ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if (_selectedBook != null)
          BookDetailsPage(book: _selectedBook)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        _selectedBook = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    // if (path.isUnknown) {
    //   _selectedBook = null;
    //   show404 = true;
    //   return;
    // }
    //
    // if (path.isDetailsPage) {
    //   if (path.id < 0 || path.id > books.length - 1) {
    //     show404 = true;
    //     return;
    //   }
    //
    //   _selectedBook = books[path.id];
    // } else {
    //   _selectedBook = null;
    // }
    //
    // show404 = false;
  }

  void _handleBookTapped(Book book) {
    _selectedBook = book;
    notifyListeners();
  }
}

class BookDetailsPage extends Page {
  final Book book;

  BookDetailsPage({
    this.book,
  }) : super(key: ValueKey(book));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BookDetailsScreen(book: book);
      },
    );
  }
}

class BookRoutePath {
  final int id;
  final bool isUnknown;

  BookRoutePath.home()
      : id = null,
        isUnknown = false;

  BookRoutePath.details(this.id) : isUnknown = false;

  BookRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}

class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTapped;

  BooksListScreen({
    @required this.books,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            )
        ],
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  BookDetailsScreen({
    @required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
