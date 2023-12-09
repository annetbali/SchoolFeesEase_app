import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_fees_ease/models/payment_model.dart';
import 'package:school_fees_ease/services/payment_service.dart';

import '../core/state.dart';

final allPaymentsProvider =
    StateNotifierProvider<_AllStudentsNotifier, AppState<List<PaymentModel>>>(
        (ref) {
  return _AllStudentsNotifier();
});

class _AllStudentsNotifier extends StateNotifier<AppState<List<PaymentModel>>> {
  _AllStudentsNotifier() : super(AppState(status: Status.initial, data: [])) {
    _getStudents();
  }
  _getStudents() async {
    state = state.copyWith(status: Status.loading);
    var data = await PaymentService.getPayments();
    data.fold((l) => state = state.copyWith(status: Status.error, message: l),
        (r) => state = state.copyWith(status: Status.loaded, data: r));
  }
}

// final getStudentProvider =
//     StateNotifierProvider<_GetStudentNotifier, AppState<PaymentModel>>((ref) {
//   return _GetStudentNotifier();
// });

// class _GetStudentNotifier extends StateNotifier<AppState<PaymentModel>> {
//   _GetStudentNotifier() : super(AppState(status: Status.initial));
//   getStudent(String id) async {
//     state = state.copyWith(status: Status.loading);
//     var data = await PaymentService.getPayments(id: id);
//     data.fold((l) => state = AppState(status: Status.error, message: l),
//         (r) => state = state.copyWith(status: Status.loaded, data: r));
//   }
// }

final paymentCRUDProvider =
    StateNotifierProvider<_StudentCRUDNotifier, AppState<String>>((ref) {
  return _StudentCRUDNotifier();
});

class _StudentCRUDNotifier extends StateNotifier<AppState<String>> {
  _StudentCRUDNotifier() : super(AppState(status: Status.initial));

  addPayment(PaymentModel paymentModel) async {
    state = state.copyWith(status: Status.loading);
    var data = await PaymentService.addPayment(paymentModel);
    data.fold((l) => state = state.copyWith(status: Status.error, message: l),
        (r) => state = state.copyWith(status: Status.loaded, data: r));
  }

  deletePayment({required String id}) async {
    state = state.copyWith(status: Status.loading);
    var data = await PaymentService.deletePayment(
      id: id,
    );
    data.fold((l) => state = state.copyWith(status: Status.error, message: l),
        (r) => state = state.copyWith(status: Status.loaded, data: r));
  }
}
