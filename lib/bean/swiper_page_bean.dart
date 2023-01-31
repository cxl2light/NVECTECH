class SwiperPageBean{
  late String url;
  late String title;
  SwiperPageBean({required this.url, required this.title});

  SwiperPageBean.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['title'] = title;
    return data;
  }

}