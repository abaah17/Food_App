import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tchowv1/models/cart_item.dart';
import 'package:tchowv1/models/user.dart';


class UserServices{
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).doc(id).set(values);
  }

  void updateUserData(Map<String, dynamic> values){
    _firestore.collection(collection).doc(values['id']).update(values);
  }


  void addToCart({String userId, Map cartItem}){
    print("THE USER ID IS : $userId");
    print("cart items are : ${cartItem.toString()}");
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}){
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }

  Future<UserModel> getUserById(String id) => _firestore.collection(collection).doc(id).get().then((result){
    return UserModel.fromSnapshot(result);
  });
}