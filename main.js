const togglePassword = document.getElementById("togglePassword");
const password = document.getElementById("password");

// PASSWORD TOGGLE

togglePassword.addEventListener("click", function () {

  const type =
    password.getAttribute("type") === "password"
      ? "text"
      : "password";

  password.setAttribute("type", type);

  this.innerHTML =
    type === "password"
      ? '<i class="bi bi-eye-slash"></i>'
      : '<i class="bi bi-eye"></i>';

});


// FORM VALIDATION

const loginForm = document.getElementById("loginForm");
const passwordError = document.getElementById("passwordError");

loginForm.addEventListener("submit", function (e) {

  e.preventDefault();

  if (password.value.length < 8) {

    passwordError.style.display = "block";

    Swal.fire({
      icon: "error",
      title: "Login Failed",
      text: "Password must contain at least 8 characters",
      confirmButtonColor: "#4f46e5",
      background: "#ffffff",
      color: "#111827"
    });

  } else {

    passwordError.style.display = "none";

    Swal.fire({
      icon: "success",
      title: "Welcome Back 👋",
      text: "Login Successful",
      showConfirmButton: false,
      timer: 2000,
      timerProgressBar: true,
      background: "#ffffff",
      color: "#111827"
    });

    setTimeout(() => {

      window.location.href = "dashboard.html";

    }, 2000);

  }

});
