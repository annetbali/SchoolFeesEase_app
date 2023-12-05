import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../main.dart';
import '../models/school_model.dart';

class SchoolService {
  static Future<Either<String, List<SchoolModel>>> getSchools() async {
    try {
      List<SchoolModel> dataList = [];
      var responseData = await fireStore.collection('Schools').get();
      for (var element in responseData.docs) {
        dataList.add(SchoolModel.fromMap(element.data()));
      }
      return Right(dataList);
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, String>> addSchool(
      {required String name,
      required String address,
      required String bankName,
      required String accountNumber}) async {
    try {
      var docId = DateTime.now().millisecondsSinceEpoch.toString();
      await fireStore.collection('Schools').doc(docId).set(
          SchoolModel(
                  id: docId,
                  name: name,
                  address: address,
                  bankName: bankName,
                  accountNumber: accountNumber)
              .toMap());
      return const Right('School added successfully !!!');
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
  static Future<Either<String, String>> deleteSchool(
      {required String id}) async {
    try {
      await fireStore.collection('Schools').doc(id).delete();
      return const Right('School deleted successfully !!!');
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
