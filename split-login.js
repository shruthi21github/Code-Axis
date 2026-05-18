const splitPassword = document.getElementById("splitPassword");

const splitToggle = document.getElementById("splitToggle");

splitToggle.addEventListener("click", () => {

    const type =
    splitPassword.getAttribute("type") === "password"
    ? "text"
    : "password";

    splitPassword.setAttribute("type", type);

    splitToggle.innerHTML =
    type === "password"
    ? '<i class="bi bi-eye-slash"></i>'
    : '<i class="bi bi-eye"></i>';

});