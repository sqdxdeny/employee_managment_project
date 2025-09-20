import 'dart:async';
import 'dart:collection';

import 'package:employee_managment_project/domain/requets/request.dart';
import 'package:employee_managment_project/infrastructure/requests/requests_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/v1.dart';

part 'requests_event.dart';

part 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  RequestsBloc() : super(RequestsState.initial()) {
    on<_LoadRequests>(_loadRequests);
    on<_AddRequest>(_addRequest);
    on<_UpdateRequest>(_updateRequest);
    on<_DeleteRequest>(_deleteRequest);
    on<_SetSort>(_setSort);
    add(RequestsEvent.loadRequests());
  }

  Future<void> _loadRequests(_LoadRequests event, Emitter<RequestsState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final loaded = await requestsRep.loadRequests();
    // новый UnmodifiableListView
    final newRequests = UnmodifiableListView(loaded);
    emit(
      state.copyWith(
        isLoading: false,
        requests: newRequests,
      ),
    );
  }

  Future<void> _addRequest(_AddRequest event, Emitter<RequestsState> emit) async {
    emit(state.copyWith(isLoading: true));
    await requestsRep.addRequest(event.request);
    final updatedRequests = List<Request>.from(state.requests)..add(event.request);
    emit(state.copyWith(isLoading: false, requests: UnmodifiableListView(updatedRequests)));
  }

  Future<void> _updateRequest(_UpdateRequest event, Emitter<RequestsState> emit) async {
    emit(state.copyWith(isLoading: true));
    await requestsRep.updateRequest(event.request);
    final updatedRequests = state.requests.map((request) => request.id == event.request.id ? event.request : request);
    emit(state.copyWith(isLoading: false, requests: UnmodifiableListView(updatedRequests)));
  }

  Future<void> _deleteRequest(_DeleteRequest event, Emitter<RequestsState> emit) async {
    emit(state.copyWith(isLoading: true));
    await requestsRep.deleteRequest(event.id);
    final updatedRequests = state.requests.where((request) => request.id != event.id);
    emit(state.copyWith(isLoading: false, requests: UnmodifiableListView(updatedRequests)));
  }

  void _setSort(_SetSort event, Emitter<RequestsState> emit) {
    emit(state.copyWith(sort: event.sort));
  }
}
