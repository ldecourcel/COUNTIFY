import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['arrow']

  connect() {
    console.log(this.amountTarget);
    console.log(this.dateTarget);
  }

  // change() {
  //   this.arrowTargets.forEach(item => item.classList.toggle('d-none'))
  // }
}
