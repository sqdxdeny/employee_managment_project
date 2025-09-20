import 'package:equatable/equatable.dart';
import 'package:uuid/v1.dart';

class Request extends Equatable {
  final UuidV1 id;
  final UuidV1 profileId;
  final UuidV1 recipientId;
  final String title;
  final String description;
  final DateTime date;
  final RequestsSort type;

  Request({
    UuidV1? id,
    required this.profileId,
    required this.recipientId,
    required this.title,
    required this.description,
    required this.date,
    required this.type,
  }) : id = id ?? UuidV1();

  Request copyWith({
    UuidV1? profileId,
    UuidV1? recipientId,
    String? title,
    String? description,
    DateTime? date,
    RequestsSort? type,
  }) {
    return Request(
      id: id,
      profileId: profileId ?? this.profileId,
      recipientId: recipientId ?? this.recipientId,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
    id,
    profileId,
    recipientId,
    title,
    description,
    date,
    type,
  ];
}

enum RequestsSort {
  all,
  social,
  private,
}
