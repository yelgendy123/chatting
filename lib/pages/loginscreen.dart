import 'package:chatting/pages/register.dart';
import 'package:chatting/widgets/custombutton.dart';
import 'package:chatting/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import 'chattingpage.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);
   static String id='LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  GlobalKey<FormState>formKey=GlobalKey();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kprimaryColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://www.pngitem.com/pimgs/m/236-2366651_transparent-student-icon-png-transparent-student-png-icon.png'),
                      radius: 60,
                      backgroundColor: kprimaryColor,
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Students Chatting',
                      style: TextStyle(
                          fontSize: 27,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('LOGIN',
                      style: TextStyle(
                          fontSize: 27,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
                const SizedBox(height: 10,),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:
                    CustomTextField('Email',Icon(Icons.email),(data){
                      email=data;
                    })
               ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20 ),
                    child:
                    CustomTextField('Password',Icon(Icons.remove_red_eye),(data){
                      password=data;
                    })
                ),
                Padding(
                  padding: const EdgeInsets.all( 20),
                  child:CustomButton('LOGIN',
                          ()async{
                        if(formKey.currentState!.validate()){
                          isLoading=true;
                          setState(() {
                          });
                          try{
                            UserCredential user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You were Loged-in succsessfully')));
                            Navigator.pushNamed(context, ChatPage.id);

                          }on FirebaseAuthException catch(e){
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Not Found')));
                            } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong Password')));
                            }else {isLoading=false;
                           // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You were registered succsessfully')));
                            }
                          }isLoading=false;
                          setState(() {
                          });
                        }else{
                        }
                            (e){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('There was an error')));
                        };
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?' ,
                      style: TextStyle(
                          color: Colors.black
                      ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text(' Register'
                        ,style: TextStyle(
                            color: Colors.blueAccent
                        ),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );}}