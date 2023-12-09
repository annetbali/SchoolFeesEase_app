import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../main.dart';
import '../models/payment_model.dart';

class PaymentService {
  static Future<Either<String, List<PaymentModel>>> getPayments() async {
    try {
      List<PaymentModel> dataList = [];
      var responseData = await fireStore.collection('Payments').get();
      for (var element in responseData.docs) {
        dataList.add(PaymentModel.fromMap(element.data()));
      }
      return Right(dataList);
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, String>> addPayment(
      PaymentModel paymentModel) async {
    try {
      await fireStore
          .collection('Payments')
          .doc(paymentModel.id)
          .set(paymentModel.toMap());
      return const Right('Payment added successfully !!!');
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  // static Future<Either<String, PaymentModel>> getStudent(
  //     {required String id}) async {
  //   try {
  //     var response = await fireStore.collection('Students').doc(id).get();
  //     if (response.data() != null) {
  //       return Right(PaymentModel.fromMap(response.data()!));
  //     }
  //     return const Left('No student found');
  //   } on FirebaseException catch (e) {
  //     return Left(e.message ?? e.toString());
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }

  static Future<Either<String, String>> deletePayment(
      {required String id}) async {
    try {
      await fireStore.collection('Payments').doc(id).delete();
      return const Right('Payment deleted successfully !!!');
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
