import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tchowv1/helpers/order.dart';
import 'package:tchowv1/helpers/user.dart';
import 'package:tchowv1/models/cart_item.dart';
import 'package:tchowv1/models/order.dart';
import 'package:tchowv1/models/product.dart';
import 'package:tchowv1/models/user.dart';
import 'package:uuid/uuid.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

//class UserProvider with ChangeNotifier{
//  FirebaseAuth _auth;
//  User _user;
//  Status _status = Status.Uninitialized;
//  FirebaseFirestore _firestore = FirebaseFirestore.instance;
//  UserServices _userServices = UserServices();
//  OrderServices _orderServices = OrderServices();
//  UserModel _userModel;
//
////  getter
//  UserModel get userModel => _userModel;
//  Status get status => _status;
//  User get user => _user;
//
//  // public variables
//  List<OrderModel> orders = [];
//
//  final formkey = GlobalKey<FormState>();
//
//  TextEditingController email = TextEditingController();
//  TextEditingController password = TextEditingController();
//  TextEditingController name = TextEditingController();
//
//
//  UserProvider.initialize(): _auth = FirebaseAuth.instance{
//    _auth.authStateChanges().listen(_onStateChanged);
//  }
//
//  Future<bool> signIn() async{
//    try{
//      _status = Status.Authenticating;
//      notifyListeners();
//      await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
//      return true;
//    }catch(e){
//      _status = Status.Unauthenticated;
//      notifyListeners();
//      print(e.toString());
//      return false;
//    }
//  }
//
//
//  Future<bool> signUp()async{
//    try{
//      _status = Status.Authenticating;
//      notifyListeners();
//      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result){
//        _firestore.collection('users').doc(result.user.uid).set({
//          'name':name.text,
//          'email':email.text,
//          'uid': result.user.uid,
//          "cart": [{}]
//        });
//      });
//      return true;
//    }catch(e){
//      _status = Status.Unauthenticated;
//      notifyListeners();
//      print(e.toString());
//      return false;
//    }
//  }
//
//  Future signOut()async{
//    _auth.signOut();
//    _status = Status.Unauthenticated;
//    notifyListeners();
//    return Future.delayed(Duration.zero);
//  }
//
//  void clearController(){
//    name.text = "";
//    password.text = "";
//    email.text = "";
//  }
//
//  Future<void> reloadUserModel()async{
//    _userModel = await _userServices.getUserById(user.uid);
//    notifyListeners();
//  }
//
//
//  Future<void> _onStateChanged(User firebaseUser) async{
//    if(firebaseUser == null){
//      _status = Status.Unauthenticated;
//    }else{
//      _user = firebaseUser;
//      _status = Status.Authenticated;
//      _userModel = await _userServices.getUserById(user.uid);
//    }
//    notifyListeners();
//  }
//
//  Future<bool> addToCart({ProductModel product, int quantity})async{
//    print("THE PRODUCT IS: ${product.toString()}");
//    print("THE PRODUCT IS: ${product.toString()}");
//    print("THE PRODUCT IS: ${product.toString()}");
//    print("THE PRODUCT IS: ${product.toString()}");
//    print("THE qty IS: ${quantity.toString()}");
//    print("THE qty IS: ${quantity.toString()}");
//    print("THE qty IS: ${quantity.toString()}");
//    print("THE qty IS: ${quantity.toString()}");
//
////    try{
//      var uuid = Uuid();
//      String cartItemId = uuid.v4();
//      List cart = _userModel.cart;
//      bool itemExists = false;
//
//      Map cartItem ={
//        "id": cartItemId,
//        "name": product.name,
//        "image": product.image,
//        "restaurantId": product.restaurantId,
//        "totalRestaurantSale": product.price * quantity,
//        "productId": product.id,
//        "price": product.price,
//        "quantity": quantity
//      };
//
//      for(Map item in cart){
//        if(item["productId"] == cartItem["productId"]){
//          itemExists = true;
//          break;
//        }
//      }
//
//      if(!itemExists){
//        print("CART ITEMS ARE: ${cart.toString()}");
//        _userServices.addToCart(userId: userModel.id, cartItem: cartItem);
//        print("The usersID is : "+ user.uid);
//      }
//
//
//      return true;
////    }catch(e){
////      print("THE ERROR ${e.toString()}");
////      return false;
////    }
//  }
//
//  getOrders()async{
//    orders = await _orderServices.getUserOrders(userId: _user.uid);
//    notifyListeners();
//  }
//
//  Future<bool> removeFromCart({CartItemModel cartItem})async{
//    print("THE PRODUCT IS: ${cartItem.toString()}");
//    print("THE PRODUCT IS: ${cartItem.toString()}");
//    print("THE PRODUCT IS: ${cartItem.toString()}");
//
//    try{
//      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
//      return true;
//    }catch(e){
//      print("THE ERROR IS ${e.toString()}");
//      return false;
//    }
//
//  }
//
//
//}


class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  // public variables
  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();


  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn() async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }


  Future<bool> signUp()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result){
        _firestore.collection('users').doc(result.user.uid).set({
          'name':name.text,
          'email':email.text,
          'uid': result.user.uid,
          "cart": [{}]
        });
      });
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController(){
    name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<void> reloadUserModel()async{
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }


  Future<void> _onStateChanged(User firebaseUser) async{
    if(firebaseUser == null){
      _status = Status.Unauthenticated;
    }else{
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(firebaseUser.uid);
    }
    notifyListeners();
  }

  Future<bool> addToCard({ProductModel product, int quantity})async{
    print("THE PRODUCT IS: ${product.toString()}");
    print("THE qty IS: ${quantity.toString()}");

//    try{
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = _userModel.cart;
//      bool itemExists = false;
      Map cartItem ={
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "restaurantId": product.restaurantId,
        "totalRestaurantSale": product.price * quantity,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };

//      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
      print("CART ITEMS ARE: ${cart.toString()}");
      _userServices.addToCart(userId: _user.uid, cartItem: cartItem);
//      }



      return true;
//    }catch(e){
//      print("THE ERROR ${e.toString()}");
//      return false;
//    }

  }

  getOrders()async{
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({CartItemModel cartItem})async{
    print("THE PRODUC IS: ${cartItem.toString()}");

    try{
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }


}