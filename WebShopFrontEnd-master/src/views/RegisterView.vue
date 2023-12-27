<template>
  <div class="container">
    <img class="wave" src="../assets/img/wave.png" />
    <div class="login-content">
      <form @submit.prevent="submitForm">
        <img src="../assets/img/avatar.svg" />
        <h2 class="title">Let's Register</h2>
        <div class="form-input">
          <div class="form-left">
            <div class="input-div one">
              <div class="i">
                <font-awesome-icon :icon="['fas', 'user']" />
              </div>
              <div class="div">
                <input
                  type="text"
                  class="input"
                  placeholder="First Name"
                  v-model="firstName"
                />
              </div>
              <span
                v-if="errors.firstName"
                :class="{ 'fade-out': shouldFadeOut }"
                >{{ errors.firstName }}</span
              >
            </div>
            <div class="input-div one">
              <div class="i">
                <font-awesome-icon :icon="['fas', 'user']" />
              </div>
              <div class="div">
                <input
                  type="text"
                  class="input"
                  placeholder="UserName"
                  v-model="username"
                />
              </div>
              <span
                v-if="errors.username"
                :class="{ 'fade-out': shouldFadeOut }"
                >{{ errors.username }}</span
              >
            </div>
            <div class="input-div pass">
              <div class="i">
                <font-awesome-icon :icon="['fas', 'envelope']" />
              </div>
              <div class="div">
                <input
                  type="text"
                  class="input"
                  placeholder="Email"
                  v-model="email"
                />
              </div>
              <span v-if="errors.email">{{ errors.email }}</span>
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
                  v-model="password"
                />
              </div>
              <span
                v-if="errors.password"
                :class="{ 'fade-out': shouldFadeOut }"
                >{{ errors.password }}</span
              >
            </div>
          </div>
          <div class="form-right">
            <div class="input-div one">
              <div class="i">
                <font-awesome-icon :icon="['fas', 'user']" />
              </div>
              <div class="div">
                <input
                  type="text"
                  class="input"
                  placeholder="Last Name"
                  v-model="lastName"
                />
              </div>
              <span
                v-if="errors.lastName"
                :class="{ 'fade-out': shouldFadeOut }"
                >{{ errors.lastName }}</span
              >
            </div>
            <div class="input-div one">
              <div class="i">
                <font-awesome-icon :icon="['fas', 'phone']" />
              </div>
              <div class="div">
                <input
                  type="text"
                  class="input"
                  placeholder="Phone"
                  v-model="phone"
                />
              </div>
              <span
                v-if="errors.phone"
                :class="{ 'fade-out': shouldFadeOut }"
                >{{ errors.phone }}</span
              >
            </div>
            <div class="input-div pass">
              <div class="i">
                <font-awesome-icon :icon="['fas', 'location-dot']" />
              </div>
              <div class="div">
                <input
                  type="text"
                  class="input"
                  placeholder="Address"
                  v-model="address"
                />
              </div>
              <span
                v-if="errors.address"
                :class="{ 'fade-out': shouldFadeOut }"
                >{{ errors.address }}</span
              >
            </div>
            <div class="input-div pass">
              <div class="i">
                <font-awesome-icon :icon="['fas', 'lock']" />
              </div>
              <div class="div">
                <input
                  type="password"
                  class="input"
                  placeholder="Confirm password"
                  v-model="confirmPassword"
                />
              </div>
              <span
                v-if="errors.confirmPassword"
                :class="{ 'fade-out': shouldFadeOut }"
                >{{ errors.confirmPassword }}</span
              >
            </div>
          </div>
        </div>
        <button type="submit" class="btn" @click="submitForm">Register</button>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      firstName: "",
      lastName: "",
      email: "",
      phone: "",
      address: "",
      username: "",
      password: "",
      confirmPassword: "",
      isLogin: true,
      token: "",
      user: {},
      errors: {},
      shouldFadeOut: false,
    };
  },

  props: ["islogin", "isAdmin", "urlbe"],

  methods: {
    async register() {
      try {
        const response = await axios.post(this.urlbe + "/user/create", {
          username: this.username,
          password: this.confirmPassword,
          firstName: this.firstName,
          lastName: this.lastName,
          email: this.email,
          phone: this.phone,
          address: this.address,
          roles: "ROLE_USER",
        });
        console.log(response);
        alert("Register successfully!");
        this.$router.push("/login");
      } catch (error) {
        console.error(error);
      }
    },

    validEmail(email) {
      var re =
        /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(email);
    },

    isVietnamesePhoneNumber(number) {
      return /^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$/.test(
        number
      );
    },

    validPassword(password) {
      return password.length >= 6;
    },

    async checkAcountUser() {
      try {
        const response = await axios.get(
          this.urlbe + "/user/checkusername?username=" + this.username,
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
            },
          }
        );
        return response.data;
      } catch (error) {
        console.error(error);
      }
    },

    async checkEmail() {
      try {
        const response = await axios.get(
          this.urlbe + "/user/checkemail?email=" + this.email,
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
            },
          }
        );
        return response.data;
      } catch (error) {
        console.error(error);
      }
    },

    async submitForm() {
      this.errors = {};

      if (this.firstName == "") {
        this.errors.firstName = "FirstName is required.";
      }

      if (this.lastName == "") {
        this.errors.lastName = "LastName is required.";
      }

      if (this.username == "") {
        this.errors.username = "Username is required.";
      } else if (await this.checkAcountUser()) {
        this.errors.username = "Username already exists.";
      }

      if (this.phone == "") {
        this.errors.phone = "Phone number is required.";
      } else if (!this.isVietnamesePhoneNumber(this.phone)) {
        this.errors.phone = "Phone number is not valid.";
      }

      if (this.email == "") {
        this.errors.email = "Email is required.";
      } else if (!this.validEmail(this.email)) {
        this.errors.email = "Email is not valid.";
      } else if (await this.checkEmail()) {
        this.errors.email = "Email already exists.";
      }

      if (this.address == "") {
        this.errors.address = "Address is required.";
      }

      if (this.password == "") {
        this.errors.password = "Password is required.";
      }else if (!this.validPassword(this.password)) {
        this.errors.password = "Password must be at least 6 characters.";
      }

      if (this.confirmPassword == "") {
        this.errors.confirmPassword = "Confirm Password is required.";
      } else if (this.confirmPassword != this.password) {
        this.errors.confirmPassword = "Confirm Password is not correct.";
      }

      if (Object.keys(this.errors).length === 0) {
        await this.register();
      }
    },
    mounted() {
      setTimeout(() => {
        this.shouldFadeOut = true;
      }, 3000); // 3 giây
    },
  },
};
</script>

