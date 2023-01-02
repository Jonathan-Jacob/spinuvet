import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["input"];
  }

  clear() {
    this.inputTarget.value = '';
  }
}
