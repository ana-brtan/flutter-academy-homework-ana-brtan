import '../gen/assets.gen.dart';

class Review {
  final String comment;
  final int rating;
  final String userEmail;
  final String imageUrl;

  Review({required this.comment, required this.rating, required this.userEmail, required this.imageUrl});

  static final List<Review> allReviews = [
    Review(comment: 'nice', rating: 2, userEmail: 'x@gmail.com', imageUrl: Assets.images.profilePlaceholder.path),
    Review(comment: 'mehh', rating: 3, userEmail: 'y@gmail.com', imageUrl: Assets.images.profilePlaceholder.path),
    Review(comment: 'bad', rating: 2, userEmail: 'z@gmail.com', imageUrl: Assets.images.profilePlaceholder.path),
    Review(comment: 'bad', rating: 2, userEmail: 'z@gmail.com', imageUrl: Assets.images.profilePlaceholder.path)
  ];
}
