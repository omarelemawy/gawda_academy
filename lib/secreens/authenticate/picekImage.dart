// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';
// import 'package:vanillia/constants/constans.dart';
// import 'package:vanillia/constants/themes.dart';
// import 'package:vanillia/localization/language_constants.dart';
// import 'package:vanillia/model/user.dart';
// import 'package:vanillia/screenes/wrapper/home/home.dart';
// import 'package:vanillia/services/database.dart';
// import 'package:vanillia/services/helper.dart';
// import 'package:image_cropper/image_cropper.dart';

// class UserImagePicker extends StatefulWidget {
//   @override
//   _UserImagePickerState createState() => _UserImagePickerState();
// }

// class _UserImagePickerState extends State<UserImagePicker> {
//   final picker = ImagePicker();
//   File _imageFile;
//   String _currentImageUrl;

//   // Future pickImage() async {
//   //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
//   //   setState(() {
//   //     _imageFile = File(pickedFile.path);
//   //   });
//   // }

//   Future uploadImage(BuildContext context) async {
//     String fileName = basename(_imageFile.path);
//     StorageReference storageReference =
//         FirebaseStorage.instance.ref().child('images/$fileName');
//     StorageUploadTask uploadTask = storageReference.putFile(_imageFile);
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//     taskSnapshot.ref.getDownloadURL().then((val) {
//       print('Dome:$val');
//       setState(() {
//         _currentImageUrl = val;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<User>(context);
//     return Scaffold(
//       backgroundColor: customColor,
//       body: StreamBuilder<Users>(
//         stream: DatabaseServices(userId: user.uid).userData,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             Users userData = snapshot.data;
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         height: 150,
//                         width: 150,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               spreadRadius: 2,
//                               blurRadius: 10,
//                               color: Colors.black.withOpacity(0.1),
//                               offset: Offset(0, 10),
//                             ),
//                           ],
//                           border: Border.all(
//                             color: Colors.white,
//                             width: 3,
//                           ),
//                         ),
//                         child: CircleAvatar(
//                           radius: 55,
//                           backgroundColor: Colors.white,
//                           child: ClipOval(
//                             child: SizedBox(
//                               height: 150,
//                               width: 150,
//                               child: (_imageFile != null)
//                                   ? Image.file(
//                                       _imageFile,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Image(
//                                       image: NetworkImage(
//                                         UserData.userImageUrl,
//                                       ),
//                                       fit: BoxFit.cover,
//                                     ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: GestureDetector(
//                           onTap: () {
//                             _showPickOptionsDialog(context);
//                           },
//                           child: Container(
//                             height: 35,
//                             width: 35,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: customColor,
//                               border: Border.all(
//                                 color: Colors.white,
//                                 width: 2,
//                               ),
//                             ),
//                             child: Icon(
//                               Icons.edit,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: RaisedButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           color: Colors.white,
//                           child: Text(
//                             getTranslated(context, 'save'),
//                             style: AppTheme.heading.copyWith(
//                               color: customColor,
//                             ),
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               DBHelper.saveUserselectedProImage(true);
//                             });
//                             DatabaseServices(userId: user.uid).updateUserData(
//                               userData.phoneNumber,
//                               userData.name,
//                               userData.email,
//                               _currentImageUrl ?? userData.userImageUrl,
//                             );

//                             Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                 builder: (_) => Home(),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: FlatButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             side: BorderSide(
//                               width: 1,
//                               color: Colors.white,
//                             ),
//                           ),
//                           child: Text(
//                             getTranslated(context, 'skip'),
//                             style: AppTheme.heading.copyWith(
//                               color: Colors.white,
//                             ),
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               DBHelper.saveUserselectedProImage(true);
//                             });
//                             Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                 builder: (_) => Home(),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   _loadPicker(ImageSource source, BuildContext context) async {
//     // ignore: deprecated_member_use
//     File picked = await ImagePicker.pickImage(source: source);
//     if (picked != null) {
//       _cropImage(picked, context);
//     }
//     Navigator.of(context).pop();
//   }

//   _cropImage(File picked, BuildContext context) async {
//     File cropped = await ImageCropper.cropImage(
//       androidUiSettings: AndroidUiSettings(
//         statusBarColor: Colors.red,
//         toolbarColor: Colors.red,
//         toolbarTitle: "Crop Image",
//         toolbarWidgetColor: Colors.white,
//       ),
//       sourcePath: picked.path,
//       aspectRatioPresets: [
//         CropAspectRatioPreset.original,
//         CropAspectRatioPreset.ratio16x9,
//         CropAspectRatioPreset.ratio4x3,
//       ],
//       maxWidth: 800,
//     );
//     if (cropped != null) {
//       setState(() {
//         _imageFile = cropped;
//         uploadImage(context);
//       });
//     }
//   }

//   void _showPickOptionsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             ListTile(
//               title: Text("Pick from Gallery"),
//               onTap: () {
//                 _loadPicker(ImageSource.gallery, context);
//               },
//             ),
//             ListTile(
//               title: Text("Take a pictuer"),
//               onTap: () {
//                 _loadPicker(ImageSource.camera, context);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
