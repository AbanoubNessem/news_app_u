
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit/news_cubit.dart';
import 'package:news_app/cubit/news_cubit/news_state.dart';
import 'package:news_app/screens/search_screen/search_screen.dart';

class NewsLayout extends StatefulWidget {
  const NewsLayout({super.key});
  static String nameRoute = "NewsLayoutRoute";
  @override
  State<NewsLayout> createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder:(context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("News App"),
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, SearchScreen.nameRoute);
                  },
                  child: Icon(Icons.search_outlined,color: Theme.of(context).iconTheme.color,size:Theme.of(context).iconTheme.size,)
              ),
              SizedBox(width: 30,),
              InkWell(
                onTap: () {
                  NewsCubit.get(context).changeThemeMode();
                  print(NewsCubit.get(context).isDark);
                },
                child: NewsCubit.get(context).isDark
                    ? Icon(Icons.dark_mode_outlined,color:Theme.of(context).iconTheme.color,size:Theme.of(context).iconTheme.size ,)
                    : Icon(Icons.light_mode_outlined,color:Theme.of(context).iconTheme.color,size:Theme.of(context).iconTheme.size ,),
              ),
              SizedBox(width: 30,),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              items:NewsCubit.get(context).tabs,
            currentIndex: cubit.currentIndex,
            onTap: (value) {
                cubit.changeCurrentIndex(value);
            },
          ),
          body: cubit.screensTabs[cubit.currentIndex],
        );
      },
    );
  }
}
