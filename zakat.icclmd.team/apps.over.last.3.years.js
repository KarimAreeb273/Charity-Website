google.charts.load('current', { packages: ['corechart', 'bar'] });
google.charts.setOnLoadCallback(drawMaterial);

function drawMaterial() {
  var data = google.visualization.arrayToDataTable([
    ['Year', 'Submitted', 'Investigated', 'Qualified', 'Dispersed', 'Rejected'],
    ['2001', 123, 123, 123, 123, 123],
    ['2002', 456, 456, 456, 456, 456],
    ['2003', 789, 789, 789, 789, 789],
  ]);

  var materialOptions = {
    chart: {
      title: 'Applications Over The Last 3 Years'
    },
    bars: 'horizontal',
    colors: ['#0000FF', '#FF8C00', '#800080', '#008000', '#FF0000']
  };
  var materialChart = new google.charts.Bar(document.getElementById('chart_div'));
  materialChart.draw(data, materialOptions);
}
