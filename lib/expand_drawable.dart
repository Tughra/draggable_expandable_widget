import 'package:draggable_expandable_widget/asd.dart';
import 'package:draggable_expandable_widget/expandable_widget.dart';
import 'package:flutter/material.dart';

class ExpandableDrawableFab extends StatelessWidget {
  final double distance;
  final List<Widget>? children;
  final bool? closeRotate;
  final VoidCallback? onTab;
  final Duration? duration;
  const ExpandableDrawableFab({Key? key,required this.distance,this.children,this.onTab,this.closeRotate,this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableFab(child: ExpandableFab(distance: distance, children: children!));
  }
}
