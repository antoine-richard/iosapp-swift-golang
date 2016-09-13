package weather

import (
	"encoding/json"
	"errors"
	"fmt"

	"strings"
)

type CityWeather struct {
	Name string
	Desc string
	Temp string
}

func FetchDefaultCities() ([]byte, error) {
	apiPayload, err := getCityGroupWeather()
	if err != nil {
		return nil, err
	}
	citiesWeather := apiToApp(apiPayload)
	data, err := json.Marshal(citiesWeather)
	if err != nil {
		return nil, err
	}
	return data, nil
}

func FetchCustomCity(city string) (string, error) {
	return "", errors.New("Not implemented yet :)")
}

func apiToApp(apiPayload *cityGroupPayload) (res []CityWeather) {
	for _, v := range apiPayload.List {
		res = append(res, CityWeather{
			Name: getFormatedName(&v),
			Desc: getFormatedDescription(&v),
			Temp: getFormatedTemperature(&v),
		})
	}
	return
}

func getFormatedName(cityWeather *cityPayload) string {
	return fmt.Sprintf("%v, %v", cityWeather.Name, cityWeather.Sys.Country)
}

func getFormatedDescription(cityWeather *cityPayload) (fullDescription string) {
	descriptions := cityWeather.Weather
	if len(descriptions) == 0 {
		return "No description"
	}
	for i, desc := range descriptions {
		if i == 0 {
			fullDescription += strings.ToUpper(string(desc.Description[0])) + strings.ToLower(desc.Description[1:])
		} else {
			fullDescription += ", " + strings.ToLower(desc.Description)
		}
	}
	return fullDescription
}

func getFormatedTemperature(cityWeather *cityPayload) string {
	return fmt.Sprintf("%.1f°C", cityWeather.Main.Temp)
}
