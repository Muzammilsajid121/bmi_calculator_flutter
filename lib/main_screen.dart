import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    initBannerAdd();
  }

//ADS SETUP
  late BannerAd bannerAd;
  bool isAddLoaded = false;
  //
  //demo add id to prevent terms and conditions
  var adUnit = "ca-app-pub-3940256099942544/6300978111"; //testing

  initBannerAdd() {
    BannerAd(
      size: AdSize.banner,
      adUnitId: adUnit,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAddLoaded = true;
          });
        },
        //
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error);
        },
      ),
      request: AdRequest(),
    );
    //
    bannerAd.load();
  }

  //
  var weightController = TextEditingController();
  //Contoller is used to take input from text feilds
  var feetController = TextEditingController();

  var inchController = TextEditingController();

  //
  var result = '';

  var showImage = ""; // Initialize with an empty string
  //var runtimeBgColor = Colors.indigo.shade100;

  //
  void ResetFunction() {
    print("Reset button pressed");
    result = "";
    showImage = "";
    weightController.clear(); // Clear the weight text field
    feetController.clear(); // Clear the feet text field
    inchController.clear(); // Clear the inch text field

    setState(() {}); // Trigger a UI update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 196, 122),
      appBar: AppBar(
        backgroundColor: Color(0xFFEAAF72),
        title: Text(
          "BMI Calculator",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      //

      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Your's BMI",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                //
                const SizedBox(
                  height: 20,
                ),

                //
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                      label: Text(
                        "Enter Your Weight in KGs",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      prefixIcon: const Icon(Icons.line_weight),
                      border: const OutlineInputBorder()),
                  //
                  keyboardType:
                      TextInputType.number, // to open the number keyboard
                ),
                //
                const SizedBox(
                  height: 10,
                ),
                //
                TextField(
                  controller: feetController,
                  decoration: InputDecoration(
                      label: Text(
                        "Enter Your Height in feet",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      prefixIcon: Icon(Icons.height),
                      border: OutlineInputBorder()),
                  //
                  keyboardType:
                      TextInputType.number, // to open the number keyboard
                ),

                const SizedBox(
                  height: 10,
                ),
                //

                TextField(
                  controller: inchController,
                  decoration: InputDecoration(
                      label: Text(
                        "Enter Your Height in Inches",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.height)),
                  //
                  keyboardType: TextInputType.number,
                ),
                //
                const SizedBox(
                  height: 10,
                ),

                //

                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        var weight = weightController.text;
                        var feet = feetController.text;
                        var inch = inchController.text;

                        if (weight != "" && feet != "" && inch != "") {
                          // bmi calcultion()

                          // converting values to integer
                          var intWeight = int.parse(weight);
                          var intFeet = int.parse(feet);
                          var intInch = int.parse(inch);

                          /* We are taking user height in feet and inches just to improve UX otherwise it is required in meter 
                  and now we have to convert these values. Now doing these calculations*/

                          var totalInch = (intFeet * 12) + intInch;

                          var totalCm = totalInch * 2.54;

                          var totalM = totalCm / 100;

                          var bmi = intWeight / (totalM * totalM);

                          //
                          var msg = '';

                          if (bmi > 25) {
                            msg = "You are over weight!!";
                            showImage = "assets/over1.png";
                          }
                          //
                          else if (bmi < 18) {
                            msg = "You are under weight!!";
                            showImage = "assets/under1.png";
                          }
                          //
                          else {
                            msg = "You are healthy";
                            showImage = "assets/heart.png";
                          }

                          // updating result to show BMI
                          setState(() {
                            result =
                                "$msg \n Your bmi is ${bmi.toStringAsFixed(2)}";
                            //.toStringAsFixed help us to limit decimal value
                          });

                          //
                        } else {
                          setState(() {
                            result = "Please fill all required feilds";

                            // if any text feild will be empty this text will be shown
                          });
                        }
                        //
                      },
                      child: Text(
                        "Calculate",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color((0xFFEAAF72)))),
                ),
                SizedBox(
                  height: 12,
                ),

                //Reset Button
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        ResetFunction();
                      },
                      child: Text(
                        "Reset",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color((0xFFEAAF72)))),
                ),

                //

                const SizedBox(
                  height: 10,
                ),

                //
                Text(result, style: Theme.of(context).textTheme.bodyMedium),

                if (showImage
                    .isNotEmpty) // show the image only when showImage is not empty.
                  Image.asset(
                    showImage,
                    height: 100,
                    width: double.infinity,
                  )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: isAddLoaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          //if add doesnt load an empty sized box will be executed
          : SizedBox(),
    );
  }
}
