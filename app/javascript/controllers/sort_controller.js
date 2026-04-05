import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  change() {
    const value = this.selectTarget.value;
    const url = new URL(window.location.href);

    url.searchParams.set("sort", value);
    url.searchParams.delete("page");

    window.Turbo.visit(url.toString());
  }
}
