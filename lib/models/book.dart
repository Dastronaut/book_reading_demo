import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String title;
  final List<Chapter> chapters;
  final int coins;

  const Book({
    required this.title,
    required this.chapters,
    this.coins = 300,
  });

  @override
  List<Object?> get props => [title, chapters, coins];
}

class Chapter extends Equatable {
  final int id;
  final String title;
  final List<Page> pages;
  final bool isUnlocked;
  final int unlockCost;

  const Chapter({
    required this.id,
    required this.title,
    required this.pages,
    this.isUnlocked = false,
    required this.unlockCost,
  });

  Chapter copyWith({
    int? id,
    String? title,
    List<Page>? pages,
    bool? isUnlocked,
    int? unlockCost,
  }) {
    return Chapter(
      id: id ?? this.id,
      title: title ?? this.title,
      pages: pages ?? this.pages,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockCost: unlockCost ?? this.unlockCost,
    );
  }

  @override
  List<Object?> get props => [id, title, pages, isUnlocked, unlockCost];
}

class Page extends Equatable {
  final int number;
  final String content;

  const Page({
    required this.number,
    required this.content,
  });

  @override
  List<Object?> get props => [number, content];
} 