part of 'validate_bloc.dart';

class ValidateState extends Equatable {
  final bool isValid;
  const ValidateState({this.isValid = false});

  @override
  List<Object> get props => [];
}

class ValidateInitial extends ValidateState {}

// class ValidateFlageState extends ValidateState {}
