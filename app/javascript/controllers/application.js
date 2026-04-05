import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };

document.addEventListener("turbo:load", () => {
  const flashMessages = document.querySelectorAll(".flash-message");

  flashMessages.forEach((message) => {
    setTimeout(() => {
      message.style.transition = "opacity 1s ease-in-out";
      message.style.opacity = "0";

      setTimeout(() => {
        message.remove();
      }, 500);
    }, 2000);
  });
});
