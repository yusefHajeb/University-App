import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/generated/Links.dart';

part 'image_state.dart';

enum ImageStatus {
  initial,
  loading,
  loaded,
  selected, // حالة جديدة لتتتبع الصورة المحددة
  error,
}

class ImageCubit extends Cubit<ImageStatus> {
  String selectedImage = ''; // المتغير لتخزين الصورة المحددة
  String CurrntImage = '';
  ImageCubit() : super(ImageStatus.initial);

  Future<void> loadImage(String text, String linkImageRootImage) async {
    selectedImage = "$linkImageRootImage/$text";
    //  print(selectedImage);
    emit(ImageStatus.loaded);
  }

  Future<void> selectImage(String image) async {
    CurrntImage = "${Constants.linkImageRootImage}/$image";
    print(selectedImage);
    emit(ImageStatus.selected); // تحديث حالة الصورة المحددة
  }

  String retelectedImage() {
    return selectedImage;
  }

  String retImage() {
    return CurrntImage;
  }
}
