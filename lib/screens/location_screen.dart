import 'package:clima_weather_app/screens/city_screen.dart';
import 'package:clima_weather_app/services/weather.dart';
import 'package:clima_weather_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, this.cityNewName}) : super(key: key);

  final cityNewName;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    print(widget.cityNewName);
    updateUI(widget.cityNewName);
  }

  late double temperature;
  late String weatherIcon;
  late String weatherMessage;
  var cityName;

  void updateUI(dynamic weatherData) {
    setState(
      () {
        if (weatherData == null) {
          temperature = 0;
          weatherIcon = 'Error';
          weatherMessage = 'Unable to get weather data';
          cityName = '';
          return;
        }
        temperature = weatherData['main']['temp'];
        var condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];

        weatherIcon = weatherModel.getWeatherIcon(condition);
        weatherMessage = weatherModel.getMessage(temperature.toInt());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          updateUI(weatherModel.getLocationWeather()),
                      child: Icon(
                        Icons.near_me,
                        color: Colors.blue[900],
                        size: 50.0,
                      ),
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                          (states) {
                            return states.contains(MaterialState.hovered)
                                ? Colors.blue
                                : Colors.yellow;
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen())),
                      child: Icon(
                        Icons.location_city,
                        color: Colors.blue[900],
                        size: 50.0,
                      ),
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                          (states) {
                            return states.contains(MaterialState.hovered)
                                ? Colors.blue
                                : Colors.yellow;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${temperature.toInt()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
