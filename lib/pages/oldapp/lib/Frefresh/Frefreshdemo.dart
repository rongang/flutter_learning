// import 'package:flutter/material.dart';
// import 'package:frefresh/frefresh.dart';
//
// import '../Utils/v_tabbar.dart';
//
// class FRefreshDemo extends StatefulWidget {
//   @override
//   _FRefreshDemoState createState() => _FRefreshDemoState();
// }
//
// class _FRefreshDemoState extends State<FRefreshDemo> with TickerProviderStateMixin{
//
//   //刷新组件Controller
//   FRefreshController controller = FRefreshController();
//
//   TabController _tabBarController;
//   @override
//   void initState() {
//     super.initState();
//     print('FRefreshDemo Init');
//     _tabBarController = TabController(length: 5,vsync: this);
//     if(controller.refreshState==RefreshState.IDLE)
//       controller.refresh(duration: Duration(milliseconds: 1000));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Frefresh'),
//       ),
//       body: Row(
//         children: <Widget>[
//           Expanded(
//             flex: 1,
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   width: 0.2,
//                   color: Colors.grey
//                 ),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black38,
//                     offset: Offset(200,0),
//                     blurRadius: 2,
//                     spreadRadius: 2
//                   )
//                 ]
//               ),
//               child: VTabBar(
//                 indicatorColor: Colors.transparent,
//                 labelColor: Colors.blue,
//                 unselectedLabelColor: Colors.white,
//                 controller: _tabBarController,
//                 tabs: List.generate(5, (index) => Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.all(5),
//                   child: Text('示例$index',style: TextStyle(color: Colors.black),),
//                 ),),
//               )
//               /*Column(
//                 children:List.generate(5, (index) => Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.all(5),
//                   child: Text('示例一'),
//                 ),)
//               ),*/
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Scaffold(
//               body: TabBarView(
//                 controller: _tabBarController,
//                 children: <Widget>[
//                   Container(
//                     width: 200,
//                   height: 500,
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(5),
//                     child: FRefresh(
//
//                         headerTrigger: 101,
//                         controller: controller,
//
//                         /// 通过 headerBuilder 构建 Header 区域
//                         headerBuilder: (setter, constraints) {
// //                          constraints.w
//                           return CircularProgressIndicator();
//                         },
//                         headerHeight: 100.0,
//
//                         /// 构建内容区域
//                         child: Container(
//                           width: 100,
//                           height: 100,
//                           child: GridView(
//                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3, //横轴三个子widget
//                                   childAspectRatio: 1.0 //宽高比为1时，子widget
//                               ),
//                               children:<Widget>[
//                                 Icon(Icons.ac_unit),
//                                 Icon(Icons.airport_shuttle),
//                                 Icon(Icons.all_inclusive),
//                                 Icon(Icons.beach_access),
//                                 Icon(Icons.cake),
//                                 Icon(Icons.free_breakfast)
//                               ]
//                           ),
//                         ),
//                       /// 构建 Footer 区域
//                       footer: LinearProgressIndicator(),
//
//                       /// 需要配置 Footer 区域高度
//                       footerHeight: 20.0,
//                       footerTrigger: 21,
//                         /// 进入 Refreshing 状态后会回调该函数
//                         onRefresh: () {
//                           print(controller.refreshState.toString());
//                           if(controller.refreshState==RefreshState.FINISHING)
//                             print('刷新完毕');
//                           else if(controller.refreshState==RefreshState.IDLE)
//                             controller.refresh(duration: Duration(milliseconds: 1000));
//
//                           /// 结束刷新
//                           controller.finishRefresh();
//                         },
//                       onLoad: (){
//                         print('loading...');
//                       },
//                     )
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(5),
//                     child: Text('示例2'),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(5),
//                     child: Text('示例3'),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(5),
//                     child: Text('示例4'),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(5),
//                     child: Text('示例5'),
//                   ),
//                 ]
//               ),
//             )
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class FRefreshDemo2 extends StatefulWidget {
//   @override
//   _FRefreshDemo2State createState() => _FRefreshDemo2State();
// }
//
//   class _FRefreshDemo2State extends State<FRefreshDemo2> {
//
//   FRefreshController controller = FRefreshController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FRefresh(
//           controller: controller,
//
//           /// 通过 headerBuilder 构建 Header 区域
//           headerBuilder: (setter, constraints) {
//             return CircularProgressIndicator();
//           },
//           headerHeight: 100.0,
//
//           /// 构建内容区域
//           child: Container(
//             width: 100,
//             height: 400,
//             child: GridView(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3, //横轴三个子widget
//                     childAspectRatio: 1.0 //宽高比为1时，子widget
//                 ),
//                 children:<Widget>[
//                   Icon(Icons.ac_unit),
//                   Icon(Icons.airport_shuttle),
//                   Icon(Icons.all_inclusive),
//                   Icon(Icons.beach_access),
//                   Icon(Icons.cake),
//                   Icon(Icons.free_breakfast)
//                 ]
//             ),
//           ),
//
//           /// 进入 Refreshing 状态后会回调该函数
//           onRefresh: () {
//
//             /// 结束刷新
//             controller.finishRefresh();
//           }
//       ),
//     );
//   }
// }
