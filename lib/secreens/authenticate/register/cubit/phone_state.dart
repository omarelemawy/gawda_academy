part of 'phone_cubit.dart';

@immutable
abstract class PhoneState {}

class PhoneInitial extends PhoneState {}

class ChangeLoadingState extends PhoneState {}

class ChangeTimeState extends PhoneState {}
class ChangeStateOfTimeState extends PhoneState {}


