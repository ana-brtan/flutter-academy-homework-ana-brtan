import 'package:tv_shows/gen/assets.gen.dart';

class Show {
  final String name;
  final String description;
  final int numOfReviews;
  final double averageRating;
  final String imageUrl;
  final double average_rating;

  Show(
      {required this.name,
      required this.description,
      required this.numOfReviews,
      required this.averageRating,
      required this.imageUrl,
      required this.average_rating});

  static final List<Show> allShows = [
    Show(
        name: 'The Office',
        description:
            'The Office is an American mockumentary sitcom television series that depicts the everyday work lives of office employees in the Scranton, Pennsylvania branch of the fictional Dunder Mifflin Paper Company. It aired on NBC from March 24, 2005, to May 16, 2013, spanning a total of nine seasons.',
        numOfReviews: 526831,
        averageRating: 4.5,
        imageUrl: Assets.images.theOffice.path,
        average_rating: 4.5),
    Show(
        name: 'Stranger Things',
        description:
            'In 1980s Indiana, a group of young friends witness supernatural forces and secret government exploits. As they search for answers, the children unravel a series of extraordinary mysteries.',
        numOfReviews: 973178,
        averageRating: 3.5,
        imageUrl: Assets.images.strangerThings.path,
        average_rating: 3.5),
    Show(
        name: 'Krv Nije Voda',
        description: 'Show inspired by everyday stories of real events. ',
        numOfReviews: 5,
        averageRating: 5,
        imageUrl: Assets.images.krvNijeVoda.path,
        average_rating: 5),
    Show(
        name: 'Stranger Things',
        description: 'A group of young friends in 1980s Indiana witness supernatural forces.',
        numOfReviews: 973178,
        averageRating: 2.3,
        imageUrl: "",
        average_rating: 2.3),
  ];
}
