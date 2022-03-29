import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/views/show_details_screen/components/reviews.dart';
import 'package:tv_shows/views/write_reviews_screen/write_reviews_screen.dart';

import '../../models/review_provider.dart';
import '../../net/network_repository.dart';

class ShowDetailsScreen extends StatefulWidget {
  Show show;

  ShowDetailsScreen({Key? key, required this.show}) : super(key: key);

  @override
  State<ShowDetailsScreen> createState() => _ShowDetailsScreenState();
}

class _ShowDetailsScreenState extends State<ShowDetailsScreen> {
  static const _kBasePadding = 0.0;
  static const kExpandedHeight = 110.0;

  final ValueNotifier<double> _titlePaddingNotifier = ValueNotifier(_kBasePadding);

  final _scrollController = ScrollController();

  double get _horizontalTitlePadding {
    const kCollapsedPadding = 30.0;
    if (_scrollController.hasClients) {
      return min(_kBasePadding + kCollapsedPadding,
          _kBasePadding + (kCollapsedPadding * _scrollController.offset) / (kExpandedHeight - kToolbarHeight));
    }

    return _kBasePadding;
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });

    var reviewProvider = new ReviewProvider();

    var api = Provider.of<NetworkRepository>(context);

    api.fetchShowReviews(widget.show.id).then((reviews) => reviewProvider.addMany(reviews));

    return Scaffold(
      bottomSheet: Container(
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, -3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.5)),
              height: double.infinity,
              minWidth: double.infinity,
              color: const Color(0xff52368C),
              child: const Text(
                "Write a review",
                style: TextStyle(fontFamily: 'Roboto', fontSize: 17, color: Colors.white),
              ),
              onPressed: () => {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
                        context: context,
                        builder: (context) {
                          return WriteReviews(widget.show.id, reviewProvider);
                        })
                  }),
        ),
      ),
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 4,
                  expandedHeight: kExpandedHeight,
                  floating: false,
                  pinned: true,
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                      onPressed: () => Navigator.of(context).pop()),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: false,
                    titlePadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    title: ValueListenableBuilder(
                      valueListenable: _titlePaddingNotifier,
                      builder: (context, value, child) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: value as double),
                          child: Text(
                            widget.show.title,
                            style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ))
            ];
          },
          body: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 100),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: (widget.show.imageUrl != null ? Image.network(widget.show.imageUrl!) : null),
                      ),
                      Text(
                        widget.show.description,
                        style: const TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      ChangeNotifierProvider(create: (context) => reviewProvider, child: Reviews(show: widget.show))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
