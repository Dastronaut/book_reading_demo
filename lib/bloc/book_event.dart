import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object?> get props => [];
}

class LoadBook extends BookEvent {}

class UnlockChapter extends BookEvent {
  final int chapterId;

  const UnlockChapter(this.chapterId);

  @override
  List<Object?> get props => [chapterId];
} 