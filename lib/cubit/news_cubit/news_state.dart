abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class ChangeCurrentIndexState extends NewsStates {
  int index;

  ChangeCurrentIndexState({required this.index});
}

// class ChangeThemeModeLoadingState extends NewsStates {}

class ChangeThemeModeSuccessState extends NewsStates {
  bool isDark;

  ChangeThemeModeSuccessState({required this.isDark});
}

class GetDataLoadingState extends NewsStates {}

class GetDataSuccessState extends NewsStates {
  List<dynamic> business;

  GetDataSuccessState({required this.business});
}

class GetDataErrorState extends NewsStates {
  String error;

  GetDataErrorState({required this.error});
}
class SearchLoadingState extends NewsStates {}
// class UrlLauncherState extends NewsStates {}

class SearchSuccessState extends NewsStates {
  List<dynamic> search;

  SearchSuccessState({required this.search});
}

class SearchErrorState extends NewsStates {
  String error;

  SearchErrorState({required this.error});
}
