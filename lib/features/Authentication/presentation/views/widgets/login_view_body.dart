import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_gallery/core/utils/assets.dart';
import 'package:my_gallery/core/utils/cashe_helper.dart';
import 'package:my_gallery/core/utils/functions/custom_toast.dart';
import 'package:my_gallery/core/utils/styles.dart';
import 'package:my_gallery/core/widgets/custom_loading_indicator.dart';
import 'package:my_gallery/features/Authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:my_gallery/features/Authentication/presentation/manager/auth_cubit/auth_state.dart';
import 'package:my_gallery/features/Authentication/presentation/views/widgets/custom_button.dart';
import 'package:my_gallery/features/Authentication/presentation/views/widgets/custom_text_field_with_title.dart';
import 'package:my_gallery/features/Gallery/presentation/views/gallery_view.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  FToast fToast = FToast();
  bool isLoading = false;
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    userNameController.dispose();
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
    return BlocConsumer<AuthCubit,AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          showCustomToast(fToast, 'Login successfully', false);
          if (kDebugMode) {
            print(state.loginModel.token);
          }
          CasheHelper.saveData(
            key: 'token',
            value: state.loginModel.token,
          ).then(
                (value) =>
                Navigator.pushReplacementNamed(context, GalleryView.id),
          );
          isLoading = false;
        } else if (state is LoginFailure) {
          showCustomToast(fToast, state.errorMessage, true);
          isLoading = false;
        }
      },
      builder: (context, state)
      => Container(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height *.25,
                    ),
                    Text(
                      'Log in',
                      style: Styles.textStyle30,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextFormField(
                      width: MediaQuery.of(context).size.width * 0.75,
                      validator: (data){
                        if (data!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if(!data.contains('@')){
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      controller: userNameController,
                      placeholder: 'User Name',
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTextFormField(
                      width: MediaQuery.of(context).size.width * 0.75,
                      obscureText: true,
                      controller: passwordController,
                      placeholder: 'Password',
                      validateMessage: 'Please enter your password',
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    isLoading ? const Center(child: CustomLoadingIndicator())
                        : CustomButton(
                      width: MediaQuery.of(context).size.width * 0.75,
                      text: 'Submit',
                      itemCallBack: ()async {
                        if (_loginFormKey.currentState!.validate()) {
                          AuthCubit.get(context).loginUser(
                            email: userNameController.text,
                            password: passwordController.text,
                          );
                          isLoading = false;
                        }else{}
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
