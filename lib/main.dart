import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bmi calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        centerTitle: true,
      ),
      //

      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Your's BMI",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Colors.red),
              ),
              //
              const SizedBox(
                height: 10,
              ),

              //
              TextField(
                controller: weightController,
                decoration: const InputDecoration(
                    label: Text("Enter Your Weight in KGs"),
                    prefixIcon: Icon(Icons.line_weight),
                    border: OutlineInputBorder()),
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
                decoration: const InputDecoration(
                    label: Text("Enter Your Height in feet"),
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
                decoration: const InputDecoration(
                    label: Text("Enter Your Height in Inches"),
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
              ElevatedButton(
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
                        showImage = "assets/overf.png";
                      }
                      //
                      else if (bmi < 18) {
                        msg = "You are under weight!!";
                        showImage = "assets/underf.png";
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
                  child: const Text("Calculate")),

              const SizedBox(
                height: 10,
              ),

              //
              Text(
                result,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),

              if (showImage
                  .isNotEmpty) // show the image only when showImage is not empty.
                Image.asset(
                  showImage,
                  height: 100,
                )
            ],
          ),
        ),
      ),
    );
  }
}
