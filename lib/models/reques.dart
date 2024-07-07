class Request {
  final String username;
  final String adminId;
  final String stir;
  final String description;
  final List<String> imageUrls;

  Request({
    required this.username,
    required this.adminId,
    required this.stir,
    required this.description,
    required this.imageUrls,
  });
}
