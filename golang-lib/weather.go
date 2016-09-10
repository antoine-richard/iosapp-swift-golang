package weather

import (
	"fmt"

	"strings"
)

type CityWeather struct {
	City1Name string
	City1Desc string
	City1Temp string

	City2Name string
	City2Desc string
	City2Temp string

	City3Name string
	City3Desc string
	City3Temp string
}

func Fetch() (*CityWeather, error) {
	apiPayload, err := getCityGroupWeather()
	if err != nil {
		return nil, err
	}
	return apiToApp(apiPayload), nil
}

func apiToApp(apiPayload *cityGroupPayload) *CityWeather {
	return &CityWeather{
		City1Name: getFormatedName(&apiPayload.List[0]),
		City1Desc: getFormatedDescription(&apiPayload.List[0]),
		City1Temp: getFormatedTemperature(&apiPayload.List[0]),

		City2Name: getFormatedName(&apiPayload.List[1]),
		City2Desc: getFormatedDescription(&apiPayload.List[1]),
		City2Temp: getFormatedTemperature(&apiPayload.List[1]),

		City3Name: getFormatedName(&apiPayload.List[2]),
		City3Desc: getFormatedDescription(&apiPayload.List[2]),
		City3Temp: getFormatedTemperature(&apiPayload.List[2]),
	}
}

func getFormatedName(cityWeather *cityPayload) string {
	fmt.Println(cityWeather)
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
