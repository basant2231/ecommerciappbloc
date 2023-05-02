

class BannerModel {
  int? id;
  String? url;

  BannerModel({required this.id,required this.url});

  BannerModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'];
    url = data['image'];
  }

  Map<String, dynamic> toJson({required data}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.url;
    return data;
  }
}