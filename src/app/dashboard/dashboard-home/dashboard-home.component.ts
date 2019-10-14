import { Component, OnInit } from '@angular/core';
import { Chart } from 'chart.js';
import { DataService } from '../../data.service';



@Component({
  selector: 'app-dashboard-home',
  templateUrl: './dashboard-home.component.html',
  styleUrls: ['./dashboard-home.component.scss']
})

export class DashboardHomeComponent implements OnInit {


  Tests: number;
  criti: number;
  total: number;
  chart: any;
  count =[];
  List = [];
  lables = [];
  pass_data =[];
  fail_data =[];
  data = [];
  data2 = [];
  data3 = [];
  list = [];
  

  constructor(private dataservice: DataService) { }

  ngOnInit() {
    
    this.tests();
    this.get_count();
            
  }
 

  plotchart() {

    this.chart = new Chart('canvas1', {
      type: 'pie',
      data: {
        labels: ['pass','Fail'],
        datasets: [
          {
            data: this.count,
            backgroundColor: ['green','rgba(255, 0, 0, 1)'],
            fill: false
          },
        ]
      },
      options: {
        legend: {
          display: false
        },
      //   onClick:function(e){
      //     var activePoints = this.chart.getElementsAtEvent(e);
      //     var selectedIndex = activePoints[0]._index;
      //     this.name = this.data.labels[selectedIndex];
      //     console.log(this.data.datasets[0].data[selectedIndex],this.data.labels[selectedIndex]);
      //     if (this.data.labels[selectedIndex] == "Fail"){
      //       location.href = '/#/fail_tests';
      //     }
      //     else {
      //       location.href = '/#/pass_tests';
      //     }
      // },
        tooltips:{
          enabled: true
        }
      }
    });

    this.chart = new Chart('canvas2',{
      type: 'horizontalBar',
      data: {
         labels: this.lables,
         datasets: [{
            label: "Pass",
            backgroundColor: '#cc3399',
            data:  this.pass_data,
         }, {
            label: "Fail",
            backgroundColor: '#0099ff',
            data: this.fail_data,
         }, ]
      },
      options: {
         responsive: true,
         legend: {
            display: false
         },
         scales: {

            xAxes: [{
               stacked: true
            }],
            yAxes: [{
              stacked: true
           }]
         },

      }
   });
  }

  tests(){
    this.dataservice.gettests()
         .subscribe(count =>{
           var b = count;
           this.Tests = b['tests'];
           for (var i=1;i<=this.Tests;i++){
             this.lables.push(''+i)
           }
           var t = b['data']
           
           for (let i =0;i<t.length;i++){
              t[i].name = t[i]['robot']['suite']['@name'];
              t[i].stime = t[i]["robot"]["suite"]["status"]['@starttime']
              t[i].etime = t[i]["robot"]["suite"]["status"]['@endtime']
              t[i].pass = t[i]['robot']['statistics']['suite']['stat']['@pass']
              t[i].fail = t[i]['robot']['statistics']['suite']['stat']['@fail']
              var test = t[i]['robot']['suite']['test']
              count = 0;
              for (let j=0;j< test.length;j++){
                if (test[j]['status']['@critical'] == 'yes'){
                  count = count + 1
                }              
              }
              t[i].criti = count
              var tsts = [];
              
              for (let k=0;k< test.length;k++){
                test[k].name = test[k]['@name']
                test[k].stime = test[k]['status']['@starttime']
                test[k].etime = test[k]['status']['@endtime']
                test[k].criti = test[k]['status']['@critical']
                test[k].stas = test[k]['status']['@status']
                var kw = test[k]['kw']
                var key =[];
                for (var l=0;l<kw.length;l++){
                  kw[l].name = kw[l]["@name"]
                  kw[l].stime = kw[l]['status']['@starttime']
                  kw[l].etime = kw[l]['status']['@endtime']
                  kw[l].stas = kw[l]['status']['@status']
                  key.push(kw[l])
                }
                var dumy1 =({"time":test[k].stime,"kw":key})
                tsts.push(test[k]);
                this.data3.push(dumy1)
                               
              }
              var dumy;
              dumy =({"time":t[i].stime,"tests":tsts})
              this.data.push(t[i])
              this.data2.push(dumy)
           }
           //console.log(this.data3)
          //  console.log(this.data)
         // console.log(this.data2)
         });
         
  }

  get_count(){
    this.dataservice.getCount()
         .subscribe(d =>{
           var b = d;
           this.criti= b['critical'];
           this.total = b['total'];
           this.count.push(b['pass_tests']);
           this.count.push(b['fail_tests']);
           this.List=(b['list'])
           for (var j=0;j<this.List.length;j++){
             this.pass_data.push(this.List[j]['pass'])
             this.fail_data.push(this.List[j]['fail'])

           }
           setTimeout(() => {
            this.plotchart();
           }, 200)

         })
  }

   expandContent = true;

  findDetails(value) {
     var tst = this.data2.filter(x => x.time === value.stime);
    return tst[0].tests;
  }

  keywords(t){
    var temp = this.data3.filter(y => y.time === t.stime);
    return temp[0].kw;

  }


}
