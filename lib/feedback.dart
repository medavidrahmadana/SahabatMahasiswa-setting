import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'theme_model.dart';
import 'setting.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 50), // Mengatur jarak panah
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
            alignment: Alignment
                .topCenter, // Menempatkan teks "Setting" dan tombol-tombol ke atas
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
                //
                SizedBox(height: 20),
                FormFeed(),
                SizedBox(height: 20),
                Text(
                  'Share your experience in scalling:',
                  style: TextStyle(
                    color: themeModel.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // rating bar
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
                    print(rating);
                  },
                ),
                SizedBox(height: 10),
                InputFeed(),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan kode untuk menyimpan perubahan bahasa
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
    );
  }
}

class FormFeed extends StatelessWidget {
  const FormFeed({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputFeed extends StatelessWidget {
  const InputFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    return Container(
      width: 340,
      height: 150,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: themeModel.isDarkMode ? Colors.white : Color(0xFF353535)),
      ),
      child: TextField(
        maxLines:
            null, // Biarkan teks field dapat menyesuaikan ketinggian secara otomatis
        decoration: InputDecoration(
          hintText: 'Add your comments',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
