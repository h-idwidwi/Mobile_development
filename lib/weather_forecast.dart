import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_development/main.dart';

// ignore: constant_identifier_names
const APIID = "9caf12ea39835b331ef05accdd372b6a";

class Data {
  Future<Map<String, dynamic>?> getWeatherByCity(String cityName) async {
    String geocodingUrl = 'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&appid=$APIID';
    try {
      final geocodingResponse = await http.get(Uri.parse(geocodingUrl));
      if (geocodingResponse.statusCode == 200) {
        final geocodingData = jsonDecode(geocodingResponse.body);
        if (geocodingData.isNotEmpty) {
          double lat = geocodingData[0]['lat'];
          double lon = geocodingData[0]['lon'];
          return getCurrentWeather(lat, lon);
        }
      }
    } 
    catch (e) {
      if (kDebugMode) {
        print("Ошибка геокодирования: $e");
      }
    }
    return null;
  }
  Future<Map<String, dynamic>?> getCurrentWeather(double lat, double lon) async {
    String weatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$APIID&units=metric&lang=ru";
    try {
      final weatherResponse = await http.get(Uri.parse(weatherUrl));
      if (weatherResponse.statusCode == 200) {
        return jsonDecode(weatherResponse.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Ошибка при получении текущей погоды: $e");
      }
    }
    return null;
  }
  Future<Map<String, dynamic>?> getWeatherForecast(double lat, double lon) async {
    String weatherUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$APIID&units=metric&cnt=3&lang=ru";
    try {
      final weatherResponse = await http.get(Uri.parse(weatherUrl));
      if (weatherResponse.statusCode == 200) {
        return jsonDecode(weatherResponse.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Ошибка при получении данных о прогнозе: $e");
      }
    }
    return null;
  }
}

class WeatherForecastApp extends StatelessWidget {
  const WeatherForecastApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherForecast(),
    );
  }
}

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({Key? key}) : super(key: key);
  @override
  WeatherForecastState createState() => WeatherForecastState();
}

class WeatherForecastState extends State<WeatherForecast> {
  String weatherInfo = "Выберите город для получения данных о погоде";
  String forecastInfo = "";
  String input = "";
  String? weatherIcon;
  final List<String> defaultCities = ["Ханты-Мансийск", "Москва", "Санкт-Петербург", "Тюмень", "Старая Ладога"];
  String selectedCity = "Ханты-Мансийск";

  @override
  void initState() {
    super.initState();
    fetchWeather(selectedCity);
  }

  Future<void> fetchWeather(String cityName) async {
    final data = Data();
    final weatherData = await data.getWeatherByCity(cityName);
    setState(() {
      if (weatherData != null) {
        double temp = weatherData['main']['temp'];
        String description = weatherData['weather'][0]['description'];
        weatherIcon = getWeatherIcon(description);
        weatherInfo = "$weatherIcon\n$description\n$temp°C\n";
        double lat = weatherData['coord']['lat'];
        double lon = weatherData['coord']['lon'];
        getWeatherForecast(lat, lon);
      } else {
        weatherInfo = "Не удалось получить данные о текущей погоде";
      }
    });
  }

  Future<void> getWeatherForecast(double lat, double lon) async {
    final data = Data();
    final forecastData = await data.getWeatherForecast(lat, lon);
    setState(() {
      if (forecastData != null && forecastData['list'] != null) {
        List<dynamic> forecastList = forecastData['list'];
        forecastInfo = '';
        for (var forecast in forecastList) {
          String dateTime = forecast['dt_txt'];
          String time = dateTime.split(' ')[1].substring(0, 5);
          double temp = forecast['main']['temp'];
          String description = forecast['weather'][0]['description'];
          String icon = getWeatherIcon(description);
          forecastInfo += "$time\n$icon\n$description\n$temp°C\n\n";
        }
      } 
      else {
        forecastInfo = "Не удалось получить данные о прогнозе погоды";
      }
    });
  }

  String getWeatherIcon(String description) {
    switch (description) {
      case "небольшой снег":
      return "❄️";
      case "переменная облачность":
      return "🌤️";
      case "ясно":
      return "☀️";
      case "облачно":
      return "☁️";
      case "небольшая облачность":
      return "☁️";
      case "облачно с прояснениями":
      return "🌥️";
      case "небольшой дождь":
      return "🌧️";
      case "дождь":
      return "🌧️";
      case "дождь с грозой":
      return "⛈️";
      case "снег":
      return "❄️";
      case "пасмурно":
      return "🌫️";
      default:
      return "🌈";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Прогноз погоды"),
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuApp()),
                );
              },
              child: const Text(
                'Меню',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownButton<String>(
            value: selectedCity,
            onChanged: (String? newValue) {
              setState(() {
                selectedCity = newValue!;
                fetchWeather(selectedCity);
              });
            },
            items: defaultCities.map<DropdownMenuItem<String>>((String city) {
              return DropdownMenuItem<String>(
                value: city,
                child: Text(city),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Или введите свой город",
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                input = value;
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (input.isNotEmpty) {
                fetchWeather(input);
              }
            },
            child: Text(
              "Узнать погоду", 
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Text(
                  "Текущая погода:\n$weatherInfo",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Прогноз погоды:\n$forecastInfo",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
