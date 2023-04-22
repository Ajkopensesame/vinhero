import 'package:flutter/material.dart';
import 'package:vinhero/services/problem_service.dart';

class ProblemFixFormPage extends StatefulWidget {
  final String make;
  final String model;
  final String year;
  final String vin;

  const ProblemFixFormPage({
    Key? key,
    required this.make,
    required this.model,
    required this.year,
    required this.vin, required Null Function(dynamic String) onSubmitProblem,
  }) : super(key: key);

  @override
  _ProblemFixFormPageState createState() => _ProblemFixFormPageState();
}

class _ProblemFixFormPageState extends State<ProblemFixFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _concern = '';
  String _cause = '';
  String _correction = '';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool submitted = await ProblemService().submitCauseAndCorrection(
        widget.make,
        widget.model,
        widget.year,
        widget.vin,
        _concern,
        _cause,
        _correction,
      );

      if (submitted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Problem fix submitted successfully!')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit problem fix')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Problem Fix Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Concern'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the concern';
                  }
                  return null;
                },
                onSaved: (value) {
                  _concern = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cause'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the cause';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cause = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Correction'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the correction';
                  }
                  return null;
                },
                onSaved: (value) {
                  _correction = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
