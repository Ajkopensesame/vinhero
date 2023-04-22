import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Save user details to Firestore
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        await users.doc(userCredential.user!.uid).set({
          'fullName': _fullNameController.text.trim(),
          'email': _emailController.text.trim(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully signed up!')),
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
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
    appBar: AppBar(title: Text('Sign Up')),
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
    controller: _fullNameController,
    decoration: InputDecoration(
    labelText: 'Full Name',
    border: OutlineInputBorder(),
    fillColor: Colors.white,
    filled: true,
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your full name';
    }
    return null;
    },
    ),
    SizedBox(height: 10),
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
    return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch
      (value)) {
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
            return 'Please enter your password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
      SizedBox(height: 10),
      ElevatedButton(
        onPressed: _signUp,
        child: Text('Sign Up'),
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
              Text('Already have an account?'),
              SizedBox(width: 5),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Sign In'),
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