import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DataService {

  constructor(private http: HttpClient) { }

  getCount ():Observable<any> {
    return this.http.get<any>('http://127.0.0.1:5000/count');
  }

  tests ():Observable<any> {
    return this.http.get<any>('http://127.0.0.1:5000/tests');
  }

  gettests ():Observable<any>{
    return this.http.get<any>('http://127.0.0.1:5000/');
  }
}

export class ModalService {
  private modals: any[] = [];

  add(modal: any) {
      // add modal to array of active modals
      this.modals.push(modal);
  }

  remove(id: string) {
      // remove modal from array of active modals
      this.modals = this.modals.filter(x => x.id !== id);
  }

  open(id: string) {
      // open modal specified by id
      let modal: any = this.modals.filter(x => x.id === id)[0];
      modal.open();
  }

  close(id: string) {
      // close modal specified by id
      let modal: any = this.modals.filter(x => x.id === id)[0];
      modal.close();
  }
}
