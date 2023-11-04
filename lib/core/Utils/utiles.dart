import 'package:image_picker/image_picker.dart';

imagePickar() async {
  ImagePicker _picker = ImagePicker();

  final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    return await file.readAsBytes();
  }
  print("no selected image");
}
