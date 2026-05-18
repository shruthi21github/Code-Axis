const step1 =
document.getElementById("step1");

const step2 =
document.getElementById("step2");

const step3 =
document.getElementById("step3");

const indicator1 =
document.getElementById("indicator1");

const indicator2 =
document.getElementById("indicator2");

const indicator3 =
document.getElementById("indicator3");

document
.getElementById("next1")
.addEventListener("click",()=>{

const fullName =
document.getElementById("fullName").value.trim();

const email =
document.getElementById("email").value.trim();

const phone =
document.getElementById("phone").value.trim();

const error =
document.getElementById("step1Error");

if(fullName === '' || email === '' || phone === ''){

error.innerHTML =
"Please fill all fields";

return;

}

step1.classList.remove("active");
step2.classList.add("active");

indicator2.classList.add("active");

});

document
.getElementById("prev1")
.addEventListener("click",()=>{

step2.classList.remove("active");
step1.classList.add("active");

indicator2.classList.remove("active");

});

document
.getElementById("next2")
.addEventListener("click",()=>{

const username =
document.getElementById("username").value.trim();

const password =
document.getElementById("password").value.trim();

const confirmPassword =
document.getElementById("confirmPassword").value.trim();

const error =
document.getElementById("step2Error");

if(username === '' || password === '' || confirmPassword === ''){

error.innerHTML =
"Please fill all fields";

return;

}

if(password.length < 8){

error.innerHTML =
"Password must contain minimum 8 characters";

return;

}

if(password !== confirmPassword){

error.innerHTML =
"Passwords do not match";

return;

}

document.getElementById("summaryName").innerHTML =
document.getElementById("fullName").value;

document.getElementById("summaryEmail").innerHTML =
document.getElementById("email").value;

document.getElementById("summaryUsername").innerHTML =
username;

step2.classList.remove("active");
step3.classList.add("active");

indicator3.classList.add("active");

});

document
.getElementById("prev2")
.addEventListener("click",()=>{

step3.classList.remove("active");
step2.classList.add("active");

indicator3.classList.remove("active");

});

document
.getElementById("createAccount")
.addEventListener("click",()=>{

document
.getElementById("createLoader")
.classList.remove("d-none");

document
.getElementById("createText")
.innerHTML =
"Creating...";

setTimeout(()=>{

document
.getElementById("createLoader")
.classList.add("d-none");

document
.getElementById("createText")
.innerHTML =
"Create Account";

Swal.fire({
icon:'success',
title:'Account Created',
text:'Welcome to Code Axis',
confirmButtonColor:'#4F46E5'
});

},1500);

});

togglePassword(
"togglePassword",
"password"
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