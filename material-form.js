// ===== FORMS =====
const loginForm = document.getElementById("loginForm");
const signupForm = document.getElementById("signupForm");

// ===== SWITCH FORMS =====
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

// ===== SIGNUP FUNCTION =====
signupForm.addEventListener("submit", function (e) {
  e.preventDefault();

  const name = document.getElementById("signupName").value.trim();
  const email = document.getElementById("signupEmail").value.trim();
  const password = document.getElementById("signupPassword").value;
  const confirmPassword = document.getElementById("signupConfirmPassword").value;

  const signupMsg = document.getElementById("signupMsg");

  // VALIDATION
  if (!name || !email || !password || !confirmPassword) {
    showMsg(signupMsg, "Please fill all fields", "error");
    return;
  }

  if (password.length < 8) {
    showMsg(signupMsg, "Password must be at least 8 characters", "error");
    return;
  }

  if (password !== confirmPassword) {
    showMsg(signupMsg, "Passwords do not match", "error");
    return;
  }

  // SAVE USER (LOCAL STORAGE)
  const userData = {
    name,
    email,
    password
  };

  localStorage.setItem("user", JSON.stringify(userData));

  showMsg(signupMsg, "Account created successfully 🎉", "success");

  signupForm.reset();

  // AUTO SWITCH TO LOGIN
  setTimeout(() => {
    signupForm.classList.remove("active");
    loginForm.classList.add("active");
    clearMsg();
  }, 1500);
});

// ===== LOGIN FUNCTION =====
loginForm.addEventListener("submit", function (e) {
  e.preventDefault();

  const email = document.getElementById("loginEmail").value.trim();
  const password = document.getElementById("loginPassword").value;

  const loginMsg = document.getElementById("loginMsg");

  const savedUser = JSON.parse(localStorage.getItem("user"));

  if (!savedUser) {
    showMsg(loginMsg, "No account found. Please create one.", "error");
    return;
  }

  if (email === savedUser.email && password === savedUser.password) {

    showMsg(loginMsg, "Login successful 🎉", "success");

    loginForm.reset();

    // ALERT AFTER SUCCESS
    setTimeout(() => {
      alert(`Welcome ${savedUser.name}! Login successful.`);
    }, 300);

    // OPTIONAL REDIRECT
    // setTimeout(() => {
    //   window.location.href = "dashboard.html";
    // }, 1000);

  } else {
    showMsg(loginMsg, "Invalid email or password", "error");
  }
});

// ===== MESSAGE FUNCTION =====
function showMsg(element, message, type) {
  element.textContent = message;
  element.className = "msg " + (type === "success" ? "success" : "");
}

// ===== CLEAR MESSAGES =====
function clearMsg() {
  document.getElementById("loginMsg").textContent = "";
  document.getElementById("signupMsg").textContent = "";
}