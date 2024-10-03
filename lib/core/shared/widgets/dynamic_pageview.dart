import 'package:flutter/material.dart';

class DynamicPageView extends StatefulWidget {
  final List<Widget> children;
  final PageController controller;

  DynamicPageView({
    super.key,
    required this.children,
    PageController? controller,
    double viewportFraction = 1,
  }) : controller = controller ??
            PageController(
              viewportFraction: viewportFraction,
            );

  @override
  State<DynamicPageView> createState() => _DynamicPageViewState();
}

class _DynamicPageViewState extends State<DynamicPageView> {
  double? _currentItemHeight;
  int _current = 0;

  @override
  initState() {
    widget.controller.addListener(() {
      final page = widget.controller.page!.round();
      if (page != _current) {
        setState(() {
          _current = page;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0,
          child: _SizeNotifierWidget(
            child: widget.children[_current],
            onSizeChange: (size) {
              setState(() {
                _currentItemHeight = size.height;
              });
            },
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: _currentItemHeight ?? 0,
          child: PageView.builder(
            controller: widget.controller,
            itemCount: widget.children.length,
            itemBuilder: (__, index) => widget.children[index],
          ),
        ),
      ],
    );
  }
}

class _SizeNotifierWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const _SizeNotifierWidget({
    required this.child,
    required this.onSizeChange,
  });

  @override
  State<_SizeNotifierWidget> createState() =>
      _SizeNotifierWidgetState();
}

class _SizeNotifierWidgetState extends State<_SizeNotifierWidget> {
  Size? _oldSize;

  @override
  void didUpdateWidget(covariant _SizeNotifierWidget oldWidget) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _notifySize());
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _notifySize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _notifySize() {
    final size = context.size;
    if (size != null && _oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }
}
