import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Draggable FAB widget which is always aligned to
/// the edge of the screen - be it left,top, right,bottom
class X extends FloatingActionButtonLocation{

  X(){
    getOffset(null);
  }
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry? scaffoldGeometry,{double? width,double? height}) {
   return Offset(width??0,height??0);
  }

}
class DraggableFab extends StatefulWidget{
  final Widget child;
  final Offset? initPosition;
  final double distance;

  const DraggableFab(
      {Key? key, required this.child, this.initPosition, this.distance=200})
      : super(key: key,);

  @override
  _DraggableFabState createState() => _DraggableFabState();

}

class _DraggableFabState extends State<DraggableFab> {
  late Size _widgetSize;
  late Offset _minOffset;
  late Offset _maxOffset;
  late Offset _offset;
  double? _left, _top;
  double _screenWidth = 0.0, _screenHeight = 0.0;
  double? _screenWidthMid, _screenHeightMid;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getWidgetSize(context));
    _minOffset=const Offset(0,0);//expandable ın distancendan buton size ı çıkar
    _offset=widget.initPosition??const Offset(50, 50);
  }

  void _getWidgetSize(BuildContext context) {
  _widgetSize = context.size!;
   //_offset=Offset(_widgetSize.width-100, _widgetSize.height-100);//initial pozition
    _maxOffset=Offset(_widgetSize.width-50, _widgetSize.height-50);//secilen widgetın sizenın çıkar

    /*
    if (widget.initPosition != null) {
      _calculatePosition(widget.initPosition!);
    }
     */
  }

  @override
  Widget build(BuildContext context) {
    print("dx:${_offset.dx}");
    print("dx:${_offset.dy}");
    return Stack(alignment: Alignment.centerLeft,
      children: [
        Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child:Listener(
            onPointerMove: (PointerMoveEvent pointerMoveEvent) {
              _handleDragEnded(pointerMoveEvent);
            },
            onPointerUp: (PointerUpEvent pointerUpEvent) {
              debugPrint('onPointerUp');
            },
            child: Container(
              child: widget.child,
            ),
          ) ,
          /*
          Draggable(
            child: widget.child,
            feedback: widget.child,
            onDragEnd: _handleDragEnded,
            childWhenDragging: Container(
              width: 0.0,
              height: 0.0,
            ),
          )
           */
        ),
      ],
    );
  }

  void _handleDragEnded(PointerMoveEvent draggableDetails) {
    double newOffsetX = _offset.dx + (draggableDetails.delta.dx);
    double newOffsetY = _offset.dy + draggableDetails.delta.dy;

    if (newOffsetX < _minOffset.dx) {
      print("new x < max");
      newOffsetX = _minOffset.dx;
    } else if (newOffsetX > _maxOffset.dx) {
      print("new x > max");
      newOffsetX = _maxOffset.dx;
    }

    if (newOffsetY < _minOffset.dy) {
      newOffsetY = _minOffset.dy;
    } else if (newOffsetY > _maxOffset.dy) {
      newOffsetY = _maxOffset.dy;
    }

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
   // this._calculatePosition(draggableDetails.offset);
  }

/*
  void _calculatePosition(Offset targetOffset) {
    if (_screenWidthMid == null || _screenHeightMid == null) {
      Size screenSize = MediaQuery.of(context).size;
      _screenWidth = screenSize.width;
      _screenHeight = screenSize.height;
      _screenWidthMid = _screenWidth / 2;
      _screenHeightMid = _screenHeight / 2;
    }

    switch (_getAnchor(targetOffset)) {
      case Anchor.LEFT_FIRST:
        this._left = _widgetSize.width / 2;
        this._top = max(_widgetSize.height / 2, targetOffset.dy);
        break;
      case Anchor.TOP_FIRST:
        this._left = max(_widgetSize.width / 2, targetOffset.dx);
        this._top = _widgetSize.height / 2;
        break;
      case Anchor.RIGHT_SECOND:
        this._left = _screenWidth - _widgetSize.width;
        this._top = max(_widgetSize.height, targetOffset.dy);
        break;
      case Anchor.TOP_SECOND:
        this._left = min(_screenWidth - _widgetSize.width, targetOffset.dx);
        this._top = _widgetSize.height / 2;
        break;
      case Anchor.LEFT_THIRD:
        this._left = _widgetSize.width / 2;
        this._top = min(
            _screenHeight - _widgetSize.height - widget.securityBottom,
            targetOffset.dy);
        break;
      case Anchor.BOTTOM_THIRD:
        this._left = _widgetSize.width / 2;
        this._top = _screenHeight - _widgetSize.height - widget.securityBottom;
        break;
      case Anchor.RIGHT_FOURTH:
        this._left = _screenWidth - _widgetSize.width;
        this._top = min(
            _screenHeight - _widgetSize.height - widget.securityBottom,
            targetOffset.dy);
        break;
      case Anchor.BOTTOM_FOURTH:
        this._left = _screenWidth - _widgetSize.width;
        this._top = _screenHeight - _widgetSize.height - widget.securityBottom;
        break;
    }
    setState(() {});
  }
  Anchor _getAnchor(Offset position) {
    if (position.dx < _screenWidthMid! && position.dy < _screenHeightMid!) {
      return position.dx < position.dy ? Anchor.LEFT_FIRST : Anchor.TOP_FIRST;
    } else if (position.dx >= _screenWidthMid! &&
        position.dy < _screenHeightMid!) {
      return _screenWidth - position.dx < position.dy
          ? Anchor.RIGHT_SECOND
          : Anchor.TOP_SECOND;
    } else if (position.dx < _screenWidthMid! &&
        position.dy >= _screenHeightMid!) {
      return position.dx < _screenHeight - position.dy
          ? Anchor.LEFT_THIRD
          : Anchor.BOTTOM_THIRD;
    } else {
      return _screenWidth - position.dx < _screenHeight - position.dy
          ? Anchor.RIGHT_FOURTH
          : Anchor.BOTTOM_FOURTH;
    }
  }

 */
  /// Computes the appropriate anchor screen edge for the widget
}

/// #######################################
/// #       |          #        |         #
/// #    TOP_FIRST     #  TOP_SECOND      #
/// # - LEFT_FIRST     #  RIGHT_SECOND -  #
/// #######################################
/// # - LEFT_THIRD     #   RIGHT_FOURTH - #
/// #  BOTTOM_THIRD    #   BOTTOM_FOURTH  #
/// #     |            #       |          #
/// #######################################
enum Anchor {
  LEFT_FIRST,
  TOP_FIRST,
  RIGHT_SECOND,
  TOP_SECOND,
  LEFT_THIRD,
  BOTTOM_THIRD,
  RIGHT_FOURTH,  BOTTOM_FOURTH}


/*
typedef void OnWidgetSizeChange(Size size);
class WidgetSizeRenderObject extends RenderProxyBox {

  final OnWidgetSizeChange onSizeChange;
  Size? currentSize;

  WidgetSizeRenderObject(this.onSizeChange);

  @override
  void performLayout() {
    super.performLayout();

    try {
      Size? newSize = child?.size;

      if (newSize != null && currentSize != newSize) {
        currentSize = newSize;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onSizeChange(newSize);
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
class WidgetSizeOffsetWrapper extends SingleChildRenderObjectWidget {

  final OnWidgetSizeChange onSizeChange;

  const WidgetSizeOffsetWrapper({
    Key? key,
    required this.onSizeChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WidgetSizeRenderObject(onSizeChange);
  }
}
 */