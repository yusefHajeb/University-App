part of '../lading_page/lading_page_bloc.dart';

class LadingPageEvent extends Equatable {
  const LadingPageEvent();

  @override
  List<Object> get props => [];
}

class TabChange extends LadingPageEvent {
  final int tabIndex;

  TabChange(this.tabIndex);
  List<Object> get props => [tabIndex];
}
