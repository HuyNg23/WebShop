
<script setup>
import { reactive} from 'vue';
import {useVuelidate} from '@vuelidate/core';
import { required, alpha, email, numeric, maxLength, minLength, sameAs} from '@vuelidate/validators';


const formData = reactive({
	firstName: "",
	userName: "",
	email: "",
	pass: "",
	lastName: "",
	phone: "",
	address: "",
	conpass: "",

})

const rules = {
	firstName: {required ,alpha},
	userName: {required, alpha},
	email: {required, email},
	pass: {required, maxLength: maxLength(20), minLength: minLength(1)},
	lastName: {required, alpha},
	phone: {required, numeric, minLength: minLength(10), maxLength: maxLength(11)},
	address: {required},
	conpass: {required, sameAs: sameAs(formData.pass)}
}
// const rules = computed(()=>{

// })

const v$ = useVuelidate(rules, formData)

const submitForm = async () => {

	const result = await v$.value.$validate();
	if(result) {
		alert("Success")
	} else {
		alert("Invalid errors")
	}
}
</script>

<template>
	<div class="p-p-container">
	  <div class="Header">
		<h2 >Let's Register</h2>
	  </div>	
	  <div class="p-container">
		  
		  <div class="container">
			<div class="login-content" id="form-1">
			  <form action="index.html" >				
				<div class="input-div one">
				  <div class="i">
					<font-awesome-icon :icon="['fas', 'user']" />
				  </div>
				  <div class="div">
					<input
					type="text"
					class="input"
					placeholder="First Name"
					v-model="formData.firstName"
				  />
				  <span class="error" v-if="v$.firstName.$error">Invalid Name.</span>
				  </div>
				</div>
				<div class="input-div one">
				  <div class="i">
					<font-awesome-icon :icon="['fas', 'user']" />
				  </div>
				  <div class="div">
					<input
					type="text"
					class="input"
					placeholder="User Name"
					v-model="formData.userName"
				  />
				  <span class="error" v-if="v$.userName.$error">Invalid Name.</span>
				  </div>
				</div>
  
  
				<div class="input-div phone">
				  <div class="i">
					<font-awesome-icon :icon="['fas', 'envelope']" />
				  </div>
				  <div class="div">
					<input
					type="text"
					class="input"
					placeholder="Email"
					v-model="formData.email"
				  />
				  <span class="error" v-if="v$.email.$error">Invalid Email.</span>
				  </div>
				</div>
				<div class="input-div pass">
				  <div class="i">
					<font-awesome-icon :icon="['fas', 'lock']" />
				  </div>
				  <div class="div">
					<input
					type="password"
					class="input"
					placeholder="Password"
					v-model="formData.pass"
				  />
				  <span class="error" v-if="v$.pass.$error">Invalid Password.</span>
				  </div>
				</div>
  
  
  
			  </form>
			</div>
			<div class="login-content" id="form-2">
			  <form action="index.html">	
				<div class="input-div one">
				  <div class="i">
					<font-awesome-icon :icon="['fas', 'user']" />
				  </div>
				  <div class="div">
					<input
					type="text"
					class="input"
					placeholder="Last Name"
					v-model="formData.lastName"
				  />
				  <span class="error" v-if="v$.lastName.$error">Invalid Name.</span>
				  </div>
				</div>
				<div class="input-div phone">
				  <div class="i">
					<font-awesome-icon :icon="['fas', 'phone']" />
				  </div>
				  <div class="div">
					<input
					type="text"
					class="input"
					placeholder="Phone Number"
					v-model="formData.phone"
				  />
				  <span class="error" v-if="v$.phone.$error">Invalid Phone Number.</span>
				  </div>
				</div>
				<div class="input-div phone">
				  <div class="i">
					<font-awesome-icon :icon="['fas', 'location-dot']" />
				  </div>
				  <div class="div">
					<input
					type="text"
					class="input"
					placeholder="Address"
					v-model="formData.address"
				  />
				  <span class="error" v-if="v$.address.$error">Invalid Address.</span>
				  </div>
				</div>
				<div class="input-div pass">
				  <div class="i">
					<font-awesome-icon :icon="['fas', 'lock']" />
				  </div>
				  <div class="div">
					<input
					type="password"
					class="input"
					placeholder="Password Confirm"
					v-model="formData.conpass"
				  />
				  <span class="error" v-if="v$.conpass.$error">Incorrect.</span>
				  </div>
				</div>
  
				  
			  </form>
			</div>
		  </div>
	  </div>
	  <div class="Footer">
		<button type="submit" class="btn" @click="submitForm">Register</button>
	  </div>
	  <div class="Footer">
		<router-link to="/login"><button type="submit" class="btn">Login</button></router-link>
	  </div>
	</div>
  </template>

