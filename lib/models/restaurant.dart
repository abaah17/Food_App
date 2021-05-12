import 'package:cloud_firestore/cloud_firestore.dart';



class RestaurantModel {
  static const ID = "id";
  static const NAME = "name";
  static const AVG_PRICE = "avgPrice";
  static const RATING = "rating";
  static const RATES = "rates";
  static const IMAGE = "image";
  static const POPULAR = "popular";

  String _id;
  String _name;
  String _image;
  double _rating;
  int _avgPrice;
  bool _popular;
  int _rates;

//  getters
  String get id => _id;
  String get name => _name;
  String get image => _image;
  int get avgPrice => _avgPrice;
  double get rating => _rating;
  bool get popular => _popular;
  int get rates => _rates;
  

  // public variable
//  bool liked = false;


  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    print("The id is "+ _id);
    _name = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
    _avgPrice = snapshot.data()[AVG_PRICE];
    _rating = snapshot.data()[RATING];
    _popular = snapshot.data()[POPULAR];
    _rates = snapshot.data()[RATES];
  }
}
