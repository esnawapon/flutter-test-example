import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

final _dateFormat = DateFormat("d MMM yyyy HH:mm");

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime updated;

  String get displayUpdated => _dateFormat.format(updated);

  const Note({
    this.id = "",
    this.title = "",
    this.content = "",
    required this.updated,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? updated,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "updated": updated.millisecondsSinceEpoch,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      updated: json["updated"] == null //
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(json["updated"]),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        updated,
      ];
}
