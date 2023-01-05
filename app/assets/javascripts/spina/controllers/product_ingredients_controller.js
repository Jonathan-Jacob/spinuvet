import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log('pi controller connected');
  }

  add(e) {
    console.log(e.currentTarget);
  }

}
