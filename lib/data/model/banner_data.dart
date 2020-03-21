/**
 * {
    "desc": "Android高级进阶直播课免费学习",
    "id": 23,
    "imagePath": "https://wanandroid.com/blogimgs/d9a6f718-5011-429c-8dd5-273f02f3bf25.jpeg",
    "isVisible": 1,
    "order": 0,
    "title": "Android高级进阶直播课免费学习",
    "type": 0,
    "url": "https://url.163.com/4bj"
    },
 */

///Banner数据
class BannerData {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerData(
      {this.desc,
      this.id,
      this.imagePath,
      this.isVisible,
      this.order,
      this.title,
      this.type,
      this.url});

  ///入参是待解析的json map
  factory BannerData.fromJson(Map<String, dynamic> parsedJson) {
    return BannerData(
      desc: parsedJson['desc'],
      id: parsedJson['id'],
      imagePath: parsedJson['imagePath'],
      isVisible: parsedJson['isVisible'],
      order: parsedJson['order'],
      title: parsedJson['title'],
      type: parsedJson['type'],
      url: parsedJson['url'],
    );
  }

  @override
  String toString() {
    return 'BannerData{desc: $desc, id: $id, imagePath: $imagePath, isVisible: $isVisible, order: $order, title: $title, type: $type, url: $url}';
  }

}
