import 'package:ecommerciappbloc/model/categorymodel.dart';

class ProductModdel {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;

  ProductModdel({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });

  ProductModdel.fromJson({required Map<String, dynamic> data}) {
    id = data['id']?.toInt();
    price = data['price']?.toInt();
    oldPrice = data['old_price']?.toInt();
    discount = data['discount']?.toInt();
    image = data['image']?.toString();
    name = data['name']?.toString();
    description = data['description']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;

    return data;
  }
}
