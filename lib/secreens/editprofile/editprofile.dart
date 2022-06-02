import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:elgawda_by_shay_b_haleb_new/services/UserData.dart';
import 'package:elgawda_by_shay_b_haleb_new/sharedPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool obscurePassword = true;
  String? mobile;
  String? email;
  String? name;
  String? password;
  getuserEmail() async {
    UserApp.userEmail = await MySharedPreferences.getUserUserEmail();
  }

  @override
  void initState() {
    getuserEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: StreamBuilder<Users>(
        stream: DatabaseServices(context: context, userToken: UserApp.userToken!)
            .userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Users? userData = snapshot.data;
            return SafeArea(
              child: ListView(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wrapper()),
                              (route) => false);
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'lib/images/left-arrow.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Center(
                        child: Text(
                          getTranslated(context, 'edit_profile').toString(),
                          style:
                              AppTheme.headingColorBlue.copyWith(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  UserPorfileImage(
                    userimgUrl: userData!.image,
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(context, 'name').toString(),
                          style:
                              AppTheme.headingColorBlue.copyWith(fontSize: 15),
                        ),
                        TextFormField(
                          initialValue: userData.name,
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });
                          },
                          decoration: textFormInpuofEidtProfile(
                              icon: Icons.edit, hintText: 'Name'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getTranslated(context, 'phone_numer')!,
                          style:
                              AppTheme.headingColorBlue.copyWith(fontSize: 15),
                        ),
                        TextFormField(
                          initialValue: userData.moblie,
                          keyboardType: TextInputType.phone,
                          onChanged: (val) {
                            setState(() {
                              mobile = val;
                            });
                          },
                          decoration: textFormInpuofEidtProfile(
                              hintText: 'Phone Number'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getTranslated(context, 'email')!,
                          style:
                              AppTheme.headingColorBlue.copyWith(fontSize: 15),
                        ),
                        TextFormField(
                          initialValue: (userData.email == null ||
                                  userData.email == 'null')
                              ? ""
                              : userData.email,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          decoration: textFormInpuofEidtProfile(
                              icon: Icons.edit, hintText: 'Email'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getTranslated(context, 'password')!,
                          style:
                              AppTheme.headingColorBlue.copyWith(fontSize: 15),
                        ),
                        TextFormField(
                          initialValue: UserApp.userPassword,
                          obscureText: obscurePassword,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          decoration: textFormInputDecorationForPassword(
                            Icons.visibility_off,
                            getTranslated(context, 'password')!,
                            () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            obscurePassword,
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: CustomButton(
                            onPress: () {
                              setState(() {
                                loading = !loading;
                              });
                              DatabaseServices(
                                      userToken: UserApp.userToken!,
                                      context: context)
                                  .upDateUserData(
                                email: (email != null)
                                    ? email!
                                    : (userData.email ==
                                            getTranslated(context, 'addEmail'))
                                        ? ''
                                        : userData.email,
                                name: (name != null) ? name! : userData.name,
                                mobile: (mobile != null)
                                    ? mobile!
                                    : (userData.moblie ==
                                            getTranslated(context, 'addPhone'))
                                        ? ''
                                        : userData.moblie,
                                password: (password != null) ? password! : '',
                                images: (UserPorfileImage.image),
                                context: context,
                              );
                            },
                            text: (loading)
                                ? getTranslated(context, 'saving')
                                : getTranslated(context, 'save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Center(
                child: SpinKitChasingDots(
                  color: customColor,
                  size: 20,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class UserPorfileImage extends StatefulWidget {
  static File? image;
  const UserPorfileImage({
    Key? key,
    // @required this.onTap,
    this.userimgUrl,
  }) : super(key: key);

  // final Function onTap;
  final String? userimgUrl;

  @override
  _UserPorfileImageState createState() => _UserPorfileImageState();
}

class _UserPorfileImageState extends State<UserPorfileImage> {
  final picker = ImagePicker();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    print(widget.userimgUrl == '');
    return InkWell(
      onTap: () {
        _showPickOptionsDialog(context);
      },
      child: Center(
        child: Stack(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: customColor,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.all(2),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipOval(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: (_imageFile != null)
                        ? Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          )
                        : (widget.userimgUrl == '' || widget.userimgUrl == null)
                            ? Image(
                                fit: BoxFit.cover,
                                image: AssetImage('lib/images/man.png'),
                              )
                            : customCachedNetworkImage(
                                context: context,
                                boxFit: BoxFit.cover,
                                url: widget.userimgUrl,
                              ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadPicker(ImageSource source, BuildContext context) async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      _cropImage(pickedFile, context);
    }
    Navigator.of(context).pop();
  }

  _cropImage(XFile? picked, BuildContext context) async {
    try {
      CroppedFile? cropped = await ImageCropper().cropImage(
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
        sourcePath: picked!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio4x3,
        ],
        maxWidth: 800,
      );
      if (cropped != null) {
        setState(() {
          _imageFile = File(cropped.path);
          UserPorfileImage.image = _imageFile;
        });
      }
    } catch (e) {
      print('piker error:' + e.toString());
    }
  }

  // ignore: unused_element
  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(getTranslated(context, 'Gallery')!),
              onTap: () {
                _loadPicker(ImageSource.gallery, context);
              },
            ),
            ListTile(
              title: Text(getTranslated(context, 'takepictuer')!),
              onTap: () {
                _loadPicker(ImageSource.camera, context);
              },
            )
          ],
        ),
      ),
    );
  }
}
