import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';
import 'sign_up_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _rememberMe = false;

  Future<String> _fetchRandomCarImageUrl() async {
    final response =
    await http.get(Uri.parse('https://source.unsplash.com/800x600/?car'));

    if (response.statusCode == 200) {
      return response.request!.url.toString();
    } else {
      throw Exception('Failed to load random car image');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully signed in!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
            Text('Please enter your email address to reset your password')),
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent!')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _fetchRandomCarImageUrl(),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
    if (snapshot.hasData) {
    return Scaffold(
    appBar: AppBar(title: Text('Sign In')),
    body: Stack(
    children: [
    Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: NetworkImage(snapshot.data!),
    fit: BoxFit.cover,
    ),
    ),
    ),
    Container(
    color: Color.fromRGBO(255, 255, 255, 0.8),
    ),
    Padding(
    padding: EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    TextFormField(
    controller: _emailController,
    decoration: InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
    fillColor: Colors.white,
    filled: true,
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enteran email';
    }
    if (!RegExp(r'^[^@]+@[^@]+.[^@]+').hasMatch(
        value)) {
      return 'Please enter a valid email address';
    }
    return null;
    },
    ),
      SizedBox(height: 10),
      TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
          fillColor: Colors.white,
          filled: true,
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          return null;
        },
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Checkbox(
            value: _rememberMe,
            onChanged: (value) {
              setState(() {
                _rememberMe = value!;
              });
            },
          ),
          Text('Remember me'),
          Spacer(),
          TextButton(
            onPressed: _resetPassword,
            child: Text('Forgot password?'),
          ),
        ],
      ),
      SizedBox(height: 10),
      ElevatedButton(
        onPressed: _signIn,
        child: Text('Sign In'),
      ),
      SizedBox(height: 10),
    ],
    ),
    ),
    ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 70,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?'),
              SizedBox(width: 5),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpPage()),
                  );
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    ],
    ),
    );
    } else {
      return Center(child: Text('Failed to load image'));
    }
    } else {
      return Center(child: CircularProgressIndicator());
    }
    },
    );
  }
}
