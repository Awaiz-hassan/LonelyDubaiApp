import 'package:flutter/material.dart';
import 'package:lonelydubai/Themes/app_theme.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppTheme.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Flexible(
                    child: Text(
                  "About Us",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.shortestSide < 550
                          ? 16
                          : 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                )),
                const SizedBox(
                  height: 50,
                  width: 50,
                )
              ],
            ),

            Expanded(
              child: SingleChildScrollView(

                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Dubai-based company Lonely Dubai specializes in adventure tour packages, city-based sightseeing activities, expedition experiences, and desert-based adventurous activities for individuals and groups who want to explore."),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text("Our Vision",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                      Text("We aim to become the leading tourism company that delivers outstanding services through careful attention to detail, resulting in positive experiences for every person involved in it, no matter if they are tourists, employees, or stakeholders."),

                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text("Our Aim",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                      Text("We aim to become one of the most reputable and trusted tourism companies in Dubai, which continues to raise the bar by offering exceptional packages, excellent customer service, and thrilling experiences like desert safaris, city tours, water parks, sea adventures, dhow cruises, and amusement parks."),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text("Why choose Lonely Dubai?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                      Text("Flexibility Abounds: You decide how much you want to spend, cancel at any time, and make any payment.\n\nYou can count on our quality: every experience we provide meets high standards, and thousands of positive reviews guarantee your satisfaction.\n\nThe experience of a lifetime: Browse and choose from dozens of tours and activities that will make you want to spread the word.\n\nSupport that’s second to none: Are you able to find some cheaper price? Does your schedule change? No worries. Our customer service team is available 24/7."),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text("Speak to our expert at\n +971 52 52 52 746",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
