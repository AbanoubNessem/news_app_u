import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:news_app/cubit/news_cubit/news_state.dart';
import 'package:news_app/screens/business_screen/business_screen.dart';
import 'package:news_app/screens/science_screen/science_screen.dart';
import 'package:news_app/screens/settings_screen/settings_screen.dart';
import 'package:news_app/screens/sports_screen/sports_screen.dart';
import 'package:news_app/services/cache_helper.dart';
import 'package:news_app/services/dio_helper.dart';
// import 'package:url_launcher/url_launcher.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> tabs = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_center_outlined),
      label: "business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_soccer_outlined),
      label: "Sports",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: "Science",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      label: "Settings",
    ),
  ];
  List<Widget> screensTabs = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen()
  ];
  int currentIndex = 0;
  List<dynamic> business = [];
  List<dynamic> search = [];

  bool isDark = false;

  void changeThemeMode({bool? themeApp}) {
    if (themeApp != null) {
      isDark = themeApp;
      emit(ChangeThemeModeSuccessState(isDark: isDark));
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: "themeMode", value: isDark);
      emit(ChangeThemeModeSuccessState(isDark: isDark));
    }
  }

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexState(index: index));
  }

  void getData({required String category}) {
    emit(GetDataLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "us",
      "category": category,
      "apikey": "65f7f556ec76449fa7dc7c0069f040ca",
    }).then((value) {
      business = value.data["articles"];
      print(business.length);
      print(business);
      emit(GetDataSuccessState(business: business));
    }).catchError((error) {
      print("GET ERROR IS $error");
      emit(GetDataErrorState(error: error));
    });
  }

  void searchData(String value) {
    emit(SearchLoadingState());
    DioHelper.getData(url: "v2/everything", query: {
      "q": value,
      "apikey": "65f7f556ec76449fa7dc7c0069f040ca",
    }).then((value) {
      search = value.data["articles"];
      print(search.length);
      print(search);
      emit(SearchSuccessState(search: search));
    }).catchError((error) {
      print("GET ERROR IS $error");
      emit(SearchErrorState(error: error));
    });
  }

  // Future<void> LaunchUrl(String _url)async {
  //   if (await canLaunchUrl(Uri.parse(_url))) {
  //     await launchUrl(Uri.parse(_url),);
  //   }else{
  //     throw 'Could not launch $_url';
  //   }
  //   emit(UrlLauncherState());
  // }

}
