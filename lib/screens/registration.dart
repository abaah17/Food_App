import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tchowv1/helpers/screen_navigation.dart';
import 'package:tchowv1/helpers/style.dart';
import 'package:tchowv1/providers/category.dart';
import 'package:tchowv1/providers/product.dart';
import 'package:tchowv1/providers/restaurant.dart';
import 'package:tchowv1/providers/user.dart';
import 'package:tchowv1/screens/home.dart';
import 'package:tchowv1/screens/login.dart';
import 'package:tchowv1/widgets/custom_text.dart';
import 'package:tchowv1/widgets/loading.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status == Status.Authenticating? Loading() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/tchow_logo.png", width: 100, height: 100,),
              ],
            ),

            SizedBox(
              height: 40,
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        icon: Icon(Icons.person)
                    ),
                  ),),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.email,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Emails",
                        icon: Icon(Icons.email)
                    ),
                  ),),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.password,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock)
                    ),
                  ),),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()async{
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");

                  if(!await authProvider.signUp()){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("SignUp failed")));
//                    _key.currentState.showSnackBar(
//                        SnackBar(content: Text("Resgistration failed!"))
//                    );
                    return;
                  }
                  categoryProvider.loadCategories();
                  restaurantProvider.loadSingleRestaurant();
                  productProvider.loadProducts();
                  authProvider.clearController();
                  changeScreenReplacement(context, Home());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: amber,
                      border: Border.all(color: grey),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(text: "SignUp", color: white, size: 22,)
                      ],
                    ),),
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                changeScreen(context, LoginScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(text: "Login Here!", size: 20, color: Colors.blueAccent,),
                ],
              ),
            ),




          ],
        ),
      ),
    );
  }
}
