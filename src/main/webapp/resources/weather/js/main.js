/**
 * main.js
 * http://www.codrops.com
 *
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 메롱ㅁ롱메롱
 * Copyright 2016, Codrops
 * http://www.codrops.com
 */
;(function(window) {

	'use strict';

	// Helper vars and functions.
	function extend( a, b ) { // 객체를 합치는 extend 함수를 overWrite 함.
		for( var key in b ) {  // b 가 가지고 있는 모든 열거가능한 객체에 대해 반복한다.
			if( b.hasOwnProperty( key ) ) { // b 안에 key 라는 프로퍼티를 가지고 있는지 여부를 반환
				a[key] = b[key]; // a 에 b 를 넣는다.
			}
		}
		return a;
	}

	function createDOMEl(type, className, content) {
		var el = document.createElement(type);
		el.className = className || '';
		el.innerHTML = content || '';
		return el;
	}

	function createDOMElNS(type, className, content) {
		var el = document.createElementNS('http://www.w3.org/2000/svg', type);
		el.setAttribute('class', className || '');
		el.innerHTML = content || '';
		return el;
	}

		// The SVG path element that represents the sea/wave.
	var wavePath, days = [], citiesCtrl, currentCity = 0, plyrReady,

		mainContainer = document.querySelector('main'),
		graphContainer = mainContainer.querySelector('.content--graph'),
		// The SVG/graph element.
		graph = graphContainer.querySelector('.graph'),
		// SVG viewbox values arr.
		viewbox = graph.getAttribute('viewBox').split(/\s+|,/),
		// Viewport size.
		winsize = {width: window.innerWidth, height: window.innerHeight},
		oscilation = .4,
		timeIntervals = 8, // 시간 나눔.
		/**
		 * Weather data:
		 * . day: the day of the week
		 * . tempmin: let´s assume the temp goes from 0m - 30m. 
		 * 		The temp array represents the intervals of time (00h00m - 04h00m, 04h00m - 08h00m, ..., 20h00m - 24h00m).
		 * 	 	In this case we assume 6 intervals of time (timeIntervals = 6).
		 * 	 	The temp interval represents the average value for the day (or whatever value we want to display when not seeing each individual temp value per time interval)
		 * . tempmax: same logic but showcasing the temp's period in seconds.
		 * . humidity: same logic but showcasing the humidity's temperature.
		 * . state (weather state / weather icon):
		 *   	1-sunny
		 *		2-partly cloudy
		 *		3-cloudy
		 *		4-rain
		 *		5-thunderstorm  
		 *		6-clearnight
		 *		7-partlycloudynight
		 *		8-rainynight
		 *		9-thunderstormnight
		 *	. air: same logic but showcasing the air's temperature.
		 *	. windspeed: same logic but showcasing the wind´s speed.
		 *	. winddirection: same logic but showcasing the wind´s direction.
		 */
		
		citiesCtrlContainer = mainContainer.querySelector('.custom-select'),
		daysToShow = data[currentCity].weather.length,
		// Width of one day.
		slice = winsize.width/daysToShow,
		// Width of each time interval.
		subSliceWidth = slice/timeIntervals,
		// Show webcam ctrl
		webcamCtrl = document.querySelector('.btn--cam'),
		webcamCloseCtrl = document.querySelector('.btn--close');

	function DayForecast(weather, options) {
		this.weather = weather;
		this.options = extend({}, this.options); // 기존 옵션을 toString 화 하고,
		extend(this.options, options); // 기존 옵션에 함수에 들어온 옵션을 추가한다.

		this.showhourly = true;

		this._build();
		this.setData();
	}

	DayForecast.prototype.options = {
		units : {
			temperature : '°C',
			speed : 'km/h',
			percent : '%'
			// length : 'm',
			// time : 's'
		} 
	};

	DayForecast.prototype._build = function() {
		this.DOM = {};

		// Contents:
		this.DOM.state = createDOMEl('div', 'wstate-wrap', 
		'<svg class="wstate wstate--sunny"><use xlink:href="#state-sunny"></use></svg>' + 
		'<svg class="wstate wstate--cloudy"><use xlink:href="#state-cloudy"></use></svg>' + 
		'<svg class="wstate wstate--partlycloudy"><use xlink:href="#state-partlycloudy"></use></svg>' + 
		'<svg class="wstate wstate--rain"><use xlink:href="#state-rain"></use></svg>' + 
		'<svg class="wstate wstate--thunders"><use xlink:href="#state-thunders"></use></svg>' + 
		'<svg class="wstate wstate--clearnight"><use xlink:href="#state-clearnight"></use></svg>' + 
		'<svg class="wstate wstate--partlycloudynight"><use xlink:href="#state-partlycloudynight"></use></svg>' + 
		'<img class="wstate wstate--rainynight" src="../resources/weather/assets/img/rainynight.png">' + 
		'<img class="wstate wstate--snowynight" src="../resources/weather/assets/img/snowynight.png">' + 
		'<img class="wstate wstate--snow" src="../resources/weather/assets/img/snow.png">' + 
		'<img class="wstate wstate--mist" src="../resources/weather/assets/img/mist.png">');

		this.DOM.timeperiodWrapper = createDOMEl('span', 'slice__data slice__data--period slice__data--hidden');
		this.DOM.timeperiodSVG = createDOMElNS('svg', 'icon icon--clock', '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-clock"></use>');
		this.DOM.timeperiod = createDOMEl('span', 'slice__data slice__data--time');
		this.DOM.timeperiodWrapper.appendChild(this.DOM.timeperiodSVG);
		this.DOM.timeperiodWrapper.appendChild(this.DOM.timeperiod);
		
		this.DOM.dayWrapper = createDOMEl('span', 'slice__data slice__data--dateday');
		this.DOM.day = createDOMEl('span', 'slice__data slice__data--day');
		this.DOM.date = createDOMEl('span', 'slice__data slice__data--date');
		this.DOM.dayWrapper.appendChild(this.DOM.day);
		this.DOM.dayWrapper.appendChild(this.DOM.date);

		this.DOM.airWrapper = createDOMEl('span', 'slice__data slice__data--air')
		this.DOM.airSVG = createDOMElNS('svg', 'icon icon--thermometer', '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-thermometer"></use>');
		this.DOM.air = createDOMEl('span', 'slice__data slice__data--temperature');
		this.DOM.airWrapper.appendChild(this.DOM.airSVG);
		this.DOM.airWrapper.appendChild(this.DOM.air);
		
		this.DOM.wind = createDOMEl('span', 'slice__data slice__data--wind');
		this.DOM.windspeed = createDOMEl('span', 'slice__data slice__data--wind-speed');
		this.DOM.winddirectionWrapper = createDOMEl('span', 'slice__data slice__data--wind-direction');
		this.DOM.winddirection = createDOMElNS('svg', 'icon icon--direction', '<use xlink:href="#icon-direction"></use>');
		this.DOM.winddirectionWrapper.appendChild(this.DOM.winddirection);
		this.DOM.wind.appendChild(this.DOM.winddirection);
		this.DOM.wind.appendChild(this.DOM.windspeed);
		
		this.DOM.temp = createDOMEl('span', 'slice__data slice__data--temp');
		this.DOM.tempSVG = createDOMElNS('svg', 'icon icon--thermometer', '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-thermometer"></use>');
		this.DOM.tempSVG1 = createDOMElNS('svg', 'icon icon--thermometer', '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-thermometer"></use>');
		this.DOM.tempmin = createDOMEl('span', 'slice__data slice__data--tempmin');
		this.DOM.tempmax = createDOMEl('span', 'slice__data slice__data--tempmax');
		this.DOM.temp.appendChild(this.DOM.tempSVG);
		this.DOM.temp.appendChild(this.DOM.tempmin);
		this.DOM.temp.appendChild(this.DOM.tempSVG1);
		this.DOM.temp.appendChild(this.DOM.tempmax);

		this.DOM.popWrapper = createDOMEl('span', 'slice__data slice__data--pop');
		this.DOM.popSVG = createDOMElNS('svg', 'icon icon--drop', '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-drop"></use>');
		this.DOM.pop = createDOMEl('span', 'slice__data slice__data--temperature');
		this.DOM.popWrapper.appendChild(this.DOM.popSVG);
		this.DOM.popWrapper.appendChild(this.DOM.pop);

		this.DOM.humidityWrapper = createDOMEl('span', 'slice__data slice__data--humidity');
		this.DOM.humiditySVG = createDOMElNS('svg', 'icon icon--drop', '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-drop"></use>');
		this.DOM.humidity = createDOMEl('span', 'slice__data slice__data--temperature');
		this.DOM.humidityWrapper.appendChild(this.DOM.humiditySVG);
		this.DOM.humidityWrapper.appendChild(this.DOM.humidity);
		
		this.DOM.feellikeWrapper = createDOMEl('span', 'slice__data slice__data--feellike');
		this.DOM.feellikeSVG = createDOMElNS('svg', 'icon icon--thermometer', '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-thermometer"></use>');
		this.DOM.feellike = createDOMEl('span', 'slice__data slice__data--temperature');
		this.DOM.feellikeWrapper.appendChild(this.DOM.feellikeSVG);
		this.DOM.feellikeWrapper.appendChild(this.DOM.feellike);

		this.DOM.slice = createDOMEl('div');
		this.DOM.slice.appendChild(this.DOM.state);
		this.DOM.slice.appendChild(this.DOM.timeperiodWrapper);
		this.DOM.slice.appendChild(this.DOM.dayWrapper);
		this.DOM.slice.appendChild(this.DOM.airWrapper);
		this.DOM.slice.appendChild(this.DOM.wind);
		this.DOM.slice.appendChild(this.DOM.temp);
		this.DOM.slice.appendChild(this.DOM.humidityWrapper);

		this._buildHourlyLayout();
	};

	DayForecast.prototype._buildHourlyLayout = function() {
		this.DOM.subslicesWrapper = createDOMEl('div', 'slice__hover');
		var subslicesHTML = '';
		for(var i = 0; i <= timeIntervals-1; ++i) {
			subslicesHTML += '<div></div>';
		}
		this.DOM.subslicesWrapper.innerHTML = subslicesHTML;
		this.DOM.slice.appendChild(this.DOM.subslicesWrapper);

		var self = this;
		this.mouseleaveFn = function(ev) {
			if( !self.showhourly ) return false;
			self.DOM.timeperiodWrapper.classList.add('slice__data--hidden');
			self.setData();
		};
		this.DOM.slice.addEventListener('mouseleave', self.mouseleaveFn);

		this.mouseenterFn = function(ev) {
			if( !self.showhourly ) return false;
			self._showTimePeriod(self.DOM.subslices.indexOf(ev.target));
		};
		this.DOM.subslices = [].slice.call(this.DOM.subslicesWrapper.querySelectorAll('div'));
		this.DOM.subslices.forEach(function(subslice) {
			subslice.addEventListener('mouseenter', self.mouseenterFn);
		});
	};

	DayForecast.prototype.setData = function(weather) {
		if( weather ) {
			this.weather = weather;
		}
		for(var w in this.weather) {
			this[w] = this.weather[w];
		}

		this._setState();
		this._setTimePeriod();
		this._setDay();
		this._setDate();
		this._setTempMin();
		this._setTempMax();
		this._setAir();
		this._setWindSpeed();
		this._setWindDirection();
		this._setPop();
		this._setFeelLike();
		this._setHumidity();
	};

	DayForecast.prototype._setState = function(val, timeperiod) {
		var val = val !== undefined ? val : this.state.display;

		if( timeperiod !== undefined ) {
			this.DOM.slice.className = 'slice ' + this._getStateClassname(val) + ' ' + this._getPeriodClassname(timeperiod);
		}
		else {
			this.DOM.slice.className = 'slice ' + this._getStateClassname(val);
		}
	};
	
	DayForecast.prototype._setTimePeriod = function(val) {
		var val = val !== undefined ? val : '&nbsp;';
		this.DOM.timeperiod.innerHTML = val;
	};
	
	DayForecast.prototype._setDay = function(val) {
		var val = val !== undefined ? val : this.day;
		this.DOM.day.innerHTML = val;
	};

	DayForecast.prototype._setDate = function(val) {
		var val = val !== undefined ? val : this.date;
		this.DOM.date.innerHTML = val;
	};
	
	DayForecast.prototype._setAir = function(val) {
		var val = val !== undefined ? val : this.air.display;
		this.DOM.air.innerHTML = val + ' ' + this.options.units.temperature;
	};
	
	DayForecast.prototype._setWindSpeed = function(val) {
		var val = val !== undefined ? val : this.windspeed.display;
		this.DOM.windspeed.innerHTML = val + ' ' + this.options.units.speed;
	};
	
	DayForecast.prototype._setWindDirection = function(val, windspeed) {
		var val = val !== undefined ? val : this.winddirection.display;
		this.DOM.winddirection.style.WebkitTransform = this.DOM.winddirection.style.transform = 'rotate(' + val + 'deg)';

		anime.remove(this.DOM.winddirection);
		var windspeed = windspeed !== undefined ? windspeed : this.windspeed.display;
		anime({
			targets: this.DOM.winddirection,
			rotate: val + 40/100*windspeed,
			duration: 200-windspeed,
			loop: true,
			direction: 'alternate',
			easing: 'easeInOutQuad'
		});
	};
	
	DayForecast.prototype._setTempMin = function(val) {
		var val = val !== undefined ? val : this.tempmin;
		this.DOM.tempmin.innerHTML ='max : ' + val + ' ' + this.options.units.temperature;
	};
	
	DayForecast.prototype._setTempMax = function(val) {
		var val = val !== undefined ? val : this.tempmax;
		this.DOM.tempmax.innerHTML ='min : ' + val + ' ' + this.options.units.temperature;
	};

	DayForecast.prototype._setPop = function(val) {
		var val = val !== undefined ? val : this.pop.display;
		this.DOM.pop.innerHTML = (val * 100) + ' ' + this.options.units.percent;
	}

	DayForecast.prototype._setFeelLike = function(val) {
		var val = val !== undefined ? val : this.feellike.display;
		this.DOM.feellike.innerHTML = val + ' ' + this.options.units.temperature;
	};

	DayForecast.prototype._setHumidity = function(val) {
		var val = val !== undefined ? val : this.humidity.display;
		this.DOM.humidity.innerHTML = val + ' ' + this.options.units.percent;
	};

	DayForecast.prototype._showTimePeriod = function(period) {
		var arr = stringProc(this.state.hourly);
		var arr1 = stringProc(this.air.hourly);
		var arr2 = stringProc(this.windspeed.hourly);
		var arr3 = stringProc(this.winddirection.hourly);
		var arr4 = stringProc(this.pop.hourly);
		var arr5 = stringProc(this.feellike.hourly);
		var arr6 = stringProc(this.humidity.hourly);
		
		this._setState(arr[period], period);
		this.DOM.timeperiodWrapper.classList.remove('slice__data--hidden');
		this._setTimePeriod(this._getTimePeriod(period));
		this._setAir(arr1[period]);
		this._setWindSpeed(arr2[period]);
		this._setWindDirection(arr3[period], arr2[period]);
		this._setPop(arr4[period]);
		this._setFeelLike(arr5[period]);
		this._setHumidity(arr6[period]);
	};

	function stringProc(val){
		var val1 = val.split('[');
		var val2 = val1[1].split(']');
		var val3 = val2[0];
		var arr = new Array();
		arr = val3.split(',');

		return arr;
	}

	DayForecast.prototype._getTimePeriod = function(period) {
		var interval = 24/timeIntervals;
		return period*interval+':00 - ' + (period+1)*interval + ':00';
	};

	DayForecast.prototype._getStateClassname = function(state) {
		var c = 'slice--state-';
		switch(state) {
			case 1 : c += 'sunny'; break;
			case 2 : c += 'partlycloudy'; break;
			case 3 : c += 'cloudy'; break;
			case 4 : c += 'rain'; break;
			case 5 : c += 'thunders'; break;
			case 6 : c += 'clearnight'; break;
			case 7 : c += 'partlycloudynight'; break;
			case 8 : c += 'rainynight'; break;
			case 9 : c += 'snowynight'; break;
			case 10 : c += 'mist'; break;
			case 11 : c += 'snow'; break;
		};
		return c;
	};

	DayForecast.prototype._getPeriodClassname = function(timeperiod) {
		return 'slice--period-' + (timeperiod + 1); // todo: this depends on the [timeIntervals]
	};

	DayForecast.prototype.getEl = function() {
		return this.DOM.slice;
	};

	function init() {
		layout();
		// createGraph();
		// initEvents();
	}

	function layout() {
		citiesCtrl = createDOMEl('select');
		citiesCtrl.innerHTML = '<select>';
		for(var i = 0, len = data.length; i <= len-1; ++i) {
			citiesCtrl.innerHTML += '<option value="' + i + '" ' + (i === 0 ? 'selected' : '') + '>' + data[i].name + '</option>'
		}
		citiesCtrl.innerHTML += '</select>';
		citiesCtrlContainer.appendChild(citiesCtrl);
		citiesCtrl.addEventListener('change', changeCityFn);

		var slices = createDOMEl('div', 'slices');
		// Create a "slice" per day.
		for(var i = 0; i <= daysToShow-1; ++i) {
			var dayWeather = data[currentCity].weather[i];
			var day = new DayForecast(dayWeather);
			days.push(day);
			slices.appendChild(day.getEl());
		}

		graphContainer.insertBefore(slices, graph);
	}

	function changeCityFn(ev) {
		currentCity = ev.target.value;
		
		mainContainer.className = 'theme-' + parseInt(Number(currentCity)+1);

		for(var i = 0; i <= daysToShow-1; ++i) {
			days[i].setData(data[currentCity].weather[i]);
		}

		
	}

	init();

})(window).sleep(3000)