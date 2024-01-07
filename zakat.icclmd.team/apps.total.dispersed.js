google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['Month', 'Total Dollar Amount Dispersed'],
    ['Jan',  1000],
    ['Feb',  2000],
    ['Mar',  2303],
    ['Apr',  2404],
    ['May',  2505],
    ['Jun',  2606],
    ['Jul',  2000],
    ['Aug',  3000],
    ['Sep',  2808],
    ['Oct',  2707],
    ['Nov',  2606],
    ['Dec',  2505],
  ]);      

  var options = {
    title: 'Total Amount Dispersed By Year and Month',
    curveType: 'function',
    pointSize: 5,
    legend: { position: 'bottom' },
    vAxis: {
      title: 'Dollar Amount'
    }
  };

  var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
  chart.draw(data, options);
}