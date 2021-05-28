import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["table", "buttondisplay", "buttonhide"]

  connect() {
    console.log(this.tableTarget);
    console.log(this.buttondisplayTarget);
    console.log(this.buttonhideTarget);

  }

  displayTable() {
    this.tableTarget.classList.toggle('d-none');
    this.buttondisplayTarget.classList.toggle('d-none');
    this.buttonhideTarget.classList.toggle('d-none');
  }
}