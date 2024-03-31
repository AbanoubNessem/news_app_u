import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/item_news/item_news.dart';
import 'package:news_app/cubit/news_cubit/news_cubit.dart';
import 'package:news_app/cubit/news_cubit/news_state.dart';
import 'package:news_app/utility/app_colores.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static String nameRoute = "SearchRoute";

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    // List<dynamic> listSearch = [];
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // if (state is SearchSuccessState) {
        //   listSearch = state.search;
        //   print("######################${state.search.length}");
        // }
      },
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var listSearch = cubit.search;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height*0.06,
            title: TextFormField(
              enabled: true,

              controller: searchController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if(value!.isEmpty){
                  return "search must not be empty";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).cardColor,
                hintText: "Search",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),

              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: [
              InkWell(
                onTap: () {
                  cubit.searchData(searchController.text);
                },
                  child: Icon(Icons.search,color: Theme.of(context).iconTheme.color,size: Theme.of(context).iconTheme.size,)),
              SizedBox(width: 20,)
            ],
          ),
          body: ConditionalBuilder(
            condition: state is SearchSuccessState,
            builder: (context) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => ItemNews(list: listSearch ,index: index),
                itemCount: listSearch.length,
                scrollDirection: Axis.vertical,
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );

      },
    );

  }
}
