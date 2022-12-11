
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasks/model/user_model.dart';
import 'package:tasks/pages/home_page.dart';
import 'package:tasks/services/my_services_firestore.dart';
import 'package:tasks/ui/general/colors.dart';
import 'package:tasks/ui/widgets/buttom_custom_widget.dart';
import 'package:tasks/ui/widgets/general_widget.dart';
import 'package:tasks/ui/widgets/textfield_normal_widget.dart';
import 'package:tasks/ui/widgets/textfield_password_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final keyForm = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  MyServicesFireStore userService = MyServicesFireStore(collection: "users");

  _registerUser()async{

    try{
     
      if(keyForm.currentState!.validate()){

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text,
      );

      if(userCredential.user !=null){

        UserModel userModel = UserModel(
          fullName: _fullNameController.text, 
          email: _emailController.text, 
          );

        userService.addUser(userModel).then((value) => {
          if(value.isNotEmpty){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false),
          }
        });
      }
    }

    }on FirebaseAuthException catch(error){
      if(error.code == "weak-password"){
        showSnackBarError(context, "La contraseña es muy debil");
      
      } else if(error.code == "email-already-in-use"){
        showSnackBarError(context, "El correo electronico ya esta siendo usado");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: keyForm,
            child: Column(
              children: [
          
                divider40(),
                SvgPicture.asset(
                  'assets/images/registro.svg',
                  height: 180.0,
                  ),
          
                  divider40(),
          
                  Text(
                    "Registrate",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: kBrandPrimaryColor,
                    ),
                    ),
          
                  divider20(),
                    TextFieldNormalWidget(
                    hintText: "Nombre Completo", 
                    icon: Icons.email, 
                    controller: _fullNameController,
                  ),
          
                  divider10(),
                  divider6(),
          
                  TextFieldNormalWidget(
                    hintText: "Correo Electronico", 
                    icon: Icons.email, 
                    controller: _emailController,
                  ),
          
                  divider10(),
                  divider6(),
          
                  TextFieldPasswordWidget(
                    controller: _passwordController,
                    ),
          
                  divider20(),
          
                  ButtonCustomWidget(
                    text: "Registrate Ahora",
                    icon: "check",
                    color: kBrandPrimaryColor,
                    onPressed: (){
                      _registerUser();
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}