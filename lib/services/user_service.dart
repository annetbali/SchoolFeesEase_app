import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_fees_ease/main.dart';
import 'package:school_fees_ease/models/user_model.dart';

class UserService {
  static Future<Either<String, UserModel>> login(
      String email, String password) async {
    try {
      var userCredentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      var userData = await fireStore
          .collection('Users')
          .doc(userCredentials.user?.uid)
          .get();
      if (userData.data() != null) {
        return Right(UserModel.fromMap(userData.data()!));
      } else {
        return const Left('user not found');
      }
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.toString());
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, String>> passwordRecovery(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return const Right('Password recovery email sent successfully!!!');
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.toString());
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, UserModel>> getUserData() async {
    try {
      var userData =
          await fireStore.collection('Users').doc(auth.currentUser?.uid).get();
      if (userData.data() != null) {
        return Right(UserModel.fromMap(userData.data()!));
      } else {
        return const Left('user not found');
      }
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.toString());
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, UserModel>> register(
      {required String email,
      required String password,
      required String contact,
      required String username}) async {
    try {
      var userCredentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await fireStore.collection('Users').doc(userCredentials.user!.uid).set(
          UserModel(
                  id: userCredentials.user!.uid,
                  name: username,
                  userRole: UserRole.parent,
                  contact: contact,
                  email: email)
              .toMap());
      return Right(UserModel(
          id: userCredentials.user!.uid,
          name: username,
          contact: contact,
          userRole: UserRole.parent,
          email: email));
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.toString());
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, String>> updateUser(
      {required UserModel userModel}) async {
    try {
      await fireStore
          .collection('Users')
          .doc(userModel.id)
          .update(userModel.toMap());
      return const Right('User updated successfully!!!');
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.toString());
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, List<UserModel>>> allUser() async {
    try {
      List<UserModel> users = [];
      var response = await fireStore.collection('Users').get();
      for (var element in response.docs) {
        users.add(UserModel.fromMap(element.data()));
      }
      return Right(users);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.toString());
    } on FirebaseException catch (e) {
      return Left(e.message ?? e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
