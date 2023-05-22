import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

import '../../domain/models/article.dart';
import '../../utils/extensions/scroll_controller.dart';
import '../cubits/remote_articles/cubit/remote_articles_cubit.dart';
import '../widgets/article_widget.dart';

@RoutePage()
class BreakingNewsView extends HookWidget {
  const BreakingNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remoteArticlesCubit = BlocProvider.of<RemoteArticlesCubit>(context);
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.onScrollEndsListener(() {
        remoteArticlesCubit.getBreakingNewsArticles();
      });

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily News',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<RemoteArticlesCubit, RemoteArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case RemoteArticlesLoading:
              return const Center(child: CupertinoActivityIndicator());
            case RemoteArticlesFailed:
              return const Center(
                child: Icon(Ionicons.refresh),
              );
            case RemoteArticlesSuccess:
              return _buildArticle(
                  scrollController, state.articles, state.noMoreData);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

Widget _buildArticle(ScrollController scrollController, List<Article> articles,
    bool noMoreData) {
  return CustomScrollView(
    controller: scrollController,
    slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ArticleWidget(article: articles[index]),
          childCount: articles.length,
        ),
      ),
      if (!noMoreData)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 14, bottom: 32),
            child: CupertinoActivityIndicator(),
          ),
        ),
    ],
  );
}
