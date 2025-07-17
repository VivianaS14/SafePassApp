import { Controller } from "@hotwired/stimulus";

class SearchController extends Controller {
  // We access to the button we want to toggle
  static targets = ["clearButton"];

  toggleClearButton(event) {
    if (event.target.value) {
      this.clearButtonTarget.classList.remove("d-none");
    } else {
      this.clearButtonTarget.classList.add("d-none");
    }
  }
}

export default SearchController;
