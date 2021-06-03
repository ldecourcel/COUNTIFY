import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['button', 'body', 'arrows']
  static values = { company: String, direction: String }

  async fetch(event) {
    event.preventDefault();
    const sort = event.target.dataset.sort

    const response = await fetch(`
                      /companies/${this.companyValue}/fetch_operations?direction=${this.directionValue}&sort=${sort}`,
                      { Accept: 'application/json' }
                     )

    const data = await response.json()
    this.swap(data)
    this.arrow(event.target)
    this.directionValue = this.directionValue === 'asc' ? 'desc' : 'asc'
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

