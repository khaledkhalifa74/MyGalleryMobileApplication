import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_gallery/core/utils/assets.dart';
import 'package:my_gallery/core/widgets/custom_loading_indicator.dart';
import 'package:my_gallery/features/Authentication/presentation/views/widgets/custom_button.dart';
import 'package:my_gallery/features/Authentication/presentation/views/widgets/custom_text_field_with_title.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  FToast fToast = FToast();
  bool isLoading = false;
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top],
    );
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AssetsData.loginBGImage),
            fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Form(
          key: _loginFormKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                    validator: (data){
                      if (data!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if(!data.contains('@') || !data.contains('com')){
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    controller: emailController,
                    placeholder: 'User Name',
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    obscureText: true,
                    controller: passwordController,
                    placeholder: 'Password',
                    validateMessage: 'Please enter your password',
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                  isLoading ? const Center(child: CustomLoadingIndicator())
                      : CustomButton(
                        text: 'Submit',
                        itemCallBack: ()async {
                          if (_loginFormKey.currentState!.validate()) {
                            // BlocProvider.of<AuthCubit>(context).loginUser(
                            //     email: emailController.text.toString(),
                            //     password: passwordController.text.toString());
                            // isLoading = false;
                          }else{}
                        },
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
