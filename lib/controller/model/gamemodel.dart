class Game {
  final String id;
  final String name;
  final String description;
  final String url;
  final int playercount;
  final int maximumcount;
  final String category;
  final String imgurl;
  Game(
      {
      required this.id,
      required this.name,
      required this.description,
      required this.url,
      required this.playercount,
      required this.maximumcount,
      required this.category,
      required this.imgurl});
}
