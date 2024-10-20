import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

class ScrollableTab extends StatefulWidget {
  final int initialIndex;

  final Duration? animationDuration;

  final bool isScrollable;

  final List<Widget> tabs;

  final void Function(int)? onTap;

  final double? centerGap;

  final List<Widget> children;

  final EdgeInsetsGeometry? padding;

  final Color? indicatorColor;

  final bool? automaticIndicatorColorAdjustment;

  final double? indicatorWeight;

  final EdgeInsetsGeometry? indicatorPadding;

  final Decoration? indicator;

  final TabBarIndicatorSize? indicatorSize;

  final Color? dividerColor;

  final Color? labelColor;

  final TextStyle? labelStyle;

  final EdgeInsetsGeometry? labelPadding;

  final Color? unselectedLabelColor;

  final TextStyle? unselectedLabelStyle;

  final DragStartBehavior? dragStartBehavior;

  final MouseCursor? mouseCursor;

  final bool? enableFeedback;

  final ScrollPhysics? physics;

  final InteractiveInkFeatureFactory? splashFactory;

  final BorderRadius? splashBorderRadius;

  final Decoration tabBarDecoration;

  final Decoration tabViewDecoration;

  final bool useMaxWidth;

  final TabAlignment tabAlignment;

  const ScrollableTab({
    super.key,
    this.useMaxWidth = true,
    this.tabAlignment = TabAlignment.center,
    this.initialIndex = 0,
    this.animationDuration,
    this.isScrollable = false,
    required this.tabs,
    this.onTap,
    this.centerGap = 0,
    required this.children,
    this.padding,
    this.indicatorColor,
    this.automaticIndicatorColorAdjustment = true,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.dividerColor,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.enableFeedback,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    this.tabBarDecoration = const BoxDecoration(),
    this.tabViewDecoration = const BoxDecoration(),
  });

  @override
  State<ScrollableTab> createState() => _ScrollableTabState();
}

class _ScrollableTabState extends State<ScrollableTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      animationDuration: widget.animationDuration,
      initialIndex: widget.initialIndex,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: widget.tabBarDecoration,
              child: TabBar(
                tabs: widget.tabs,
                tabAlignment: widget.tabAlignment,
                isScrollable: widget.isScrollable,
                onTap: (value) {
                  widget.onTap?.call(value);
                  selectedIndex = value;
                  setState(() {});
                },
                automaticIndicatorColorAdjustment:
                    widget.automaticIndicatorColorAdjustment ?? true,
                dividerColor: widget.dividerColor,
                dragStartBehavior:
                    widget.dragStartBehavior ?? DragStartBehavior.start,
                enableFeedback: widget.enableFeedback,
                indicator: widget.indicator,
                indicatorColor: widget.indicatorColor,
                indicatorPadding: widget.indicatorPadding ?? EdgeInsets.zero,
                indicatorSize: widget.indicatorSize,
                indicatorWeight: widget.indicatorWeight ?? 2,
                labelColor: widget.labelColor,
                labelPadding: widget.labelPadding,
                labelStyle: widget.labelStyle,
                mouseCursor: widget.mouseCursor,
                padding: widget.padding,
                physics: widget.physics,
                splashBorderRadius: widget.splashBorderRadius,
                splashFactory: widget.splashFactory,
                unselectedLabelColor: widget.unselectedLabelColor,
                unselectedLabelStyle: widget.unselectedLabelStyle,
              ),
            ),
            SizedBox(
              height: widget.centerGap,
            ),
            DecoratedBox(
              decoration: widget.tabViewDecoration,
              child: ScrollableTabView(
                selectedIndex: selectedIndex,
                children: widget.children,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScrollableTabView extends StatelessWidget {
  final List<Widget> children;

  final int selectedIndex;

  const ScrollableTabView({
    super.key,
    required this.children,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 600),
      width: double.infinity,
      child: children[selectedIndex],
    );
  }
}
