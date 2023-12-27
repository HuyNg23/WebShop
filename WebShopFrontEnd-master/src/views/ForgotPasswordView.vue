<template>
  <div class="container">
    <img class="wave" src="../assets/img/wave.png" />
    <div class="container">
      <div class="img">
        <img src="../assets/img/undraw_window_shopping_re_0kbm.svg" />
      </div>
      <div class="login-content">
        <div action="index.html">
          <form @submit.prevent="submitForm">
            <img src="../assets/img/avatar.svg" />
            <h2 class="title">Quên mật khẩu</h2>
            <div class="input-div one">
              <div class="i">
                <font-awesome-icon :icon="['fas', 'user']" />
              </div>
              <div class="div">
                <input
                  type="text"
                  class="input"
                  placeholder="Username"
                  v-model="username"
                />
              </div>
              <span v-if="errors.username">
                {{ errors.username }}
              </span>
            </div>

            <button type="submit" class="btn">Lấy lại mật khẩu</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      // isLogin: true,
      username: "",
      password: "",
      token: "",
      user: {},
      errors: {},
    };
  },

  props: ["islogin", "isAdmin", "urlbe"],

  methods: {
    async submitForm() {
      this.errors = {};

      if (this.username == "") {
        this.errors.username = "Username is required.";
      } else if (!await this.checkAcountUser()) {
        this.errors.username = "Username not exists.";
      }

      if (Object.keys(this.errors).length === 0) {
        await this.login();
      }
    },
    async login() {
      try {
        const response = await axios.post(
          this.urlbe + "/mail/forgot?username=" + this.username
        );
        alert("Kiểm tra email để lấy lại mật khẩu");
        return response.data;
      } catch (error) {
        alert("Tài khoản không tồn tại");
      }
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
  z-index: -1;
}

.container {
  width: 100vw;
  height: 100vh;
  display: grid;
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
  display: flex;
  justify-content: flex-start;
  align-items: center;
  text-align: center;
}

.img img {
  width: 500px;
}

form {
  width: 360px;
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

.lable {
  width: 100%;
  font-size: 20px;
  text-align: left;
  font-weight: 500;
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

.input-div span {
  bottom: 0;
  left: 1;
  position: absolute;
  color: red;
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
  color: #555;
  font-family: "poppins", sans-serif;
}

.input-div.pass {
  margin-bottom: 4px;
}

a {
  display: block;
  text-align: right;
  text-decoration: none;
  color: #999;
  font-size: 0.9rem;
  transition: 0.3s;
}

a:hover {
  color: #38d39f;
}

.btn {
  display: block;
  width: 100%;
  height: 50px;
  border-radius: 25px;
  outline: none;
  border: none;
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
