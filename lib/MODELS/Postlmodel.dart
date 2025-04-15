class PostsModel {
  String? id;
  String? name;
  String? imgPath;
  String? title;
  String? arTitle;
  bool? isFav = false;
  String? description;
  String? arDescription;
  bool? isPlaces = true;
  PostsModel(
      {this.id,
      this.name,
      this.imgPath,
      this.title,
      this.isFav,
      this.description,
      this.arDescription,
      this.arTitle,
      this.isPlaces});
}
