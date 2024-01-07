google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

  var data = google.visualization.arrayToDataTable([
    ['Gender', 'Applications'],
    ['Male',     11],
    ['Female',    7]
  ]);

  var options = {
    title: 'Applications Submitted By Gender'
  };

  var chart = new google.visualization.PieChart(document.getElementById('piechart'));

  chart.draw(data, options);
}