import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custombutton.dart';
import '../widgets/widgets.dart';
import 'chattingpage.dart';

class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key}) : super(key: key);
    static String id='RegisterPage';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
    String? email;
    String? password;
    GlobalKey<FormState>formKey=GlobalKey();
    bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall:isLoading ,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Form(
            key:formKey ,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://www.pngitem.com/pimgs/m/236-2366651_transparent-student-icon-png-transparent-student-png-icon.png'),
                      radius: 60,
                      backgroundColor: Colors.white,
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
                    Text('Register',
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
                    CustomTextField('Email',Icon(Icons.email),
                        (data){
                      email=data;
                        })
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20 ),
                    child:
                    CustomTextField('Password',Icon(Icons.remove_red_eye),
                        (data){
                      password=data;
                        })
                ),
                Padding(
                  padding: const EdgeInsets.all( 20),
                  child:CustomButton(
                      'Register',
                      ()async{
                        if(formKey.currentState!.validate()){
                          isLoading=true;
                          setState(() {
                          });
                          try{
                          UserCredential user=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You were registered succsessfully')));
                          Navigator.pushNamed(context, ChatPage.id);
                        }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Weak Password')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('This Email is already registerd')));
      }else {isLoading=false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You were registered succsessfully')));
      }
      }isLoading=false;
                          setState(() {
                          });
                      }else{


                        }
                      (e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('There was an error')));

                      };
                      }
      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You have an account?' ,
                      style: TextStyle(
                          color: Colors.black
                      ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(' LOGIN'
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
    );
  }
}
