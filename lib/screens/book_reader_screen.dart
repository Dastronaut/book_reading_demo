import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/book.dart' as book_model;
import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';

class BookReaderScreen extends StatefulWidget {
  final book_model.Book book;
  final int initialChapterIndex;

  const BookReaderScreen({
    super.key,
    required this.book,
    required this.initialChapterIndex,
  });

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  late PageController _pageController;
  late int _currentPageIndex;
  bool _isSlideMode = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentPageIndex = _getInitialPageIndex();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  int _getInitialPageIndex() {
    int pageIndex = 0;
    for (int i = 0; i < widget.initialChapterIndex; i++) {
      pageIndex += widget.book.chapters[i].pages.length;
    }
    return pageIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentPage() {
    if (!_isSlideMode) {
      // Calculate the height of each page to scroll to the current position
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final pageHeight = MediaQuery.of(context).size.height;
        _scrollController.animateTo(
          _currentPageIndex * pageHeight,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state is BookLoaded) {
          final currentPage = _getPageAt(_currentPageIndex, state.book);
          return Scaffold(
            appBar: AppBar(
              title: Text(currentPage.chapter.title),
              actions: [
                IconButton(
                  icon: Icon(_isSlideMode ? Icons.view_agenda : Icons.swap_horiz),
                  onPressed: () {
                    setState(() {
                      _isSlideMode = !_isSlideMode;
                      _scrollToCurrentPage();
                    });
                  },
                  tooltip: _isSlideMode ? 'Switch to Scroll Mode' : 'Switch to Slide Mode',
                ),
              ],
            ),
            body: _buildReadingView(state.book),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildReadingView(book_model.Book book) {
    if (_isSlideMode) {
      return PageView.builder(
        controller: _pageController,
        itemCount: _getTotalPages(book),
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        itemBuilder: (context, pageIndex) {
          return _buildPageContent(pageIndex, book);
        },
      );
    } else {
      return SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: List.generate(
            _getTotalPages(book),
            (index) => _buildPageContent(index, book),
          ),
        ),
      );
    }
  }

  int _getTotalPages(book_model.Book book) {
    return book.chapters.fold(0, (sum, chapter) => sum + chapter.pages.length);
  }

  ({book_model.Chapter chapter, book_model.Page page}) _getPageAt(int pageIndex, book_model.Book book) {
    int currentIndex = 0;
    for (var chapter in book.chapters) {
      if (pageIndex < currentIndex + chapter.pages.length) {
        return (
          chapter: chapter,
          page: chapter.pages[pageIndex - currentIndex],
        );
      }
      currentIndex += chapter.pages.length;
    }
    throw Exception('Page index out of bounds');
  }

  Widget _buildPageContent(int pageIndex, book_model.Book book) {
    final pageData = _getPageAt(pageIndex, book);
    final chapter = pageData.chapter;
    final page = pageData.page;

    if (!chapter.isUnlocked) {
      return Container(
        height: _isSlideMode ? MediaQuery.of(context).size.height : null,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'This chapter is locked',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: book.coins >= chapter.unlockCost
                    ? () {
                        context.read<BookBloc>().add(UnlockChapter(chapter.id));
                      }
                    : null,
                child: Text('Unlock for ${chapter.unlockCost} coins'),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: _isSlideMode ? MediaQuery.of(context).size.height : null,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (page.number == 1) ...[
              Text(
                chapter.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
            ],
            Text(
              'Page ${page.number}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              page.content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
} 