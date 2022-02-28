part of 'shared.dart';

Future<File> getImage() async {
  File image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);
  StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
  StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  return downloadUrl;
}
