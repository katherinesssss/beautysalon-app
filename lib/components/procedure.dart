class Procedure {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Procedure({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
  //method to json
  Map<String, dynamic> toJson() =>{
    'id':id,
    'title': title,
    'description': description,
    'price':price,
    'imageUrl': imageUrl,
  };
  //method from json
  Procedure.fromJson(Map<String, dynamic> json) //json-имя параметра
  : id=json['id'] as int,
  title=json['title'] as String,
  description=json['description'] as String,
  price=json['price'] as double,
  imageUrl=json['imageUrl'] as String;
}
