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

Widget generateDashedDivider(double width) {
  int n = width ~/ 5;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: const Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}
