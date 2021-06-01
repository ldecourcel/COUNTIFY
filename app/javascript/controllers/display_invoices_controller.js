import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "rowone", "rowtwo", "rowthree", "btndisplayone", "btndisplaytwo", "btndisplaythree",  "btnhideone", "btnhidetwo", "btnhidethree" ]

  connect() {
    console.log(this.rowTarget);
    console.log(this.btndisplayTarget);
    console.log(this.btnhideTarget);
  }

  displayRowOne() {
    this.rowoneTarget.classList.toggle('d-none');
    this.btndisplayoneTarget.classList.toggle('d-none');
    this.btnhideoneTarget.classList.toggle('d-none');
  }

  displayRowTwo() {
    this.rowtwoTarget.classList.toggle('d-none');
    this.btndisplaytwoTarget.classList.toggle('d-none');
    this.btnhidetwoTarget.classList.toggle('d-none');
  }

  displayRowThree() {
    this.rowthreeTarget.classList.toggle('d-none');
    this.btndisplaythreeTarget.classList.toggle('d-none');
    this.btnhidethreeTarget.classList.toggle('d-none');
  }

}