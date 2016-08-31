package weather

import (
	"errors"
	"math"
	"strings"

	"gopkg.in/h2non/gentleman.v1"
)

type CityWeather struct {
	City        string
	Description string
	Temperature int
}

func FetchByName(city string) (*CityWeather, error) {
	city = strings.TrimSpace(city)
	if city == "" {
		return nil, errors.New("Please provide a city name")
	}

	apiCityWeather, err := getWeatherByName(city)
	if err != nil {
		return nil, err
	}

	return &CityWeather{
			City:        apiCityWeather.Name,
			Description: apiCityWeather.Weather[0].Description,
			Temperature: kelvinToCelsius(apiCityWeather.Main.Temp)},
		nil
}

type apiCityWeather struct {
	Name    string
	Weather []struct {
		Main        string
		Description string
	}
	Wind map[string]float64
	Main struct {
		Temp     float64
		Humidity float64
	}
}

var apiKey = "API_KEY"
var client = gentleman.New()

func kelvinToCelsius(temp float64) int {
	return int(math.Floor(temp - 273.15))
}

func getWeatherByName(city string) (*apiCityWeather, error) {
	req := client.Request().URL("api.openweathermap.org")
	req.Path("/data/2.5/weather")
	req.SetQuery("q", city)
	req.SetQuery("appid", apiKey)

	res, err := req.Send()
	if err != nil || !res.Ok {
		return nil, err
	}

	weather := &apiCityWeather{}
	err = res.JSON(weather)
	if err != nil {
		return nil, err
	}

	return weather, nil
}
