import 'dart:math' as math;

import 'package:draggable_expandable_widget/asd.dart';
import 'package:draggable_expandable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';

enum ClosePosition {
  closeToRight,
  closeToLeft,
}

enum ChildrenType {
  rowChildren,
  columnChildren,
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab(
      {super.key,
      this.childrenType = ChildrenType.rowChildren,
      this.initialOpen,
      this.onTab,
      this.duration,
      this.closeRotate = false,
      required this.distance,
      required this.children,
      this.openWidget,
      this.closeWidget,
      this.childrenAlignment,
      this.closePosition = ClosePosition.closeToRight,
      this.curveAnimation,
      this.reverseAnimation,
      this.childrenMargin,
      this.childrenBacgroundColor,
      this.childrenInnerMargin,
      this.enableChildrenOpenAnimation=true,
      this.childrenBoxDecoration});

  final ChildrenType? childrenType;
  final ClosePosition? closePosition;
  final Duration? duration;
  final bool? initialOpen;
  final bool? closeRotate;
  final VoidCallback? onTab;
  final Widget? closeWidget;
  final Widget? openWidget;
  final Alignment? childrenAlignment;
  final Curve? curveAnimation;
  final Curve? reverseAnimation;
  final bool? enableChildrenOpenAnimation;

  /// Open and Close Widget's initial distance from bottom right
  final double distance;
  final EdgeInsets? childrenInnerMargin;
  final EdgeInsets? childrenMargin;
  final List<Widget> children;
  final Color? childrenBacgroundColor;
  final BoxDecoration? childrenBoxDecoration;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
//_ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;
  late final Duration _duration;
  final GlobalKey _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _duration = widget.duration ?? const Duration(milliseconds: 500);
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: widget.duration ?? _duration,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: widget.curveAnimation ?? Curves.fastOutSlowIn,
      reverseCurve: widget.reverseAnimation ?? Curves.fastOutSlowIn,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (widget.onTab != null) widget.onTab!();
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SizedBox.expand(
      key: _key,
      child: Stack(
        alignment:widget.childrenAlignment??Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
             return FadeTransition(opacity: animation, child: child);
             // return ScaleTransition(scale: animation, child: child);
            },
            child:!_open?const SizedBox.shrink():Container(
              decoration:widget.childrenBoxDecoration??BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20)
              ) ,
              margin:  widget.childrenMargin ??
                  const EdgeInsets.only(top: 100, right: 10,left: 10,bottom: 10),
              child:  widget.childrenType == ChildrenType.rowChildren
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._buildExpandingActionButtons(),
                ],
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [..._buildExpandingActionButtons()],
              ),
            )
          ),
          //  Container(color: Colors.red,width: 40,height: 40,),
          // ColoredBox(color: Colors.black12,child: SizedBox(width: 200,height: 200,)),
    DraggableWidget(
      parentKey: _key,
      initialOffset: Offset(
          0, _size.height-80),
      child: ColoredBox(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildTapToCloseFab(),
            _buildTapToOpenFab(),
          ],
        ),
      ),)
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return Visibility(
      visible: widget.children.isNotEmpty,
      child: GestureDetector(
        onTap: _toggle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.closeWidget ??
              Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 2),
                        blurRadius: 4,
                        spreadRadius: 2,
                        color: Colors.black38)
                  ], shape: BoxShape.circle, color: Colors.white),
                  width: 46,
                  height: 46,
                  child: const Icon(
                    Icons.clear,
                    color: Colors.blue,
                  )),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 18 * count / (count / 2);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          enableOpenAnimation: widget.enableChildrenOpenAnimation!,
          open: _open,
          childrenMargin: widget.childrenInnerMargin,
          closePosition: widget.closePosition!,
          closeRotate: widget.closeRotate!,
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: _duration,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: widget.children.isEmpty
              ? 1
              : _open
                  ? 0.0
                  : 1.0,
          curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
          duration: _duration,
          child: GestureDetector(
            onTap: _toggle,
            child: widget.openWidget ??
                Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 2),
                          blurRadius: 4,
                          spreadRadius: 2,
                          color: Colors.black38)
                    ], shape: BoxShape.circle, color: Colors.blue),
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.create,
                      color: Colors.white,
                    )),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton(
      {required this.childrenMargin,
      required this.directionInDegrees,
      required this.maxDistance,
      required this.progress,
      required this.child,
      required this.open,
      required this.closeRotate,
      required this.closePosition,
      required this.enableOpenAnimation});

  final bool closeRotate;
  final bool open;
  final bool enableOpenAnimation;
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
  final ClosePosition closePosition;
  final EdgeInsets? childrenMargin;

  @override
  Widget build(BuildContext context) {
    // print((directionInDegrees*(math.pi / 180.0)).toString()+"-");
    //  print(math.pi);
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset(
          directionInDegrees * (math.pi / 180),
          maxDistance * (1 - progress.value),
        );
        return Padding(
            padding: childrenMargin ?? const EdgeInsets.all(10),
            child: Transform.rotate(
                    angle: closeRotate == true
                        ? 0
                        : (1.0 - progress.value) * math.pi,
                    child: Padding(padding:enableOpenAnimation?EdgeInsets.symmetric(vertical:open?offset.dy:0,horizontal:open?offset.dy:0 ):EdgeInsets.zero,child: child!)));
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
    /*
    Transform.translate(
                offset: Offset(
                    0,//(closePosition == ClosePosition.closeToRight ? 1 : -1) * offset.dy,
                    0),
     */
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.secondary,
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
