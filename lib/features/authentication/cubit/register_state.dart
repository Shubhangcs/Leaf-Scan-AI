part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterFailureState extends RegisterState {
  final String message;
  RegisterFailureState({required this.message});
}

final class RegisterSuccessState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}
