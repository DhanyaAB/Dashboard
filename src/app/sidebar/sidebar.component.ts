import { Component } from '@angular/core';
import { CommonService } from '../shared/services/common.service';

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss']
})
export class SidebarComponent {

  constructor(public cmnSrv: CommonService) {  }

  sidebarItems = [
    {link: '/', label: 'Dashboard', icon: 'dashboard'},
    // { label: 'Tables', icon: 'grid_on', subItem: [
    //   {link: '/tables/basic', label: 'Basic Table', icon: 'BT'},
    //   {link: '/tables/smart', label: 'smart table', icon: 'ST'}
    // ]},
  ];

}
