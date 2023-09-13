import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:university/features/AllFeatures/presentation/base/base_view_model.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';

import '../../../../domain/entites/onboarding_model/slider_object.dart';
import '../../../../domain/entites/onboarding_model/slider_view_object.dart';

class OnBoardingVM extends BaseVM with OnBoardingVMInputs, OnBoardingVMOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int currentPageIndex = 0;
  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  int goNext() {
    int previousIndex = ++currentPageIndex;
    // if (previousIndex == _list.length) {
    //   previousIndex = 0;
    // }
    return previousIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --currentPageIndex;
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
    currentPageIndex = pageIndex;
    print('+++============== $currentPageIndex');
    _postDataToView();
  }

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
      sliderObject: _list[currentPageIndex],
      slidesCount: _list.length,
      curretPageIndex: currentPageIndex,
    ));
  }

  @override
  // TODO: implement outputSliderViewObjeect
  Stream<SliderViewObject> get outputSliderViewObjeect =>
      _streamController.stream.map((slider) => slider);

  List<SliderObject> _getSliderData() => [
        SliderObject(ImageAssets.imageOne, "onBoarding1"),
        SliderObject(ImageAssets.imageTow, "onBoarding2"),
        SliderObject(ImageAssets.imageThree, "onBoarding3"),
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
