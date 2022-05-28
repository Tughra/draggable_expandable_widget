import 'package:draggable_expandable_widget/asd.dart';
import 'package:draggable_expandable_widget/expandable_widget.dart';
import 'package:flutter/material.dart';

class ASD extends StatefulWidget {
  const ASD({Key? key}) : super(key: key);

  @override
  State<ASD> createState() => _ASDState();
}

class _ASDState extends State<ASD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DraggableFab(child:ExpandableFab(
        onTab: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ASD()));
        },

        distance: 100,
        children: [
          FloatingActionButton(
            heroTag: "1",
            onPressed: (){
              debugPrint("123123312132");
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: (){
              debugPrint("123123312132");
            },
            heroTag: "2",
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: "3",
            onPressed: (){
              debugPrint("123123312132");
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: "4",
            onPressed: (){
              debugPrint("123123312132");
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),FloatingActionButton(
            heroTag: "5",
            onPressed: (){
              debugPrint("123123312132");
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )
        ],
      ) ,),
      appBar: AppBar(title: Text("hahah"),),
      backgroundColor: Colors.red,
    );
  }
}
