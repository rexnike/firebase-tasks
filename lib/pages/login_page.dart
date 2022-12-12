import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasks/model/user_model.dart';
import 'package:tasks/pages/home_page.dart';
import 'package:tasks/pages/register_page.dart';
import 'package:tasks/services/my_services_firestore.dart';
import 'package:tasks/ui/general/colors.dart';
import 'package:tasks/ui/widgets/buttom_custom_widget.dart';
import 'package:tasks/ui/widgets/general_widget.dart';
import 'package:tasks/ui/widgets/textfield_normal_widget.dart';
import 'package:tasks/ui/widgets/textfield_password_widget.dart';

class LooginPage extends StatefulWidget {
  
  @override
  State<LooginPage> createState() => _LooginPageState();
}

class _LooginPageState extends State<LooginPage> {

  final formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSingIn = GoogleSignIn(scopes: ["email"]);
  MyServicesFireStore userService = MyServicesFireStore(collection: "users");

  _login()async{
    try{

      if(formkey.currentState!.validate()){
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text,
        );

      if(userCredential.user != null){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
        }
      }

    }on FirebaseAuthException catch(error){
      if(error.code == "invalid-email"){
        showSnackBarError(context, "El correo electronic es invalido");
      }else if(error.code == "user-noot-found"){
        showSnackBarError(context, "El usuario no esta registrado");
      }else if(error.code == "worong-password"){
        showSnackBarError(context, "La contraseña es incorrecta");
      }
    }
  } 

  _loginWithGoogle()async{
    GoogleSignInAccount? googleSignInAccount = await _googleSingIn.signIn();

    if(googleSignInAccount == null){
      return;
    }
    GoogleSignInAuthentication _googleSingInAuth = await googleSignInAccount.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleSingInAuth.idToken,
      accessToken: _googleSingInAuth.accessToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  
    if(userCredential.user != null){
      UserModel userModel = UserModel(
        fullName: userCredential.user!.displayName!, 
        email: userCredential.user!.email!,
        );
        
      userService.existUser(userCredential.user!.email!).then((value){
        if(value){
          userService.addUser(userModel).then((value) => {
          if(value.isNotEmpty){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false),
          }
        });
        }else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
        }
      });
    }
  }

  _loginWithFacebook()async{
    LoginResult _loginResults = await FacebookAuth.instance.login();
    if(_loginResults.status == LoginStatus.success){
      Map<String, dynamic> userData = await FacebookAuth.instance.getUserData();

      AccessToken accessToken = _loginResults.accessToken!;

      OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    
      if(userCredential.user != null){
      UserModel userModel = UserModel(
        fullName: userCredential.user!.displayName!, 
        email: userCredential.user!.email!,
        );
        
      userService.existUser(userCredential.user!.email!).then((value){
        if(value){
          userService.addUser(userModel).then((value) => {
          if(value.isNotEmpty){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false),
          }
        });
        }else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
        }
      });
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
            key: formkey,
            child: Column(
              children: [
          
                divider40(),
                SvgPicture.asset(
                  'assets/images/candado.svg',
                  height: 180.0,
                  ),
          
                  divider40(),
          
                  Text(
                    "Iniciar Sesion",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: kBrandPrimaryColor,
                    ),
                    ),
          
                  divider10(),
          
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
                    text: "Iniciar Secion",
                    icon: "check",
                    color: kBrandPrimaryColor,
                    onPressed: (){
                      _login();
                    },
                  ),
          
                  divider20(),
                  Text("O ingresa con tus redes sociales",),
          
                  divider20(),
                  ButtonCustomWidget(
                    text: "Inciar secion con Google",
                    icon: "google",
                    color: Color(0xfff94b2a),
                    onPressed: (){
                      _loginWithGoogle();
                    },
                  ),
                  
                  divider20(),
                  ButtonCustomWidget(
                    text: "Inciar secion con Facebook",
                    icon: "facebook",
                    color: Color(0xff507CC0),
                    onPressed: (){
                      _loginWithFacebook();
                    },
                  ),
          
                  divider20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿Aun no estas registrado?"),
          
                    divider10idth(),
          
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()),);
                      },
                      child: Text("Registrate",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: kBrandPrimaryColor,
                        ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
