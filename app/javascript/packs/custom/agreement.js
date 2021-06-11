document.addEventListener("DOMContentLoaded", () => {
  const agreementBox = document.getElementById("agreement");
  agreementBox.addEventListener("change", () => {
    toggleButtonClass();
  });
});

function toggleButtonClass() {
  const slackButton = document.getElementById("sign-in-with-slack-button");
  classList = slackButton.classList;
  if (
    classList.contains("opacity-50") &&
    classList.contains("pointer-events-none")
  ) {
    classList.remove("opacity-50");
    classList.remove("pointer-events-none");
  } else {
    classList.add("opacity-50");
    classList.add("pointer-events-none");
  }
}
