import 'dart:async';

import 'package:university/features/AllFeatures/presentation/base/base_view_model.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';

import '../../../../domain/entites/onboarding_model/slider_object.dart';
import '../../../../domain/entites/onboarding_model/slider_view_object.dart';

class OnBoardingVM extends BaseVM with OnBoardingVMInputs, OnBoardingVMOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentPageIndex = 0;
  @override
  void start() {
    _list = _getSliderData();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  int goNext() {
    int previousIndex = ++_currentPageIndex;
    if (previousIndex == _list.length) {
      previousIndex = 0;
    }
    return previousIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentPageIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement inputState
  Sink get inputState => throw UnimplementedError();

  @override
  void onPageChanged(int pageIndex) {
    _currentPageIndex = pageIndex;
    _postDataToView();
  }

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
      sliderObject: _list[_currentPageIndex],
      slidesCount: _list.length,
      curretPageIndex: _currentPageIndex,
    ));
  }

  @override
  // TODO: implement outputSliderViewObjeect
  Stream<SliderViewObject> get outputSliderViewObjeect =>
      _streamController.stream.map((slider) => slider);
  List<SliderObject> _getSliderData() => [
        SliderObject(ImageAssets.imageOne, ""),
        SliderObject(ImageAssets.imageTow, ""),
        SliderObject(ImageAssets.imageThree, ""),
      ];
}

abstract class OnBoardingVMInputs {
  int goNext();
  int goPrevious();
  void onPageChanged(int pageIndex);
  Sink get inputSliderViewObject;
}

abstract class OnBoardingVMOutputs {
  Stream<SliderViewObject> get outputSliderViewObjeect;
}
