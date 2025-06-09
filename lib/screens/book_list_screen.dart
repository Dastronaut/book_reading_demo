import 'package:book_reading_demo/bloc/book_event.dart';
import 'package:book_reading_demo/bloc/book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/book_bloc.dart';
import '../models/book.dart';
import '../widgets/coin_animation.dart';
import 'book_reader_screen.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state is BookInitial) {
          context.read<BookBloc>().add(LoadBook());
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BookLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BookError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is BookLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Book Reading Demo'),
              actions: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Colors.yellow.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${state.book.coins}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChapterListScreen(book: state.book),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(51),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book,
                        size: 80,
                        color: Colors.deepPurple.shade700,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.book.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${state.book.chapters.length} Chapters',
                        style: TextStyle(
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return const Center(child: Text('Something went wrong'));
      },
    );
  }
}

class ChapterListScreen extends StatefulWidget {
  final Book book;

  const ChapterListScreen({
    super.key,
    required this.book,
  });

  @override
  State<ChapterListScreen> createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> {
  final GlobalKey _coinBalanceKey = GlobalKey();
  final Map<int, GlobalKey> _unlockButtonKeys = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state is BookLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.book.title),
              actions: [
                Container(
                  key: _coinBalanceKey,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Colors.yellow.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${state.book.coins}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                ListView.builder(
                  itemCount: state.book.chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = state.book.chapters[index];
                    _unlockButtonKeys[index] = GlobalKey();
                    
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(chapter.title),
                        subtitle: Text(
                          chapter.isUnlocked
                              ? '${chapter.pages.length} pages'
                              : 'Unlock for ${chapter.unlockCost} coins',
                        ),
                        trailing: chapter.isUnlocked
                            ? const Icon(Icons.arrow_forward_ios)
                            : ElevatedButton(
                                key: _unlockButtonKeys[index],
                                onPressed: state.book.coins >= chapter.unlockCost
                                    ? () {
                                        final RenderBox? coinBalanceBox = _coinBalanceKey.currentContext?.findRenderObject() as RenderBox?;
                                        final RenderBox? unlockButtonBox = _unlockButtonKeys[index]?.currentContext?.findRenderObject() as RenderBox?;
                                        
                                        if (coinBalanceBox != null && unlockButtonBox != null) {
                                          final coinBalancePosition = coinBalanceBox.localToGlobal(Offset.zero) + const Offset(50, -30);
                                          final unlockButtonPosition = unlockButtonBox.localToGlobal(Offset.zero) + const Offset(50, -30);
                                          
                                          showDialog(
                                            context: context,
                                            barrierColor: Colors.transparent,
                                            builder: (context) => CoinAnimation(
                                              startPosition: coinBalancePosition,
                                              endPosition: unlockButtonPosition,
                                              coinCount: chapter.unlockCost,
                                              onComplete: () {
                                                Navigator.pop(context);
                                                context.read<BookBloc>().add(UnlockChapter(chapter.id));
                                              },
                                            ),
                                          );
                                        } else {
                                          context.read<BookBloc>().add(UnlockChapter(chapter.id));
                                        }
                                      }
                                    : null,
                                child: Text('${chapter.unlockCost} coins'),
                              ),
                        onTap: chapter.isUnlocked
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookReaderScreen(
                                      book: state.book,
                                      initialChapterIndex: index,
                                    ),
                                  ),
                                );
                              }
                            : null,
                      ),
                    );
                  },
                ),
              ],
            ),
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
} 