import 'package:draggable_expandable_widget/draggable_widget.dart';
import 'package:draggable_expandable_widget/expandable_widget.dart';
import 'package:draggable_expandable_widget/float_action_location.dart';
import 'package:draggable_expandable_widget/testpage.dart';
import 'package:flutter/material.dart';

import 'asd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final Size _size=MediaQuery.of(context).size;
    print(_size.width);
    print(_size.height);
    return Scaffold(
      floatingActionButtonLocation:ExpandableFloatLocation(),
        floatingActionButton: ExpandableFab(
          enableChildrenOpenAnimation: false,
          curveAnimation: Curves.linear,
          reverseAnimation: Curves.linear,
          childrenType: ChildrenType.columnChildren,
          closeRotate: true,
          childrenAlignment: Alignment.topLeft,

          onTab: (){
           // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ASD()));
          },

          distance: 100,
          children: [
            FloatingActionButton(onPressed: (){},child: Icon(Icons.accessibility_rounded),),
            FloatingActionButton(onPressed: (){},child: Icon(Icons.accessibility_rounded),),
            FloatingActionButton(onPressed: (){},child: Icon(Icons.accessibility_rounded),),
            FloatingActionButton(onPressed: (){},child: Icon(Icons.accessibility_rounded),),
            FloatingActionButton(onPressed: (){},child: Icon(Icons.accessibility_rounded),),
           //Container(width: 100,height: 100,color: Colors.red,)
          ],
        ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: Center(
          child: TextButton(onPressed: (){
            print("12312312312");
          }, child: Text("dddd")),
        ),
        //child: Center(child: Container(color: Colors.red,width: 200,height: 200,child: DraggableFab(child:Text("123"),),),),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
