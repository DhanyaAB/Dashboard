import { Component, OnInit } from '@angular/core';
import { DataService } from '../../data.service';

@Component({
  selector: 'app-history',
  templateUrl: './history.component.html',
  styleUrls: ['./history.component.scss']
})
export class HistoryComponent implements OnInit {
  Tests: number;
  criti: number;
  total: number;
  pass: number;
  fail: number;
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

  }
   tests(){
    this.dataservice.gettests()
         .subscribe(count =>{
           var b = count;
           var t = b['data']

           for (let i =0;i<t.length;i++){
              t[i].name = t[i]['robot']['suite']['@name'];
              t[i].stime = t[i]["robot"]["suite"]["status"]['@starttime']
              var d=t[i]["robot"]["suite"]["status"]['@starttime']
              var da = d.slice(0,4)
              var da1=d.slice(4,6)
              var da2=d.slice(6,8)
              t[i].date=da2+ '/' +da1+'/'+da
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

         });

  }
  count_test(){
    this.dataservice.getCount()
         .subscribe(d =>{
           var b = d;
           this.criti= b['critical'];
           this.total = b['total'];
           this.pass= b['pass_tests'];
           this.fail= b['fail_tests'];
           this.count.push(b['pass_tests']);
           this.count.push(b['fail_tests']);
           this.List=(b['list'])
           for (var j=0;j<this.List.length;j++){
             this.pass_data.push(this.List[j]['pass'])
             this.fail_data.push(this.List[j]['fail'])

           }

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
