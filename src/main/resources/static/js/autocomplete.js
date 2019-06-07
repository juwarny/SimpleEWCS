$(document).ready(function(e) {
	var uid =$("meta[name='uid']").attr("content");


	  var token = $("meta[name='_csrf']").attr("content");
    var headerName = $("meta[name='_csrf_header']").attr("content");
	  var csrf = {token: token, headerName: headerName};
	  var code;
	  
	  var updown = {
		upno:null,
		opinion:0,
		stcode:code,
		uid:uid,
		csrf:csrf
	  };
	  
  function autocomplete(inp, arr) {
    /*the autocomplete function takes two arguments,
    the text field element and an array of possible autocompleted values:*/
    var currentFocus;
    /*execute a function when someone writes in the text field:*/
    inp.addEventListener("input", function(e) {
      var a, b, i, val = this.value;
      /*close any already open lists of autocompleted values*/
      closeAllLists();
      if (!val) {
        return false;
      }
      currentFocus = -1;
      /*create a DIV element that will contain the items (values):*/
      a = document.createElement("DIV");
      a.setAttribute("id", this.id + "autocomplete-list");
      a.setAttribute("class", "autocomplete-items");
      /*append the DIV element as a child of the autocomplete container:*/
      this.parentNode.appendChild(a);
      /*for each item in the array...*/
      for (i = 0; i < arr.length; i++) {
        /*check if the item starts with the same letters as the text field value:*/
        if (arr[i].symbol.substr(0, val.length).toUpperCase() == val.toUpperCase()) {
          /*create a DIV element for each matching element:*/
          b = document.createElement("DIV");
          /*make the matching letters bold:*/
          b.innerHTML = "<strong>" + arr[i].symbol.substr(0, val.length) + "</strong>";
          b.innerHTML += arr[i].symbol.substr(val.length);
          /*insert a input field that will hold the current array item's value:*/
          b.innerHTML += "<input type='hidden' value='" + arr[i].symbol + "'>";
          /*execute a function when someone clicks on the item value (DIV element):*/
          code = arr[i].stcode;
          updown.stcode = code;
          
          b.addEventListener("click", function(e) {
            /*insert the value for the autocomplete text field:*/
            inp.value = this.getElementsByTagName("input")[0].value;
            /*close the list of autocompleted values,
            (or any other open lists of autocompleted values:*/
            stockManager.getHistoryStock(code, printStockChart);
            updownManager.getAvgAndCount(code, showAvgAndCount);
            
            closeAllLists();
          });
          a.appendChild(b);
        }
      }
    });

    inp.addEventListener("keydown", function(e) {
      var x = document.getElementById(this.id + "autocomplete-list");
      if (x) x = x.getElementsByTagName("div");
      if (e.keyCode == 40) {

        currentFocus++;
        addActive(x);
      } else if (e.keyCode == 38) { //up
        /*If the arrow UP key is pressed,
        decrease the currentFocus variable:*/
        currentFocus--;
        /*and and make the current item more visible:*/
        addActive(x);
      } else if (e.keyCode == 13) {
        /*If the ENTER key is pressed, prevent the form from being submitted,*/
        e.preventDefault();
        if (currentFocus > -1) {
          if (x) x[currentFocus].click();
        }
      }
    });

    function addActive(x) {
      if (!x) return false;
      removeActive(x);
      if (currentFocus >= x.length) currentFocus = 0;
      if (currentFocus < 0) currentFocus = (x.length - 1);
      x[currentFocus].classList.add("autocomplete-active");
    }

    function removeActive(x) {
      for (var i = 0; i < x.length; i++) {
        x[i].classList.remove("autocomplete-active");
      }
    }

    function closeAllLists(elmnt) {

      var x = document.getElementsByClassName("autocomplete-items");
      for (var i = 0; i < x.length; i++) {
        if (elmnt != x[i] && elmnt != inp) {
          x[i].parentNode.removeChild(x[i]);
        }
      }
    }

    document.addEventListener("click", function(e) {
      closeAllLists(e.target);
    });
  }

  var stocklist;

  stockManager.getAll(getAllStockList);

  function printStockChart(list) {
	  am4core.ready(drawchart(list));    
  }

  function getAllStockList(list) {
    stocklist = list;
    autocomplete(document.getElementById("stockInput"), stocklist);
  }
  
	function drawchart(list) {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end

	var chart = am4core.create("chartdiv", am4charts.XYChart);
	chart.paddingRight = 20;

	chart.dateFormatter.inputDateFormat = "yyyy-MM-dd";

	var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
	dateAxis.renderer.grid.template.location = 0;

	var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
	valueAxis.tooltip.disabled = true;

	var series = chart.series.push(new am4charts.CandlestickSeries());
	series.dataFields.dateX = "date";
	series.dataFields.valueY = "close";
	series.dataFields.openValueY = "open";
	series.dataFields.lowValueY = "low";
	series.dataFields.highValueY = "high";
	series.simplifiedProcessing = true;
	series.tooltipText = "Open:{openValueY.value}\nLow:{lowValueY.value}\nHigh:{highValueY.value}\nClose:{valueY.value}";

	chart.cursor = new am4charts.XYCursor();

	// a separate series for scrollbar
	var lineSeries = chart.series.push(new am4charts.LineSeries());
	lineSeries.dataFields.dateX = "date";
	lineSeries.dataFields.valueY = "close";
	// need to set on default state, as initially series is "show"
	lineSeries.defaultState.properties.visible = false;

	// hide from legend too (in case there is one)
	lineSeries.hiddenInLegend = true;
	lineSeries.fillOpacity = 0.5;
	lineSeries.strokeOpacity = 0.5;

	var scrollbarX = new am4charts.XYChartScrollbar();
	scrollbarX.series.push(lineSeries);
	chart.scrollbarX = scrollbarX;

	chart.data = list
	
  }
	function showAvgAndCount(data){
		if(!data[0][1]){
			$("#count").html("0");
			$("#avg").html("0");
		}else{
			$("#count").html(String(data[0][0]));
			$("#avg").html(String(data[0][1]));
		}
		
		var obj = {
        		stcode:code,
        		uid:uid
        };
        updownManager.getUpdownOfUser(obj, printUserOpinion);
	}

	function printUserOpinion(ud){
		if(ud.upno){
			updown.upno = ud.upno;
			updown.opinion = ud.opinion;
			updown.stcode = ud.code;
			updown.uid = ud.uid;
		}
		$("#userOpinion").val(updown.opinion);		
	}
	
	$("#userOpinion").on("click", function(){
		updown.opinion = $("#userOpinion").val();
		updown.stcode = code;
		updown.uid = uid;
		
		if(!updown.upno){
			//새로 만듬
			updownManager.add(updown, showAvgAndCount);
		}else{
			//업데이트 함
			updownManager.update(updown, showAvgAndCount);
		}
	});
});
