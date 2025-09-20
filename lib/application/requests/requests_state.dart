part of 'requests_bloc.dart';

class RequestsState with EquatableMixin {
  final UnmodifiableListView<Request> requests;
  final bool isLoading;
  final RequestsSort sort;

  const RequestsState({
    required this.requests,
    required this.isLoading,
    required this.sort,
  });

  factory RequestsState.initial() => RequestsState(
    requests: UnmodifiableListView([]),
    isLoading: false,
    sort: RequestsSort.all,
  );

  RequestsState copyWith({
    UnmodifiableListView<Request>? requests,
    bool? isLoading,
    RequestsSort? sort,
  }) {
    return RequestsState(
      requests: requests ?? this.requests,
      isLoading: isLoading ?? this.isLoading,
      sort: sort ?? this.sort,
    );
  }

  @override
  List<Object?> get props => [
    requests,
    isLoading,
    sort,
  ];
}
