const step1 = document.getElementById("step1");
const step2 = document.getElementById("step2");
const step3 = document.getElementById("step3");
const step4 = document.getElementById("step4");

const sendOtpBtn = document.getElementById("sendOtpBtn");
const verifyOtpBtn = document.getElementById("verifyOtpBtn");
const resetPasswordBtn = document.getElementById("resetPasswordBtn");

const messageBox = document.getElementById("messageBox");

let generatedOtp = "1234";

sendOtpBtn.addEventListener("click",()=>{

const email =
document.getElementById("email").value.trim();

const emailPattern =
/^[^ ]+@[^ ]+\.[a-z]{2,3}$/;

if(!email.match(emailPattern)){

showMessage(
"Please enter a valid email address.",
"#EF4444"
);

return;

}

toggleLoader("send",true);

setTimeout(()=>{

toggleLoader("send",false);

showMessage(
"OTP sent successfully.",
"#22C55E"
);

step1.style.display = "none";
step2.style.display = "block";

},1500);

});

verifyOtpBtn.addEventListener("click",()=>{

const otp =
document.getElementById("otp").value.trim();

if(otp !== generatedOtp){

showMessage(
"Invalid OTP.",
"#EF4444"
);

return;

}

toggleLoader("verify",true);

setTimeout(()=>{

toggleLoader("verify",false);

showMessage(
"OTP verified successfully.",
"#22C55E"
);

step2.style.display = "none";
step3.style.display = "block";

},1500);

});

resetPasswordBtn.addEventListener("click",()=>{

const newPassword =
document.getElementById("newPassword").value.trim();

const confirmPassword =
document.getElementById("confirmPassword").value.trim();

if(newPassword.length < 8){

showMessage(
"Password must be at least 8 characters.",
"#EF4444"
);

return;

}

if(newPassword !== confirmPassword){

showMessage(
"Passwords do not match.",
"#EF4444"
);

return;

}

toggleLoader("reset",true);

setTimeout(()=>{

toggleLoader("reset",false);

showMessage(
"Password reset successful.",
"#22C55E"
);

step3.style.display = "none";
step4.style.display = "block";

},1500);

});

function showMessage(message,color){

messageBox.style.display = "block";
messageBox.style.color = color;
messageBox.innerHTML = message;

}

function toggleLoader(type,show){

document.getElementById(type+"Loader")
.classList.toggle("d-none",!show);

}

togglePassword(
"toggleNewPassword",
"newPassword"
);

togglePassword(
"toggleConfirmPassword",
"confirmPassword"
);

function togglePassword(toggleId,inputId){

const toggle =
document.getElementById(toggleId);

const input =
document.getElementById(inputId);

toggle.addEventListener("click",()=>{

const type =
input.getAttribute("type") === "password"
? "text"
: "password";

input.setAttribute("type",type);

toggle.innerHTML =
type === "password"
? '<i class="bi bi-eye-slash"></i>'
: '<i class="bi bi-eye"></i>';

});

}