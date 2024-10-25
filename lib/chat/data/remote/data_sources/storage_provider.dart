import 'dart:io';

class StorageProviderRemoteDataSource {
  //static FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadFile({required File file}) async {
    // final imageUrl = basename(file.path);
    // final ref = _storage.PostRequsetWithFile(
    //     linkUplodeNode,
    //     {
    //       "t_id": '${int.parse(preferences.getString("id")!)}',
    //       "imageUrl": imageUrl
    //     },
    //     file);
    // // preferences.setString("image_profile", imageUrl);
    // return imageUrl;
    return await "imageUrl";
  }

  static String getNameOnly(String path) {
    return path.split('/').last.split('%').last.split("?").first;
  }
}
