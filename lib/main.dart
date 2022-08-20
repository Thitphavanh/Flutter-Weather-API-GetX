import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: ThemeData(fontFamily: "poppins"),
      debugShowCheckedModeBanner: false,
      home: const WeatherApp(),
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateFormat('yMMMMd').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: date.text.gray700.make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.light_mode,
              color: Vx.gray700,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Vx.gray700,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'ສະຫວັນນະເຂດ'.text.size(32.0).letterSpacing(2).make(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/weather/01d.png',
                    width: 80.0,
                    height: 80.0,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '37$degree',
                          style: TextStyle(
                            color: Vx.gray900,
                            fontSize: 64.0,
                          ),
                        ),
                        TextSpan(
                          text: 'ແສງແດດ',
                          style: TextStyle(
                            letterSpacing: 2,
                            color: Vx.gray700,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.expand_less_rounded,
                      color: Vx.gray400,
                    ),
                    label: '41$degree'.text.make(),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.expand_more_rounded,
                      color: Vx.gray400,
                    ),
                    label: '26$degree'.text.make(),
                  ),
                ],
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  3,
                  (index) {
                    var iconsList = [clouds, humidity, windspeed];
                    var values = ['70%', '40%', '3.5 km/h'];

                    return Column(
                      children: [
                        Image.asset(
                          iconsList[index],
                          width: 60.0,
                          height: 60.0,
                        )
                            .box
                            .gray100
                            .padding(const EdgeInsets.all(8.0))
                            .roundedSM
                            .make(),
                        10.heightBox,
                        values[index].text.gray400.make(),
                      ],
                    );
                  },
                ),
              ),
              10.heightBox,
              const Divider(),
              10.heightBox,
              SizedBox(
                height: 150.0,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      margin: const EdgeInsets.only(right: 4.0),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          '${index + 1} ກາງເວັນ'.text.gray100.make(),
                          Image.asset('assets/weather/09n.png'),
                          '38$degree'.text.white.make(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              10.heightBox,
              const Divider(),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  '7 ມື້ ຂ້າງໜ້າ'.text.semiBold.size(16.0).make(),
                  TextButton(
                    onPressed: () {},
                    child: 'ເບິ່ງທັງໝົດ'.text.make(),
                  ),
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  var days = DateFormat('EEEE')
                      .format(DateTime.now().add(Duration(days: index + 1)));
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 12.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: days.text.semiBold.make(),
                          ),
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/weather/50n.png',
                                width: 40.0,
                              ),
                              label: '26$degree'.text.gray800.make(),
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: '38$degree /',
                                  style: TextStyle(
                                    color: Vx.gray800,
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextSpan(
                                  text: '26$degree',
                                  style: TextStyle(
                                    color: Vx.gray600,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
