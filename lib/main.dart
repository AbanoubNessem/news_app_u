import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Layouts/news_layout.dart';
import 'package:news_app/cubit/bloc_observer.dart';
import 'package:news_app/screens/search_screen/search_screen.dart';
import 'package:news_app/services/cache_helper.dart';
import 'package:news_app/services/dio_helper.dart';
import 'package:news_app/utility/app_colores.dart';

import 'cubit/news_cubit/news_cubit.dart';
import 'cubit/news_cubit/news_state.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolData(key: "themeMode");
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {

  final bool? isDark;

MyApp({super.key , required this.isDark});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..changeThemeMode(themeApp: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {
          // if(state is ChangeThemeModeSuccessState){
          //   // isDark = state.isDark;
          //   print(state.isDark);
          // }
        },
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            themeMode:NewsCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    backgroundColor: AppColores.primaryColorLight,
                    iconTheme: IconThemeData(
                        color: AppColores.blackColor
                    ),
                    titleTextStyle: TextStyle(
                        color: AppColores.primaryTextColorLight,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: AppColores.primaryColorLight,
                      statusBarIconBrightness: Brightness.dark
                    ),
                    elevation: 0.5),
                scaffoldBackgroundColor: AppColores.primaryColorLight,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  elevation: 100,
                  backgroundColor: AppColores.whiteColor,
                  selectedItemColor: AppColores.secondaryColorLight,
                  unselectedItemColor: AppColores.blackColor,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: false,
                  unselectedLabelStyle: TextStyle(
                    color: AppColores.blackColor,
                  ),
                  selectedLabelStyle: TextStyle(
                    color: AppColores.secondaryColorLight,
                  ),
                ),
                textTheme: TextTheme(
                    bodyMedium: TextStyle(color: AppColores.blackColor,fontSize: 18)),
              cardColor: AppColores.cartColor,
              iconTheme: IconThemeData(
                color: AppColores.blackColor,
                size: 30
              ),

            ),
            darkTheme: ThemeData(
                appBarTheme: const AppBarTheme(
                    backgroundColor: AppColores.primaryColorDark,
                    iconTheme: IconThemeData(
                      color: AppColores.whiteColor
                    ),
                    titleTextStyle: TextStyle(
                        color: AppColores.primaryTExtColorDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: AppColores.primaryColorDark,
                        statusBarIconBrightness: Brightness.light),
                    elevation: 0),
                scaffoldBackgroundColor: AppColores.primaryColorDark,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: AppColores.blackColor,
                  selectedItemColor: AppColores.secondaryColorDark,
                  unselectedItemColor: AppColores.whiteColor,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: false,
                  unselectedLabelStyle: TextStyle(
                    color: AppColores.whiteColor,
                  ),
                  selectedLabelStyle: TextStyle(
                    color: AppColores.secondaryColorDark,
                  ),
                ),
                textTheme: TextTheme(
                    bodyMedium: TextStyle(color: AppColores.whiteColor,fontSize: 18)),
                cardColor: AppColores.cartColorDark,
                iconTheme: IconThemeData(
                    color: AppColores.whiteColor,
                    size: 30.00
                )
            ),
            initialRoute:NewsLayout.nameRoute,
            routes: {
              NewsLayout.nameRoute : (context) => NewsLayout(),
              SearchScreen.nameRoute : (context) => SearchScreen(),
            },
          );
        },
      ),
    );
  }
}
