import 'dart:typed_data';

import 'package:cleanuppp/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/text_field_input.dart';
import '../resources/auth_methods.dart';
import '../util/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailcontroller.text,
      password: _passcontroller.text,
      username: _usernameController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 0,
              ),
              //img
              SvgPicture.asset(
                "images/logo.svg",
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              //circular widget for dp
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKEAAACUCAMAAADMOLmaAAAAM1BMVEW6urr////FxcW3t7f5+fn8/Pz29va9vb3Y2NjBwcHMzMzv7+/g4ODy8vLo6OjJycnS0tLmOy6DAAADXUlEQVR4nO2a67KjIAyAgYDIRfH9n3ZF22p76lEQg7Mn3+z+2E638w2XAEkYIwiCIAiCIAiCIAji7wLAmDYiWGuDMHr8oLbRGh39gu87yWdk1/sQP9S11V4I3yj+jmq8qK31ANjgRiE1KarH3/nfbrjBZANY9zl8q4F0Fio7gug39WZ6UVURQrMjyHkTaiq2r8W3Oc/jn7aeoN8dwBl/d8FairC3R9b0FdYitAmCnLf4ilb9vkXWxK9abEHTHBecvtkYXMG4CI8LTt/FXYpgE+yeWFTFlH38HMUe0Q+GjCHkfMAbRHBZhg7P0GQJco62neH4cfeOxxpE3WUadkjvFrApkXCNCjiGLO1EXoN1OqcHwydIIVE7lTfNSjmchWj23yZbIF0fRO5GGUcR55EfsgU5x9nMtzfMunk9QbmBnTKkWZ65/14+Ew+Rrg75p57DEbz/uZyYbViDdbcJct/lKxLrfsiy79hYgtnTjDXJ+sRbD6vAkpQ6XMDM3ASVlFeKKLx31ETOIGLmbeLZnHw4I53JTzLSDmgJhwfJeQesfMMLEDIpSyzxi2eJOUTE3OGimHKyVChWRI4r1qrsHR7FSiMYFe2RB0GDWwT4QOxntF3ddgdg7e/XWdlWb3UA4bcdpa/bQzAxHhWh/x67VR/YTVpuxrnu5z3z6mbhTV9/ftcAM4N3j6Yl2Tk/mFv5TUQhrY0xWrObtX0Rfwh4p7bOQpQBbYSwdhjamWGwVgijgVU3HQWEbX3vGvmj/1A2rvetFfUsYYqB3aM1cutFoGQ3xUb8NwAz1q+vXj9ep28fNN5iRvDY9hp88lvPB6TG2NFPt3mZ7KbVGI6g/YlMu9fXz3Xm+C3jeLGfzU2/LnQX9qiNE5xf7FlQl001hPhsOusY/7+7pnkXztTzPrnigQpDbo3iG7J8HmfOL5RYho9fKZ2HOFGH2qKoooYhoev1CPHnSk40GFlWcPo1acoppna9HlQsWF8pvwhnip2A+txRvE2pkn12Q+Q+hSoYumSofkcWGcQLQuFCkaCo8xqHj1Gk3S+7Z+AIJfoKxkkuHQrXFJjmzGr3UUpE7SuXYZE+9wtjTaRAvMntujjK+c5YcbHh+XoQGZIhGZIhGZIhGZIhGZIhGZIhGZIhGZLhf2n4D4LnLXAHOj/GAAAAAElFTkSuQmCC"),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo)))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Upload a Profile Picture"),
              ),

              const SizedBox(
                height: 30,
              ),
              //text field input for username
              TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: 'Enter Your Username',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              //textfield input for email
              TextFieldInput(
                  textEditingController: _emailcontroller,
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 24,
              ),
              //textfield input for password
              TextFieldInput(
                textEditingController: _passcontroller,
                hintText: 'Enter Your Password',
                textInputType: TextInputType.text,
                ispass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              //login button
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor,),
                        )
                      : const Text('Sign Up!'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
