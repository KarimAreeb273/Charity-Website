google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);
function drawChart() {
    var data = google.visualization.arrayToDataTable([
        ['Month', 'Average Processing Days','Submitted Applications'],
        ['Jan',0.0,0],
        ['Feb',0.0,0],
        ['Mar',0.0,0],
        ['Apr',0.0,0],
        ['May',0.0,0],
        ['Jun',0.0,0],
        ['Jul',0.0,0],
        ['Aug',3.0,1],
        ['Sep',0.0,0],
        ['Oct',0.0,0],
        ['Nov',0.0,0],
        ['Dec',0.0,0]
    ]);
    
    var options = {
        title: 'Average Processing Days By Year and Month',
        curveType: 'function',
        pointSize: 5,
        legend: { position: 'bottom' },
        vAxis: {title: 'Days'},
        colors: ['blue', 'orange']
    };
    
    var chart = new google.visualization.LineChart(document.getElementById('divucChartApplicationsAverageProcessingDaysByMonth'));
    chart.draw(data, options);
}