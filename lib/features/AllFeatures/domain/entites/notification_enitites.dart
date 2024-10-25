import 'package:equatable/equatable.dart';

class Notifications extends Equatable {
  final String? title;
  final String? content;
  final String? newsImage;
  final String? date;
  final bool? note;

  final String? image;
  Notifications(
      {this.note,
      this.title,
      this.newsImage,
      this.date,
      this.content,
      this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [title, content, newsImage, date, image, note];
}
