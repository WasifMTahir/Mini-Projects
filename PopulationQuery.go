package main

import (
	"encoding/csv"
	"fmt"
	"math"
	"os"
	"strconv"
)

type CensusGroup struct {
	population          int
	latitude, longitude float64
}

/*
func task2(census []CensusGroup, data []float64) (retData []float64) {
	if length < 30000 {
		gridLat := 0.0
		gridLong := 0.0
		minLat := data[0]
		maxLat := data[1]
		minLong := data[2]
		maxLong := data[3]
		for i := 1; i < length; i++ {
			if census[i].latitude < minLat {
				minLat = censusData[i].latitude
			}
			if census[i].latitude > maxLat {
				maxLat = censusData[i].latitude
			}
			if census[i].longitude < minLong {
				minLong = censusData[i].longitude
			}
			if census[i].longitude > maxLong {
				maxLong = censusData[i].longitude
			}
		}
		gridLat = (maxLat - minLat) / float64(ydim)
		gridLong = (maxLong - minLong) / float64(xdim)
		retData[0] = minLat
		retData[1] = maxLat
		retData[2] = minLong
		retData[3] = maxLong
		return retData
	}
}
*/
func ParseCensusData(fname string) ([]CensusGroup, error) {
	file, err := os.Open(fname)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	records, err := csv.NewReader(file).ReadAll()
	if err != nil {
		return nil, err
	}
	censusData := make([]CensusGroup, 0, len(records))

	for _, rec := range records {
		if len(rec) == 7 {
			population, err1 := strconv.Atoi(rec[4])
			latitude, err2 := strconv.ParseFloat(rec[5], 64)
			longitude, err3 := strconv.ParseFloat(rec[6], 64)
			if err1 == nil && err2 == nil && err3 == nil {
				latpi := latitude * math.Pi / 180
				latitude = math.Log(math.Tan(latpi) + 1/math.Cos(latpi))
				censusData = append(censusData, CensusGroup{population, latitude, longitude})
			}
		}
	}

	return censusData, nil
}

func main() {
	if len(os.Args) < 4 {
		fmt.Printf("Usage:\nArg 1: file name for input data\nArg 2: number of x-dim buckets\nArg 3: number of y-dim buckets\nArg 4: -v1, -v2, -v3, -v4, -v5, or -v6\n")
		return
	}
	fname, ver := os.Args[1], os.Args[4]
	xdim, err := strconv.Atoi(os.Args[2])
	if err != nil {
		fmt.Println(err)
		return
	}
	ydim, err := strconv.Atoi(os.Args[3])
	if err != nil {
		fmt.Println(err)
		return
	}
	censusData, err := ParseCensusData(fname)
	if err != nil {
		fmt.Println(err)
		return
	}
	length := 220330
	// Some parts may need no setup code
	gridLat := 0.0
	gridLong := 0.0
	minLat := censusData[0].latitude
	maxLat := censusData[0].latitude
	minLong := censusData[0].longitude
	maxLong := censusData[0].longitude
	switch ver {
	case "-v1":

		for i := 1; i < length; i++ {
			if censusData[i].latitude < minLat {
				minLat = censusData[i].latitude
			}
			if censusData[i].latitude > maxLat {
				maxLat = censusData[i].latitude
			}
			if censusData[i].longitude < minLong {
				minLong = censusData[i].longitude
			}
			if censusData[i].longitude > maxLong {
				maxLong = censusData[i].longitude
			}
		}
		gridLat = (maxLat - minLat) / float64(ydim)
		gridLong = (maxLong - minLong) / float64(xdim)
		// YOUR SETUP CODE FOR PART 1
	case "-v2":
		var parameters [4]float64
		parameters[0] = minLat
		parameters[1] = maxLat
		parameters[2] = minLong
		parameters[3] = maxLong
		// YOUR SETUP CODE FOR PART 2
	case "-v3":
		// YOUR SETUP CODE FOR PART 3
	case "-v4":
		// YOUR SETUP CODE FOR PART 4
	case "-v5":
		// YOUR SETUP CODE FOR PART 5
	case "-v6":
		// YOUR SETUP CODE FOR PART 6
	default:
		fmt.Println("Invalid version argument")
		return
	}

	for {
		var west, south, east, north int
		n, err := fmt.Scanln(&west, &south, &east, &north)
		if n != 4 || err != nil || west < 1 || west > xdim || south < 1 || south > ydim || east < west || east > xdim || north < south || north > ydim {
			break
		}

		var population int
		var percentage float64
		switch ver {
		case "-v1":
			// YOUR QUERY CODE FOR PART 1
			minLat := minLat + (gridLat * (float64(south) - 1))
			maxLat := minLat + (gridLat * (float64(north)))
			minLong := minLong + (gridLong * (float64(west) - 1))
			maxLong := minLong + (gridLong * (float64(east)))
			total := 0
			for i := 1; i < length; i++ {
				total = total + censusData[i].population
				if censusData[i].latitude < float64(maxLat) {
					if censusData[i].latitude > float64(minLat) {
						if censusData[i].longitude < float64(maxLong) {
							if censusData[i].longitude > float64(minLong) {
								population = population + censusData[i].population
							}
						}
					}
				}
			}
			percentage = (float64(population) / float64(total)) * 100.0
		case "-v2":
			// YOUR QUERY CODE FOR PART 2
		case "-v3":
			// YOUR QUERY CODE FOR PART 3
		case "-v4":
			// YOUR QUERY CODE FOR PART 4
		case "-v5":
			// YOUR QUERY CODE FOR PART 5
		case "-v6":
			// YOUR QUERY CODE FOR PART 6
		}
		fmt.Printf("%v %.2f%%\n", population, percentage)
	}
}
