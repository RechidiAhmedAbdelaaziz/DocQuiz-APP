part of 'page_view.cubit.dart';

class PageViewState {
  PageViewState({required this.pages, required this.currentPage});
  final List<Widget> pages;
  final int currentPage;

  factory PageViewState.initial() =>
      PageViewState(pages: [], currentPage: 0);

  PageViewState _addPage(Widget page, {int? replaceIndex}) {
    final newPages = [...pages];
    replaceIndex != null && replaceIndex < pages.length
        ? newPages[replaceIndex] = page
        : newPages.add(page);

    return _copyWith(pages: newPages);
  }



  PageViewState _deletePage(Widget page) {
    pages.remove(page);
    return _copyWith(pages: pages);
  }

  PageViewState _copyWith({
    List<Widget>? pages,
    int? currentPage,
  }) {
    return PageViewState(
      pages: pages ?? this.pages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
