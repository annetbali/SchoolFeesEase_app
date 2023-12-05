import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_fees_ease/models/school_model.dart';

import '../core/state.dart';
import '../services/schools_service.dart';

final allSchoolsProvider =
    StateNotifierProvider<_AllSchoolsNotifier, AppState<List<SchoolModel>>>(
        (ref) {
  return _AllSchoolsNotifier();
});

class _AllSchoolsNotifier extends StateNotifier<AppState<List<SchoolModel>>> {
  _AllSchoolsNotifier() : super(AppState(status: Status.initial,data: [])) {
    _getSchools();
  }
  _getSchools() async {
    state = state.copyWith(status: Status.loading);
    var data = await SchoolService.getSchools();
    data.fold((l) => state = state.copyWith(status: Status.error, message: l),
        (r) => state = state.copyWith(status: Status.loaded, data: r));
  }
}

final schoolCRUDProvider =
    StateNotifierProvider<_SchoolCRUDNotifier, AppState<String>>(
        (ref) {
  return _SchoolCRUDNotifier();
});

class _SchoolCRUDNotifier extends StateNotifier<AppState<String>> {
  _SchoolCRUDNotifier() : super(AppState(status: Status.initial));

  addSchool({
    required String name,
    required String address,
    required String bankName,
    required String accountNumber,
  }) async {
    state = state.copyWith(status: Status.loading);
    var data = await SchoolService.addSchool(
        name: name,
        address: address,
        bankName: bankName,
        accountNumber: accountNumber);
    data.fold((l) => state = state.copyWith(status: Status.error, message: l),
        (r) => state = state.copyWith(status: Status.loaded, data: r));
  }
  deleteSchool({
    required String id
  }) async {
    state = state.copyWith(status: Status.loading);
    var data = await SchoolService.deleteSchool(
        id: id,);
    data.fold((l) => state = state.copyWith(status: Status.error, message: l),
        (r) => state = state.copyWith(status: Status.loaded, data: r));
  }
}
