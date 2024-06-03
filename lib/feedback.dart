import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'theme_model.dart';
import 'setting.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _commentController = TextEditingController();
  double _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: themeModel.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  'Feedback',
                  style: TextStyle(
                    color: themeModel.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 40,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Share your experience in scaling:',
                        style: TextStyle(
                          color: themeModel.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          _rating = rating;
                        },
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 340,
                        height: 150,
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: themeModel.isDarkMode
                                  ? Colors.white
                                  : Color(0xFF353535)),
                        ),
                        child: TextFormField(
                          controller: _commentController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Add your comments',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _submitFeedback(context); // Pass context here
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeModel.isDarkMode ? Colors.white : Color(0xFF353535),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          minimumSize: Size(250, 44),
                        ),
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: themeModel.isDarkMode ? Color(0xFF353535) : Colors.white,
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitFeedback(BuildContext context) async { // Accept context as a parameter
    final feedbackData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'rating': _rating,
      'comments': _commentController.text,
      'timestamp': Timestamp.now(),
    };

    try {
      await FirebaseFirestore.instance.collection('feedback').add(feedbackData);
      // Optionally, show a success message or navigate away
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback submitted successfully!')));
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit feedback: $e')));
    }
  }
}
