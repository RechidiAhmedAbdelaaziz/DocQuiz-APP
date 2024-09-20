import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'page_view.state.dart';

class PageViewCubit extends Cubit<PageViewState> {
  PageViewCubit() : super(PageViewState.initial());

  final pageController = PageController();

  void addPage(Widget page, {int? replaceIndex}) {
    emit(state._addPage(page, replaceIndex: replaceIndex));
    // setCurrentPage(state.pages.length - 1);
  }

  void setCurrentPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void deletePage(Widget page) {
    emit(state._deletePage(page));
  }
}
