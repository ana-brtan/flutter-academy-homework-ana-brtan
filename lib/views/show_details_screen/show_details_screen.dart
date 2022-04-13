import 'dart:async';
import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/views/show_details_screen/components/reviews.dart';

import '../../models/review_provider.dart';
import '../write_reviews_screen/write_reviews_screen.dart';

class ShowDetailsScreen extends StatelessWidget {
  Show show;

  ShowDetailsScreen({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReviewProvider(context.read(), show.id),
      child: _ShowDetailsScreen(show: show),
    );
  }
}

class _ShowDetailsScreen extends StatefulWidget {
  Show show;

  _ShowDetailsScreen({Key? key, required this.show}) : super(key: key);

  @override
  State<_ShowDetailsScreen> createState() => _ShowDetailsScreenState();
}

class _ShowDetailsScreenState extends State<_ShowDetailsScreen> with SingleTickerProviderStateMixin {
  static const _kBasePadding = 0.0;
  static const kExpandedHeight = 110.0;

  final ValueNotifier<double> _titlePaddingNotifier = ValueNotifier(_kBasePadding);

  final _scrollController = ScrollController();
  late AnimationController animationController;

  double get _horizontalTitlePadding {
    const kCollapsedPadding = 30.0;
    if (_scrollController.hasClients) {
      return min(_kBasePadding + kCollapsedPadding,
          _kBasePadding + (kCollapsedPadding * _scrollController.offset) / (kExpandedHeight - kToolbarHeight));
    }

    return _kBasePadding;
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    animationController.forward();
    Timer(const Duration(milliseconds: 1000), () => animationController.forward());
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });

    return Scaffold(
      bottomSheet: BottomSheet(widget: widget, context: context, animationController: animationController),
      body: buildNestedScrollView(animationController),
    );
  }

  NestedScrollView buildNestedScrollView(AnimationController) {
    return NestedScrollView(
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
                          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
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
                    Hero(
                      tag: widget.show.imageUrl.toString(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: (widget.show.imageUrl != null ? Image.network(widget.show.imageUrl!) : null),
                      ),
                    ),
                    ShowDescription(widget: widget, animationController: animationController),
                    ReviewsWidget(widget: widget, animationController: animationController)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({Key? key, required this.widget, required this.animationController}) : super(key: key);

  final _ShowDetailsScreen widget;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: CurvedAnimation(parent: animationController, curve: Interval(0.3, 0.7, curve: Curves.linear)),
        child: Reviews(show: widget.show));
  }
}

class ShowDescription extends StatelessWidget {
  ShowDescription({
    Key? key,
    required this.widget,
    required this.animationController,
  }) : super(key: key);

  final _ShowDetailsScreen widget;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
          .animate(CurvedAnimation(parent: animationController, curve: Interval(0, 0.4, curve: Curves.linear))),
      child: FadeTransition(
        opacity: animationController,
        child: Text(
          widget.show.description,
          style: const TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    Key? key,
    required this.widget,
    required this.context,
    required this.animationController,
  }) : super(key: key);

  final _ShowDetailsScreen widget;
  final BuildContext context;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0.6, 1, curve: Curves.linear)),
      ),
      child: Container(
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
                          return WriteReviewsScreen(
                            show: widget.show,
                            parentContext: this.context,
                          );
                        })
                  }),
        ),
      ),
    );
  }
}
