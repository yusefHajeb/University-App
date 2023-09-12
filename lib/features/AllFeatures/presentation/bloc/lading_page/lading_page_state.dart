part of '../lading_page/lading_page_bloc.dart';

class LadingPageState extends Equatable {
  final int tabIndex;
  const LadingPageState({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

class LadingPageInitial extends LadingPageState {
  LadingPageInitial({required super.tabIndex});
}
