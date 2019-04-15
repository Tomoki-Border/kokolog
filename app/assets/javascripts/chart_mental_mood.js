window.draw_graph = function(){

// 日付を取得
var dt = new Date();
var dt0 = dt.getDate();
var dt1 = dt.getDate()-1;
var dt2 = dt.getDate()-2;
var dt3 = dt.getDate()-3;
var dt4 = dt.getDate()-4;
var dt5 = dt.getDate()-5;
var dt6 = dt.getDate()-6;

// arr_json取得
var feedscores1weekJson = $('.feed_scores_1week_json').val();
// arr_jsonをパースし配列にする
var feedscores1week = JSON.parse(feedscores1weekJson);

var ctx = document.getElementById('ChartMood').getContext('2d');
var ChartMood = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: [dt6, dt5, dt4, dt3, dt2, dt1, dt0],
        datasets: [{
            data: feedscores1week,
             backgroundColor: [
                'rgba(153, 102, 255, 0.2)',
                'rgba(19, 74, 99, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(255, 99, 132, 0.2)'
            ],
            borderColor: [
                'rgba(153, 102, 255, 1)',
                'rgba(19, 74, 99, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(255, 99, 132, 1)'
            ],           

            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        legend: {
           display: false
         },
        scales: {                          //軸設定
            yAxes: [{                      //y軸設定
         display: true,             //表示設定
         ticks: {                      //最大値最小値設定
           min: 0,                   //最小値
           max: 5,                  //最大値
           stepSize: 1               //軸間隔
         },
         }],
        }
    }
});
}