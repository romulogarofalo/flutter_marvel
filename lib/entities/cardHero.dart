class CardHero {
  String name;
  String urlImage;

  CardHero(this.name, this.urlImage);

  CardHero.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    urlImage = (json['thumbnail']['path']).toString() + '.' + (json['thumbnail']['extension']).toString();
  }
}