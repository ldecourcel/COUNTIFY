import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = [ "form", "btnsubmit" ]

  connect() {
    // console.log(this.inputTarget);
    console.log(this.formTarget);
    console.log(this.btnsubmitTarget);

  }

  submit(event) {
    event.preventDefault();
    fetchWithToken(this.formTarget.action, {
      method: "POST",
      headers: {
        "Accept": "application/html",
        // "Content-Type": "application/json"
      },
      body: new FormData(this.formTarget)
    })
    this.formTarget.reset();
    this.btnsubmitTarget.removeAttribute('disabled');
  }
}