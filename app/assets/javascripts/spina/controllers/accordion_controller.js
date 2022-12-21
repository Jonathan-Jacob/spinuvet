import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["element"];
  }

  toggle() {
    this.elementTargets.forEach((target) => {
      target.classList.toggle('hidden');
    })
  }

}
