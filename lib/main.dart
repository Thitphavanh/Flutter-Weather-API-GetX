import 'package:flutter/material.dart';
import 'package:flutter_weather_api_getx/controllers/main_controller.dart';
import 'package:flutter_weather_api_getx/models/current_weather.dart';
import 'package:flutter_weather_api_getx/models/hourly_weather.dart';
import 'package:flutter_weather_api_getx/our_theme.dart';
import 'package:flutter_weather_api_getx/services/api_services.dart';
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
      themeMode: ThemeMode.system,
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      title: 'Weather App',
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
    var theme = Theme.of(context);
    var controller = Get.put(MainController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: date.text.color(theme.primaryColor).make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                controller.changeTheme();
              },
              icon: Icon(
                controller.isDark.value ? Icons.light_mode : Icons.dark_mode,
                color: theme.iconTheme.color,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: theme.iconTheme.color,
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoaded.value == true
            ? Container(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder(
                  future: controller.currentWeatherData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      CurrentWeatherData data = snapshot.data;

                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            '${data.name}'
                                .text
                                .uppercase
                                .fontFamily('poppins_bold')
                                .size(32.0)
                                .letterSpacing(2)
                                .color(theme.primaryColor)
                                .make(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/weather/${data.weather![0].icon}.png',
                                  width: 80.0,
                                  height: 80.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${data.main!.temp}',
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 64.0,
                                          // fontFamily: 'poppins',
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ${data.weather![0].main}',
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          color: theme.primaryColor,
                                          fontSize: 14.0,
                                          // fontFamily: 'poppins',
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
                                  icon: Icon(
                                    Icons.expand_less_rounded,
                                    color: theme.iconTheme.color,
                                  ),
                                  label: '${data.main!.tempMax}$degree'
                                      .text
                                      .color(theme.iconTheme.color)
                                      .make(),
                                ),
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.expand_more_rounded,
                                    color: theme.iconTheme.color,
                                  ),
                                  label: '${data.main!.tempMin}$degree'
                                      .text
                                      .color(theme.iconTheme.color)
                                      .make(),
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
                                  var values = [
                                    '${data.clouds!.all}',
                                    '${data.main!.humidity} %',
                                    '${data.wind!.speed} km/h'
                                  ];

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
                                      values[index].text.orange600.make(),
                                    ],
                                  );
                                },
                              ),
                            ),
                            10.heightBox,
                            const Divider(),
                            10.heightBox,
                            FutureBuilder(
                              future: controller.hourlyWeatherData,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  HourlyWeatherData hourlyData = snapshot.data;
                                  return SizedBox(
                                    height: 160.0,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: hourlyData.list!.length > 6
                                          ? 6
                                          : hourlyData.list!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var time = DateFormat.jm().format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            hourlyData.list![index].dt!
                                                    .toInt() *
                                                1000,
                                          ),
                                        );
                                        return Container(
                                          padding: const EdgeInsets.all(8.0),
                                          margin:
                                              const EdgeInsets.only(right: 4.0),
                                          decoration: BoxDecoration(
                                            color: cardColor,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              time.text.black.make(),
                                              Image.asset(
                                                'assets/weather/${hourlyData.list![index].weather![0].icon}.png',
                                                width: 100.0,
                                              ),
                                              '${hourlyData.list![index].main!.temp}$degree'
                                                  .text
                                                  .black
                                                  .make(),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                            10.heightBox,
                            const Divider(),
                            10.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                '7 ມື້ ຂ້າງໜ້າ'
                                    .text
                                    .semiBold
                                    .size(16.0)
                                    .color(theme.primaryColor)
                                    .make(),
                                TextButton(
                                  onPressed: () {},
                                  child: 'ເບິ່ງທັງໝົດ'
                                      .text
                                      .color(theme.primaryColor)
                                      .make(),
                                ),
                              ],
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 7,
                              itemBuilder: (BuildContext context, int index) {
                                var days = DateFormat('EEEE').format(
                                    DateTime.now()
                                        .add(Duration(days: index + 1)));
                                return Card(
                                  color: theme.cardColor,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 12.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: days.text.semiBold
                                              .color(theme.primaryColor)
                                              .make(),
                                        ),
                                        Expanded(
                                          child: TextButton.icon(
                                            onPressed: () {},
                                            icon: Image.asset(
                                              'assets/weather/50n.png',
                                              width: 40.0,
                                            ),
                                            label: '26$degree'
                                                .text
                                                .color(theme.primaryColor)
                                                .make(),
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '38$degree /',
                                                style: TextStyle(
                                                  color: theme.primaryColor,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '26$degree',
                                                style: TextStyle(
                                                  color: theme.iconTheme.color,
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
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
