import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../main.dart';
import '../models/Student_model.dart';

class StudentsService {
  static Future<Either<String, List<StudentModel>>> getStudents() async {
    try {
      List<StudentModel> dataList = [];
      var responseData = await fireStore.collection('Students').get();
      for (var element in responseData.docs) {
        dataList.add(StudentModel.fromMap(element.data()));
      }
      return Right(dataList);
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, String>> addStudent(
      {required String name,
      required String address,
      required String level}) async {
    try {
      var docId = DateTime.now().millisecondsSinceEpoch.toString();
      await fireStore.collection('Students').doc(docId).set(
          StudentModel(id: docId, name: name, address: address, level: level)
              .toMap());
      return const Right('Student added successfully !!!');
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, StudentModel>> getStudent(
      {required String id}) async {
    try {
      var response = await fireStore.collection('Students').doc(id).get();
      if (response.data() != null) {
        return Right(StudentModel.fromMap(response.data()!));
      }
      return const Left('No student found');
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, String>> deleteStudent(
      {required String id}) async {
    try {
      await fireStore.collection('Students').doc(id).delete();
      return const Right('Student deleted successfully !!!');
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
