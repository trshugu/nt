export class App {
  message = 'Welcome to Aurelia!';
  
  get fullName(){
    return `${this.firstName}`;
  }
}
