//list object to be saved/retrieved from LS
class WorkoutList {
  String title;
  List items;

  WorkoutList({required this.title, required this.items});

  toJSONEncodable() {
    var m = {"title": title, "items": items};

    return m;
  }
}
