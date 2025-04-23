import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:leaf_scan/init.main.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoadingState());
      final userCredentials = await serviceLocator<FirebaseAuth>()
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredentials.user == null) {
        emit(LoginFailureState(message: "Invalid User Credentials."));
        return;
      }
      final box = serviceLocator<Box<String>>();
      box.put("user_id", userCredentials.user!.uid);
      box.put("user_email", userCredentials.user!.email!);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(
        LoginFailureState(
          message: e.toString(),
        ),
      );
    } catch (_) {
      emit(
        LoginFailureState(
          message: "Exception While Communicating With The Server.",
        ),
      );
    }
  }
}
