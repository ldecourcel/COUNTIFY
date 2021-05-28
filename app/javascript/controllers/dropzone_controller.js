import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['input', 'preview']

  hidden() {
    reader.readAsDataURL("seclect-input").hidden = true;
  }


  connect() {
    ['drag', 'dragstart', 'dragend', 'dragover', 'dragenter', 'dragleave', 'drop'].forEach((eventName) => {
      window.addEventListener(eventName, e => {
        e.preventDefault();
        e.stopPropagation();
      })
    })
  }

  open() {
    this.inputTarget.click();
  }

  change() {
    this.drop()
  }

  drop(event = false) {
    if (event === false) {
      var fileList = this.inputTarget.files
    } else {
      this.inputTarget.files = event.dataTransfer.files
      var fileList = this.inputTarget.files
    }

    Object.entries(fileList).forEach((value, key) => {
      let reader = new FileReader()

      reader.addEventListener('load', e => {
        let img = document.createElement('img')
        img.src = e.srcElement.result
        this.previewTarget.appendChild(img)
      })

      reader.readAsDataURL(value[1]);
    })
  }

  removeFile() {
    if (event.target.tagName != 'IMG') return;
    console.log(event);
    event.target.remove();
    this.inputTarget.value = "";
    // event.target.destroy();
  }
}
