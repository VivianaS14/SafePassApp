import { Controller } from "@hotwired/stimulus";
import { checkIcon, clipboardIcon } from "../utils/icons";
import * as bootstrap from "bootstrap";

class ClipboardController extends Controller {
  async copy({ params: { content } }) {
    try {
      await navigator.clipboard.writeText(content);
      this.element.innerHTML = checkIcon;
      setTimeout(() => {
        this.element.innerHTML = clipboardIcon;
      }, 1000);
    } catch (error) {
      console.error("Failed to copy!");
    }
  }

  toast() {
    const container = document.getElementById("flash");
    if (!container) return;

    const wrapper = document.createElement("div");
    wrapper.id = "stimulus-toast-container";
    wrapper.classList.add(
      "toast",
      "align-items-center",
      "text-bg-success",
      "border-0",
      "position-absolute",
      "top-0",
      "end-0",
      "z-1",
      "mt-5",
      "me-5"
    );
    wrapper.role = "alert";
    wrapper.ariaAtomic = "true";
    wrapper.ariaLive = "assertive";

    wrapper.innerHTML = `
      <div class="d-flex">
        <div class="toast-body">
            <p class="m-0">Copied!</p>
        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
    `;

    container.appendChild(wrapper);
    const toast = bootstrap.Toast.getOrCreateInstance(wrapper);
    toast.show();

    setTimeout(() => wrapper.remove(), 1000);
  }
}

export default ClipboardController;
