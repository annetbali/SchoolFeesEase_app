import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/state.dart';
import '../models/Student_model.dart';
import '../services/Students_service.dart';

final allStudentsProvider =
    StateNotifierProvider<_AllStudentsNotifier, AppState<List<StudentModel>>>(
        (ref) {
  return _AllStudentsNotifier();
});

class _AllStudentsNotifier extends StateNotifier<AppState<List<StudentModel>>> {
  _AllStudentsNotifier() : super(AppState(status: Status.initial, data: [])) {
    _getStudents();
  }
  _getStudents() async {
    state = state.copyWith(status: Status.loading);
    var data = await StudentsService.getStudents();
    data.fold((l) => state = state.copyWith(status: Status.error, message: l),
        (r) => state = state.copyWith(status: Status.loaded, data: r));
  }
}

final getStudentProvider =
    StateNotifierProvider<_GetStudentNotifier, AppState<StudentModel>>((ref) {
  return _GetStudentNotifier();
});

class _GetStudentNotifier extends StateNotifier<AppState<StudentModel>> {
  _GetStudentNotifier() : super(AppState(status: Status.initial));
  getStudent(String id) async {
    state = state.copyWith(status: Status.loading);
    var data = await StudentsService.getStudent(id: id);
    data.fold((l) => state = AppState(status: Status.error, message: l),
        (r) => state = state.copyWith(status: Status.loaded, data: r));
  }
}

final studentCRUDProvider =
    StateNotifierProvider<_StudentCRUDNotifier, AppState<String>>((ref) {
  return _StudentCRUDNotifier();
});

class _StudentCRUDNotifier extends StateNotifier<AppState<String>> {
  _StudentCRUDNotifier() : super(AppState(status: Status.initial));

  addStudent({
    required String name,
    required String level, 
    required String address
  }) async {
    state = state.copyWith(status: Status.loading);
    var data = await StudentsService.addStudent(
        name: name, address: address, level: level);
    data.fold((l) => state = state.copyWith(status: Status.error, message: l),
        (r) => state = state.copyWith(status: Status.loaded, data: r));
  }

  deleteStudent({required String id}) async {
    state = state.copyWith(status: Status.loading);
    var data = await StudentsService.deleteStudent(
      id: id,
    );
    data.fold((l) => state = state.copyWith(status: Status.error, message: l),
        (r) => state = state.copyWith(status: Status.loaded, data: r));
  }
}
