import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UI6 extends StatefulWidget {
  @override
  _UI6State createState() => _UI6State();
}

class _UI6State extends State<UI6> {
  int currentIndex = 0;
  final pages = [Colors.pinkAccent, Colors.orangeAccent, Colors.deepOrange];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.1,
              child: Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: size.height * 0.6,
                  width: size.width * 0.7,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        //just for demo
//                    height: size.height*0.6,
//                    width: size.width*0.7,
                        color: pages[index],
                        child: Text(
                          '$index',
                          style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) {
                return BottomIndicator(
                  isActive: currentIndex == index,
                );
              }),
            ),
            Spacer(),
            DefaultButton(
              title: 'continue',
              height: 60,
              press: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => SignInPage()));
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  final double height;
  final Function() press;
  final String title;

  const DefaultButton({
    Key? key,
    required this.height,
    required this.press,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: height,
            child: RaisedButton(
              color: Colors.orange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text(title),
              onPressed: press,
            ),
          ),
        )
      ],
    );
  }
}

class BottomIndicator extends StatelessWidget {
  final isActive;

  const BottomIndicator({
    Key? key,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.all(10),
      height: 2,
      width: isActive ? 25 : 10,
      color: isActive ? Colors.blue[300] : Colors.grey,
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  List errors = [];
  bool pwdIsVisible = true;
  FocusNode emailFocusNode = FocusNode();
  FocusNode pwdFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isFocus = false;

  @override
  void initState() {
    super.initState();
    pwdFocusNode.addListener(() {
      setState(() {
        isFocus = pwdFocusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Sign\r\rIn',
                    style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.grey),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelText: 'email',
                                hintText: 'email address',
                              ),
                              validator: (value) {
                                if (value == null) return null;
                                if (value.isEmpty) {
                                  setState(() {
                                    errors.add('email is not allow empty');
                                  });
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Stack(
                            children: [
                              TextFormField(
                                controller: pwdController,
                                focusNode: pwdFocusNode,
                                textAlignVertical: TextAlignVertical.center,
                                obscureText: pwdIsVisible,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: 'password',
                                  hintText: 'yours password',
                                ),
                              ),
                              Positioned(
                                right: 20,
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 200),
                                  opacity: isFocus ? 1.0 : 0.0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                    ),
                                    onPressed: () {
                                      pwdIsVisible = !pwdIsVisible;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: List.generate(errors.length, (index) {
                                return Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colors.pinkAccent,
                                    ),
                                    Text(errors[index])
                                  ],
                                );
                              }),
                            ),
                          ),
                          DefaultButton(
                            title: 'continue',
                            height: 60,
                            press: () {
                              formKey.currentState!.save();
                              formKey.currentState!.validate();
                            },
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
