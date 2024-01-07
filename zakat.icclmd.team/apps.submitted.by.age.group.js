google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
    var data = google.visualization.arrayToDataTable([
        ['Age Group', 'Submitted', 'Dispersed', 'Rejected'],
        ['<= 20',0,0,0],
        ['21 - 35',0,0,0],
        ['36 - 50',1,1,1],
        ['51 - 65',0,0,0],
        ['> 65',0,0,0]
    ]);
    
    var options = {
        chart: {
            title: 'Applications By Age Group',
            subtitle: 'Submissions, Disbursements, and Rejections',
        },
        bars: 'vertical',
        height: 375,
        colors: ['#00008B', '#006400', '#FF0000']
    };
    
    var chart = new google.charts.Bar(document.getElementById('divucApplicationsSubmittedByAgeGroup'));
    chart.draw(data, google.charts.Bar.convertOptions(options));
}