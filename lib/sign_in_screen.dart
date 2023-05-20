import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Image.asset('assets/images/logo_bg.png', fit: BoxFit.cover),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff0b5475),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 160,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            // hintTextStyle: hintTextStyle,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: Icon(Icons.visibility_off_outlined),
                          ),
                        ),
                        //Divider(height: 10,)
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'password',
                            // hintTextStyle: hintTextStyle,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: Icon(Icons.visibility_off_outlined),
                          ),
                        ),
                        //Divider(height: 10,)
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          child: const Text(
                            'Login',
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        // Row(
                        //   children: [
                        //     const DefaultTextButton(
                        //         title: "Don't have an account ?",
                        //         color: Colors.amber),
                        //     DefaultTextButton(
                        //         title: 'Register',
                        //         color: Colors.blueGrey,
                        //         onTap: () {
                        //           RouteHelper.navigateAndRemoveUntil(context: context, widgetId: RouterPath.singUp);

                        //         }),
                        //   ],
                        // ),
                        // DefaultTextButton(color: Colors.orange,title: 'Login'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
