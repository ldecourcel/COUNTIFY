import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["infos", "form", "return","updatedreturn"]

  // connect() {
  //   console.log(this.formTarget);
  //   console.log(this.infosTarget);
  //   console.log(this.returnTarget);
  // }

  displayForm() {
    this.infosTarget.classList.add('d-none');
    this.formTarget.classList.remove('d-none');
    this.returnTarget.classList.add('d-none');
    this.updatedreturnTarget.classList.remove('d-none');
  }

  update(event) {
    event.preventDefault();
    const url = this.formTarget.action
    fetch(url, {
      method: 'PATCH',
      headers: { 'Accept': 'text/html' },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.cardTarget.outerHTML = data;
      })
  }
}
