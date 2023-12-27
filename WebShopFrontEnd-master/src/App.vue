<template>
  <div>
    <base-nav
      class="navbar"
      :islogin="isLogin"
      :isAdmin="adminCheck()"
      :user="userCurrent"
      :urlbe="url"
    />
    <router-view
      class="view"
      :islogin="isLogin"
      :isAdmin="adminCheck()"
      :user="userCurrent"
      :urlbe="url"
    />
    <footer-place class="footer" />
  </div>
</template>

<script>
import NavBar from "./components/NavBar.vue";
import axios from "axios";
import FooterPlace from "./components/FooterPlace.vue";
export default {
  name: "App",
  components: {
    BaseNav: NavBar,
    FooterPlace,
  },

  data() {
    return {
      isLogin: false,
      isAdmin: false,
      url: "http://localhost:8081",
      userCurrent: {},
    };
  },

  created() {
    this.isLogin = this.checkLogin();
    if (this.isLogin) {
      this.current();
      this.adminCheck();
    }
    console.log("is Login: " + this.isLogin);
    console.log("is Admin: " + this.isAdmin);
  },

  methods: {
    checkLogin() {
      if (localStorage.getItem("token")) {
        return true;
      }
      return false;
    },

    adminCheck() {
      return this.userCurrent.roles == "ROLE_ADMIN";
    },

    async current() {
      try {
        const response = await axios.get("http://localhost:8762/auth/current", {
          headers: {
            "Access-Control-Allow-Origin": "*",
            Authorization: "Bearer " + localStorage.getItem("token"),
          },
        });
        this.userCurrent = response.data;
        return this.userCurrent;
      } catch (error) {
        console.error(error);
      }
    },

  },
};
</script>

<style>
#app {
  font-family: var(--font);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

.navbar {
  position: fixed;
  top: 0;
  z-index: 2;
}

.view {
  margin-top: 70px;
}

nav {
  padding: 30px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: #42b983;
}
</style>
