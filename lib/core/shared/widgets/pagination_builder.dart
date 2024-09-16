import 'package:flutter/material.dart';

class PaginationBuilder extends StatefulWidget {
  PaginationBuilder({
    super.key,
    required Future<void> Function() onFetch,
    required Widget Function(Widget) builder,
    ScrollController? scrollController,
    Widget loadingWidget = const LinearProgressIndicator(),
    Axis scrollDirection = Axis.vertical,
  })  : _builder = builder,
        _onFetch = onFetch,
        _scrollController = scrollController ?? ScrollController(),
        _loadingWidget = loadingWidget,
        _scrollDirection = scrollDirection;

  final Future<void> Function() _onFetch;
  final Widget Function(Widget loadginWidget) _builder;
  final ScrollController _scrollController;
  final Widget _loadingWidget;
  final Axis _scrollDirection;

  @override
  State<PaginationBuilder> createState() => _PaginationBuilderState();
}

class _PaginationBuilderState extends State<PaginationBuilder> {
  late bool _isLoading = false;

  void _onLoading() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await widget._onFetch();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget._scrollController.addListener(() {
      if (widget._scrollController.position.pixels ==
          widget._scrollController.position.maxScrollExtent) {
        _onLoading();
      }
    });

    return SingleChildScrollView(
      controller: widget._scrollController,
      scrollDirection: widget._scrollDirection,
      child: widget._builder(_loadingWidget()),
    );
  }

  Widget _loadingWidget() {
    return _isLoading
        ? widget._loadingWidget
        : const SizedBox.shrink();
  }
}