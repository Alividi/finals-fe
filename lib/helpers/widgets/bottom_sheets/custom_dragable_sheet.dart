import 'package:flutter/material.dart';

class CustomDragableSheet extends StatefulWidget {
  final Widget child;
  const CustomDragableSheet({super.key, required this.child});

  @override
  State<CustomDragableSheet> createState() => _CustomDragableSheetState();
}

class _CustomDragableSheetState extends State<CustomDragableSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.05) collapse();
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);

  void anchor() => animateSheet(getSheet.snapSizes!.last);

  void expand() => animateSheet(getSheet.maxChildSize);

  void animateSheet(double size) {
    controller.animateTo(
      size,
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  DraggableScrollableSheet get getSheet => (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DraggableScrollableSheet(
        key: sheet,
        initialChildSize: 0.6,
        maxChildSize: 0.95,
        minChildSize: 0.6,
        expand: true,
        controller: controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                topButtonIndicator(),
                SliverToBoxAdapter(
                  child: widget.child,
                ),
              ],
            ),
          );
        },
      );
    });
  }

  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
                child: Wrap(children: <Widget>[
              Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  )),
            ])),
          ]),
    );
  }
}
