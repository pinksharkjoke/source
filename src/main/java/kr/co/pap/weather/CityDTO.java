package kr.co.pap.weather;

import lombok.Data;
import lombok.ToString;

@Data
public class CityDTO {
	private CoordDTO coord;
	private String country;
	private int id;
	private String name;
	private int population;
	private String sunrise;
	private String sunset;
	private int timezone;
	
	public void allSet(CoordDTO crood, String country, int id,
						   String name, int population, String sunrise,
						   String sunset, int timezone) {
		this.coord=crood;
		this.country=country;
		this.id=id;
		this.name=name;
		this.population=population;
		this.sunrise=sunrise;
		this.sunset=sunset;
		this.timezone=timezone;
	}
}
