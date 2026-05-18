const loginForm = document.getElementById("loginForm");
const signupForm = document.getElementById("signupForm");

// SWITCH FORMS
document.getElementById("showSignup").addEventListener("click", (e) => {
  e.preventDefault();
  loginForm.classList.remove("active");
  signupForm.classList.add("active");
  clearMsg();
});

document.getElementById("showLogin").addEventListener("click", (e) => {
  e.preventDefault();
  signupForm.classList.remove("active");
  loginForm.classList.add("active");
  clearMsg();
});

// SIGNUP
signupForm.addEventListener("submit", function (e) {
  e.preventDefault();

  const name = document.getElementById("signupName").value.trim();
  const email = document.getElementById("signupEmail").value.trim();
  const password = document.getElementById("signupPassword").value;
  const confirmPassword = document.getElementById("signupConfirmPassword").value;

  const msg = document.getElementById("signupMsg");

  if (!name || !email || !password || !confirmPassword) {
    showMsg(msg, "Fill all fields", "error");
    return;
  }

  if (password.length < 8) {
    showMsg(msg, "Password must be 8+ characters", "error");
    return;
  }

  if (password !== confirmPassword) {
    showMsg(msg, "Passwords do not match", "error");
    return;
  }

  const user = { name, email, password };
  localStorage.setItem("user", JSON.stringify(user));

  showMsg(msg, "Account created successfully 🎉", "success");

  signupForm.reset();

  setTimeout(() => {
    signupForm.classList.remove("active");
    loginForm.classList.add("active");
    clearMsg();
  }, 1500);
});

// LOGIN
loginForm.addEventListener("submit", function (e) {
  e.preventDefault();

  const email = document.getElementById("loginEmail").value.trim();
  const password = document.getElementById("loginPassword").value;

  const msg = document.getElementById("loginMsg");

  const user = JSON.parse(localStorage.getItem("user"));

  if (!user) {
    showMsg(msg, "No account found", "error");
    return;
  }

  if (email === user.email && password === user.password) {
    showMsg(msg, "Login successful 🎉", "success");

    loginForm.reset();

    setTimeout(() => {
      alert(`Welcome ${user.name}`);
    }, 300);

  } else {
    showMsg(msg, "Invalid credentials", "error");
  }
});

// MESSAGE FUNCTION
function showMsg(el, text, type) {
  el.textContent = text;
  el.className = "msg " + type;
}

function clearMsg() {
  document.getElementById("loginMsg").textContent = "";
  document.getElementById("signupMsg").textContent = "";
}