<style scoped>
* {
	padding: 0;
	margin: 0;

}

body {
	font-family: 'Poppins', sans-serif;
	overflow: hidden;
}
.p-p-container{
  width: 100vw;
  height: 100vh;
}

.Header{
	display: flex;
	justify-content: center;
	position: relative;
	top: 170px;
}
.Header h2{
	color: #333;
	text-transform: uppercase;
	font-size: 3.2rem;
}

.p-container {
	display: flex;
	justify-content: center;
	position: relative;
	top: 125px;
  }

.container {
	width: 55vw;
	height: 55vh;
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	grid-gap: 3rem;
	padding: 0 2rem;

	
}



#form-1.login-content {
	display: flex;
	justify-content: right;
	align-items: center;
	text-align: center;
}
#form-2.login-content {
	display: flex;
	justify-content: left;
	align-items: center;
	text-align: center;
}

.img img {
	width: 550px;
}

form {
	width: 360px;
}

.login-content img {
	height: 150px;
}



.login-content .input-div {
	position: relative;
	display: grid;
	grid-template-columns: 7% 93%;
	margin: 25px 0;
	padding: 5px 0;
	border-bottom: 2px solid #d9d9d9;
}

.login-content .input-div.one {
	margin-top: 0;
}



.i {
	color: #d9d9d9;
	display: flex;
	justify-content: center;
	align-items: center;
}

.i i {
	transition: .3s;
}

.input-div>div {
	position: relative;
	height: 45px;
}

.input-div>div>h5 {
	position: absolute;
	left: 10px;
	top: 50%;
	transform: translateY(-50%);
	color: #999;
	font-size: 18px;
	transition: .3s;
}

.input-div:before,
.input-div:after {
	content: '';
	position: absolute;
	bottom: -2px;
	width: 0%;
	height: 2px;
	background-color: #38d39f;
	transition: .4s;
}

.input-div:before {
	right: 50%;
}

.input-div:after {
	left: 50%;
}

.input-div.focus:before,
.input-div.focus:after {
	width: 50%;
}

.input-div.focus>div>h5 {
	top: -5px;
	font-size: 15px;
}

.input-div.focus>.i>i {
	color: #38d39f;
}

.input-div>div>input {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	border: none;
	outline: none;
	background: none;
	padding: 0.5rem 0.7rem;
	font-size: 1.2rem;
	color: #555;
	font-family: 'poppins', sans-serif;
}

.input-div.pass {
	margin-bottom: 4px;
}


.input-div small {
	position: absolute;
	top: 120%;
	right:  0;
}


a {
	display: block;
	text-align: right;
	text-decoration: none;
	color: #999;
	font-size: 0.9rem;
	transition: .3s;
}

a:hover {
	color: #38d39f;
}
.Footer{
	display: flex;
	justify-content: center;
	position: relative;
	top: 10px;
}
.btn {
	display: block;
	width: 290px;
	height: 50px;
	border-radius: 25px;
	outline: none;
	border: none;
	background-image: linear-gradient(to right, #32be8f, #38d39f, #32be8f);
	background-size: 50%;
	font-size: 1.2rem;
	color: #fff;
	font-family: 'Poppins', sans-serif;
	text-transform: uppercase;
	margin: 1rem 0;
	cursor: pointer;
	transition: .5s;
}

.btn:hover {
	background-position: right;
}


@media screen and (max-width: 1050px) {
	.container {
		grid-gap: 5rem;
	}
}

@media screen and (max-width: 1000px) {
	form {
		width: 290px;
	}

	.login-content h2 {
		font-size: 2.4rem;
		margin: 8px 0;
	}

	.img img {
		width: 400px;
	}
}

@media screen and (max-width: 900px) {
	.container {
		grid-template-columns: 1fr;
	}

	.img {
		display: none;
	}

	.wave {
		display: none;
	}

	.login-content {
		justify-content: center;
	}
}

.error {
	position: relative;
	top: 50px;
	color: red;
	
}
</style>


