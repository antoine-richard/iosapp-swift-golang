package weather

type Weather struct {
	Text        string
	Temperature int
}

func Fetch() *Weather {
	return &Weather{"Clear and sunny", 30}
}
