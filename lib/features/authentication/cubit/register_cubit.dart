import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:leaf_scan/init.main.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      emit(RegisterLoadingState());
      final userCredentials =
          await serviceLocator<FirebaseAuth>().createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredentials.user == null) {
        emit(RegisterFailureState(message: "Invalid User Credentials."));
      }
      await serviceLocator<FirebaseFirestore>()
          .collection("Users")
          .doc(userCredentials.user!.uid)
          .set({
        "user_id": userCredentials.user!.uid,
        "user_name": userName,
        "user_email": email,
      });
      final box = serviceLocator<Box<String>>();
      box.put("user_name", userName);
      box.put("user_id", userCredentials.user!.uid);
      box.put("user_email", userCredentials.user!.email!);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(
        RegisterFailureState(
          message: e.toString(),
        ),
      );
    } catch (_) {
      emit(
        RegisterFailureState(
          message: "Exception While Communicating With The Server.",
        ),
      );
    }
  }
}
