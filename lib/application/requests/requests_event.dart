part of 'requests_bloc.dart';

sealed class RequestsEvent {
  const RequestsEvent();

  const factory RequestsEvent.loadRequests() = _LoadRequests;

  const factory RequestsEvent.updateRequest(Request request) = _UpdateRequest;

  const factory RequestsEvent.addRequest(Request request) = _AddRequest;

  const factory RequestsEvent.deleteRequest(UuidV1 id) = _DeleteRequest;

  const factory RequestsEvent.setSort (RequestsSort sort) = _SetSort;
}

class _LoadRequests extends RequestsEvent {
  const _LoadRequests();
}

class _UpdateRequest extends RequestsEvent {
  final Request request;

  const _UpdateRequest(this.request);
}

class _AddRequest extends RequestsEvent {
  final Request request;

  const _AddRequest(this.request);
}

class _DeleteRequest extends RequestsEvent {
  final UuidV1 id;
  const _DeleteRequest(this.id);
}

class _SetSort extends RequestsEvent {
  final RequestsSort sort;
  const _SetSort(this.sort);
}