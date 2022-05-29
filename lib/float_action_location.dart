
import 'package:flutter/material.dart';

class ExpandableFloatLocation extends FloatingActionButtonLocation{
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return const Offset(0, 0);
  }


}