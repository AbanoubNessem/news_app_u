import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit/news_cubit.dart';
import 'package:news_app/cubit/news_cubit/news_state.dart';
import 'package:news_app/utility/app_colores.dart';

class ItemNews extends StatelessWidget {
   List<dynamic> list;
   int index;


  ItemNews({
    super.key,
     required this.list,
     required this.index
  });

  @override
  Widget build(BuildContext context) {
        return  InkWell(
          onTap: () {
            // NewsCubit.get(context).LaunchUrl(list[index]["url"]);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration:  BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 100,
                  decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: list[index]['urlToImage'] == null
                              ? const NetworkImage('https://s.abcnews.com/images/US/abc_news_default_2000x2000_update_16x9_992.jpg',)
                              : NetworkImage(list[index]['urlToImage'],)
                        // image: const NetworkImage('https://s.abcnews.com/images/US/abc_news_default_2000x2000_update_16x9_992.jpg',)
                      )),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          list[index]['title'],
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          list[index]['publishedAt'],
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey))
                    ],
                  ),
                )
              ],
            ),
          ),
        );

  }
}
