import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasks/pages/register_page.dart';
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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  onPressed: (){},
                ),

                divider20(),
                Text("O ingresa con tus redes sociales",),

                divider20(),
                ButtonCustomWidget(
                  text: "Inciar secion con Google",
                  icon: "google",
                  color: Color(0xfff94b2a),
                  onPressed: (){},
                ),
                
                divider20(),
                ButtonCustomWidget(
                  text: "Inciar secion con Facebook",
                  icon: "facebook",
                  color: Color(0xff507CC0),
                  onPressed: (){},
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
    );
  }
}
