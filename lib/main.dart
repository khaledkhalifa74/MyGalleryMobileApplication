import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_gallery/core/utils/api_service.dart';
import 'package:my_gallery/core/utils/cashe_helper.dart';
import 'package:my_gallery/core/utils/colors.dart';
import 'package:my_gallery/features/Authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:my_gallery/features/Authentication/presentation/views/login_view.dart';
import 'package:my_gallery/features/Gallery/presentation/manager/upload_image_cubit/upload_image_cubit.dart';
import 'package:my_gallery/features/Gallery/presentation/views/gallery_view.dart';
import 'package:my_gallery/simple_bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  ApiService.init();
  await CasheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child){
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AuthCubit()),
              BlocProvider(create: (context) => UploadImageCubit()),
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'MyGallery',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
                  useMaterial3: true,
                  textTheme: GoogleFonts.poppinsTextTheme(),
                  primaryColor: kPrimaryColor,
                ),
                initialRoute: LoginView.id,
                routes: {
                  LoginView.id: (context) => const LoginView(),
                  GalleryView.id: (context) => const GalleryView(),
                },
            ),
          );
        }
    );
  }
}