<style scoped>
* {
  padding: 0;
  margin: 0;
  box-sizing: border-box;
}

body {
  font-family: "Poppins", sans-serif;
  overflow: hidden;
}

.wave {
  position: fixed;
  bottom: 0;
  left: 0;
  height: 100%;
  width: 100%;
  z-index: -1;
}

.container {
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  grid-template-columns: repeat(2, 1fr);
  grid-gap: 7rem;
  padding: 0 2rem;
}

.img {
  display: flex;
  justify-content: flex-end;
  align-items: center;
}

.login-content {
  width: 100%;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  text-align: center;
}

form {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
}

.form-input {
  width: 100%;
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.img img {
  width: 500px;
}

.form-right,
.form-left {
  width: 360px;
  padding: 10px;
}

.login-content img {
  height: 100px;
}

.login-content h2 {
  margin: 15px 0;
  color: #333;
  text-transform: uppercase;
  font-size: 2.9rem;
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
  transition: 0.3s;
}

.input-div > div {
  position: relative;
  height: 45px;
}

.input-div > div > h5 {
  position: absolute;
  left: 10px;
  top: 50%;
  transform: translateY(-50%);
  color: #999;
  font-size: 18px;
  transition: 0.3s;
}

.input-div:before,
.input-div:after {
  content: "";
  position: absolute;
  bottom: -2px;
  width: 0%;
  height: 2px;
  background-color: #38d39f;
  transition: 0.4s;
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

.input-div.focus > div > h5 {
  top: -5px;
  font-size: 15px;
}

.input-div.focus > .i > i {
  color: #38d39f;
}

.input-div > div > input {
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
  color: #000;
  font-family: "poppins", sans-serif;
}

.input-div.pass {
  margin-bottom: 4px;
}

.input-div span {
  bottom: 0;
  left: 1;
  position: absolute;
  color: red;
}

.fade-out {
  opacity: 0;
  transition: opacity 0.5s ease-out;
}

a {
  display: block;
  text-align: right;
  text-decoration: none;
  color: #000;
  font-size: 0.9rem;
  transition: 0.3s;
}

a:hover {
  color: #38d39f;
}

.btn {
  display: block;
  width: 30%;
  height: 50px;
  border-radius: 25px;
  outline: none;
  border: 2px solid #d9d9d9;
  background-image: linear-gradient(to right, #32be8f, #38d39f, #32be8f);
  background-size: 200%;
  font-size: 1.2rem;
  color: #fff;
  font-family: "Poppins", sans-serif;
  text-transform: uppercase;
  margin: 1rem 0;
  cursor: pointer;
  transition: 0.5s;
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
</style>

