import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/item_news/item_news.dart';
import 'package:news_app/cubit/news_cubit/news_cubit.dart';
import 'package:news_app/cubit/news_cubit/news_state.dart';

class ScienceScreen extends StatefulWidget {
  const ScienceScreen({super.key});

  @override
  State<ScienceScreen> createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> listScience = [];
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getData(category: "business"),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {
          if (state is GetDataSuccessState) {
            listScience = state.business;
            print("######################${state.business.length}");
          }
        },
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return ConditionalBuilder(
            condition: state is GetDataSuccessState,
            builder: (context) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => ItemNews(list: listScience ,index: index),
                itemCount: listScience.length,
                scrollDirection: Axis.vertical,
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
          //  return ItemNews();
        },
      ),
    );
  }
}