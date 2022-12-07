import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  click() {
    console.log("delegate click on");
    console.log(this.targetElement);
    this.targetElement.click()
  }

  get targetElement() {
    return document.querySelector(this.element.dataset.delegateClickTarget)
  }

}
