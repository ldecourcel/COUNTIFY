import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['button', 'body', 'arrows']
  static values = { company: String }

  // connect() {
  //   console.log(this.buttonTargets)
  //   console.log(this.arrowTargets)
  // }

  async fetch(event) {
    event.preventDefault();
    const sort = event.target.dataset.sort

    const response = await fetch(`
                      /companies/${this.companyValue}/fetch_operations?direction=asc&sort=${sort}`,
                      { Accept: 'application/json' }
                     )

    const data = await response.json()
    this.swap(data)
    // console.log(event.target)
    this.arrow(event.target)
  }

  swap(data) {
    this.bodyTarget.innerHTML = data.html
  }

  arrow(target) {
    target.closest('.title-header')
          .querySelectorAll('i')
          .forEach((arrow) => arrow.classList.toggle('active'))
  }
}

