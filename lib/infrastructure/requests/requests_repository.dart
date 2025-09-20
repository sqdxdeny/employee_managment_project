import 'package:employee_managment_project/domain/requets/request.dart';
import 'package:uuid/v1.dart';

final requestsRep = RequestsRepository();

class RequestsRepository {
  List<Request> _requests = [
    Request(
      profileId: UuidV1(),
      recipientId: UuidV1(),
      title: "Запрос на подключение",
      description: "Хотел бы получить доступ к системе",
      date: DateTime(2024, 1, 15, 14, 30),
      type: RequestsSort.social,
    ),
    Request(
      profileId: UuidV1(),
      recipientId: UuidV1(),
      title: "Техническая поддержка",
      description: "Проблема с авторизацией в приложении",
      date: DateTime(2024, 1, 16, 9, 15),
      type: RequestsSort.private,
    ),
    Request(
      profileId: UuidV1(),
      recipientId: UuidV1(),
      title: "Общий запрос",
      description: "Нужна информация о услугах",
      date: DateTime(2024, 1, 17, 16, 45),
      type: RequestsSort.social,
    ),
  ];

  Future<List<Request>> loadRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_requests);
  }

  Future<void> addRequest(Request request) async {
    _requests = [..._requests, request];
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  Future<void> updateRequest(Request request) async {
    _requests = _requests.map((e) => e.id == request.id ? request : e).toList();
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  Future<void> deleteRequest(UuidV1 id) async {
    _requests = _requests.where((e) => e.id != id).toList();
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }
}