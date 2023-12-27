<template>
  <div class="user-container">
    <h1 class="user-heading">
      <img
        :src="this.urlbe + '/file/' + user.avatarUrl"
        alt=""
        class="avt-img"
        v-if="user.avatarUrl != null"
      />
      <img
        src="../assets/images/people/143086968_2856368904622192_1959732218791162458_n.png"
        alt=""
        class="avt-img"
        v-if="user.avatarUrl == null"
      />
      Hello, {{ user.lastName }}
    </h1>
    <div class="user-info">
      <hr />
      <table class="user-details">
        <tr>
          <th>Tên người dùng:</th>
          <td>{{ user.firstName }} {{ user.lastName }}</td>
        </tr>
        <tr>
          <th>Email:</th>
          <td>{{ user.email }}</td>
        </tr>
        <tr>
          <th>Số điện thoại:</th>
          <td>{{ user.phone }}</td>
        </tr>
        <tr>
          <th>Địa chỉ:</th>
          <td>{{ user.address }}</td>
        </tr>
      </table>
      <div>
        <button @click="editUserInfo" class="button edit-button">
          Chỉnh sửa thông tin
        </button>
        <button @click="changePasswordForm" class="button edit-button">
          Thay đổi mật khẩu
        </button>
        <button @click="getOrder" class="button edit-button">
          Xem đơn hàng
        </button>
        <!-- <div style="display: flex;justify-content: space-between;">
      <div></div> -->
        <button class="logout" @click="logout">
          Đăng xuất <font-awesome-icon :icon="['fas', 'right-from-bracket']" />
        </button>
        <!-- </div> -->
      </div>
    </div>
    <div v-if="editing" class="edit-form">
      <h2 class="form-heading">Chỉnh sửa thông tin</h2>
      <form @submit.prevent="updateUserInfo" class="form">
        <div class="form-group">
          <label>Họ đệm:</label>
          <input
            type="text"
            id="edit_username"
            v-model="user.firstName"
            class="form-input"
          />
          <span v-if="errors.firstName">
            {{ errors.firstName }}
          </span>
        </div>
        <div class="form-group">
          <label>Tên:</label>
          <input
            type="text"
            id="edit_username"
            v-model="user.lastName"
            class="form-input"
          />
          <span v-if="errors.lastName">
            {{ errors.lastName }}
          </span>
        </div>
        <div class="form-group">
          <label for="edit_email">Email:</label>
          <input
            type="email"
            id="edit_email"
            v-model="email"
            class="form-input"
            required
          />
          <span v-if="errors.email">
            {{ errors.email }}
          </span>
        </div>
        <div class="form-group">
          <label for="edit_phone">Số điện thoại:</label>
          <input
            type="text"
            id="edit_phone"
            v-model="user.phone"
            class="form-input"
            required
          />
          <span v-if="errors.phone">
            {{ errors.phone }}
          </span>
        </div>
        <div class="form-group">
          <label for="edit_address">Địa chỉ:</label>
          <input
            type="text"
            id="edit_address"
            v-model="user.address"
            class="form-input"
            required
          />
          <span v-if="errors.address">
            {{ errors.address }}
          </span>
        </div>
        <div class="form-group" style="justify-content: flex-start">
          <div>
            <label for="edit_address">Thay avatar:</label>
            <input
              type="file"
              id="edit_address"
              class="form-input"
              @change="inputImage"
              accept="image/gif, image/jpeg, image/png"
              style="width: 160px"
            />
          </div>
        </div>
        <div class="display-btn">
          <button type="submit" class="button primary-button">
            Lưu thay đổi
          </button>
          <button @click="cancelEdit" class="button secondary-button">
            Hủy
          </button>
        </div>
      </form>
    </div>
    <div v-if="changingPassword" class="password-form">
      <h2 class="form-heading">Thay đổi mật khẩu</h2>
      <form
        @submit.prevent="changePassword"
        class="form"
        style="width: 60%; justify-content: center"
      >
        <div
          class="form-group"
          style="width: 100%; justify-content: space-between"
        >
          <label for="current_password">Mật khẩu hiện tại:</label>
          <input
            type="password"
            id="current_password"
            v-model="currentPassword"
            class="form-input"
            required
          />
          <span v-if="errors.currentPassword">
            {{ errors.currentPassword }}
          </span>
        </div>
        <div
          class="form-group"
          style="width: 100%; justify-content: space-between"
        >
          <label for="new_password">Mật khẩu mới:</label>
          <input
            type="password"
            id="new_password"
            v-model="newPassword"
            class="form-input"
            required
          />
          <span v-if="errors.newPassword">
            {{ errors.newPassword }}
          </span>
        </div>
        <div
          class="form-group"
          style="width: 100%; justify-content: space-between"
        >
          <label for="confirm_password">Xác nhận mật khẩu mới:</label>
          <input
            type="password"
            id="confirm_password"
            v-model="confirmPassword"
            class="form-input"
            required
          />
          <span v-if="errors.confirmPassword">
            {{ errors.confirmPassword }}
          </span>
        </div>
        <div class="display-btn">
          <button type="submit" class="button primary-button">
            Thay đổi mật khẩu
          </button>
          <button @click="cancelChangePassword" class="button secondary-button">
            Hủy
          </button>
        </div>
      </form>
    </div>

    <div v-if="showOrder" class="order">
      <div class="list-order">
        <h2>Tổng số đơn hàng: {{ order.totalElements }}</h2>
        <div
          class="order-item"
          v-for="orderItem in order.content"
          :key="orderItem.id"
        >
          <div class="display-item underline">
            <h4>Mã đơn hàng: {{ orderItem.id }}</h4>
            <h4>Tổng tiền: {{ formatPrice(orderItem.totalPrice) }}</h4>
            <h4>Ngày đặt hàng: {{ orderItem.orderDate }}</h4>
            <h4>Tình trạng: {{ getStatus(orderItem.hasProcess) }}</h4>
          </div>

          <div class="display-item">
            <h4 style="width: 120px"></h4>
            <h4 style="width: 320px">Tên sản phẩm</h4>
            <h4 style="width: 50px">Size</h4>
            <h4 style="width: 100px">Số lượng</h4>
            <h4 style="width: 90px">Giá tiền</h4>
            <h4 style="width: 90px">Giảm giá</h4>
            <h4 style="width: 100px">Thành tiền</h4>
            <h4></h4>
          </div>

          <div class="display-item">
            <div
              class="cart-item"
              v-for="(cartItem, index) in orderItem.cartItemEntity"
              :key="index"
            >
              <img
                :src="
                  this.urlbe +
                  '/file/' +
                  cartItem.productEntity.imageEntities[0].imgURL
                "
                alt=""
                class="item-img"
              />
              <h2>{{ cartItem.productEntity.productName }}</h2>
              <h3 style="width: 50px">{{ cartItem.size }}</h3>
              <h3 style="width: 100px">{{ cartItem.quantity }}</h3>
              <h3>{{ formatPrice(cartItem.productEntity.price) }}</h3>
              <h3 style="width: 90px">
                {{ cartItem.productEntity.discount }}%
              </h3>
              <h3>
                {{
                  formatPrice(
                    ((cartItem.productEntity.price *
                      (100 - cartItem.productEntity.discount)) /
                      100) *
                      cartItem.quantity
                  )
                }}
              </h3>
              <h3></h3>
            </div>
          </div>
        </div>
      </div>
      <div class="v-pagination__container">
        <div class="pagination__left">
          <button @click="cancelShowOrder" class="button secondary-button">
            Đóng
          </button>
        </div>
        <div class="pagination__right">
          <div class="pagination">
            <div class="pagination__prev" @click="changePage('prev')">&lt;</div>
            <div
              v-for="(page, index) in pages"
              :key="index"
              class="pagination__item"
              :class="{ 'pagination__item--active': page == pageNumber }"
              @click="changePage(page)"
            >
              {{ page }}
            </div>
            <div class="pagination__after" @click="changePage('after')">></div>
          </div>
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
      username: "Người dùng mẫu",
      email: "",
      phoneNumber: "1234567890",
      firstName: "",
      lastName: "",
      phone: "",
      address: "",
      avatarUrl: "",
      editedGender: "",
      editing: false,
      changingPassword: false,
      showOrder: false,
      editedUsername: "",
      editedEmail: "",
      editedPhoneNumber: "",
      editedAddress: "",
      currentPassword: "",
      newPassword: "",
      confirmPassword: "",
      user: {},
      order: [],
      pageNumber: 1,
      totalPage: 0,
      errors: {},
    };
  },

  props: ["islogin", "isAdmin", "urlbe"],

  methods: {
    logout() {
      localStorage.removeItem("token");
      window.location.replace("http://localhost:8080/login");
    },

    formatPrice(number) {
      return new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
      }).format(number);
    },

    editUserInfo() {
      this.editing = true;
      this.editedUsername = this.username;
      this.editedEmail = this.email;
      this.editedPhoneNumber = this.phoneNumber;
      this.editedAddress = this.address;
      this.editedBirthDate = this.birthDate;
      this.editedGender = this.gender;
    },

    cancelEdit() {
      this.editing = false;
    },

    inputImage(event) {
      this.avatarUrl = event.target.files[0];
      console.log(this.avatarUrl);
    },

    changePasswordForm() {
      this.changingPassword = true;
    },

    changePassword() {
      if (this.user.password != this.currentPassword) {
        this.errors.newPassword = "Mật khẩu hiện tại không đúng";
      } else if (this.confirmPassword != this.newPassword) {
        this.errors.confirmPassword = "Mật khẩu xác nhận không đúng";
      }
      if (Object.keys(this.errors).length === 0) {
        this.updateUser();
      }
      this.changingPassword = false;
      alert("Thay đổi mật khẩu thành công!");
      this.currentPassword = "";
      this.newPassword = "";
      this.confirmPassword = "";
    },

    cancelChangePassword() {
      this.changingPassword = false;
      this.currentPassword = "";
      this.newPassword = "";
      this.confirmPassword = "";
    },

    getOrder() {
      this.showOrder = true;
      this.getListOrder();
    },

    cancelShowOrder() {
      this.showOrder = false;
    },

    getStatus(status) {
      if (status == true) {
        return "Đã được xử lý";
      }
      return "Chưa được xử lý";
    },

    isVietnamesePhoneNumber(number) {
      return /^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$/.test(
        number
      );
    },

    validEmail(email) {
      var re =
        /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(email);
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

    async updateUserInfo() {
      this.errors = {};

      this.firstName = this.user.firstName;
      if (this.user.firstName == "") {
        this.errors.firstName = "FirstName is required.";
      }

      this.lastName = this.user.lastName;
      if (this.lastName == "") {
        this.errors.lastName = "LastName is required.";
      }

      this.phone = this.user.phone;
      if (this.phone == "") {
        this.errors.phone = "Phone number is required.";
      } else if (!this.isVietnamesePhoneNumber(this.phone)) {
        this.errors.phone = "Phone number is not valid.";
      }

      if (this.email == "") {
        this.errors.email = "Email is required.";
      } else if (!this.validEmail(this.email)) {
        this.errors.email = "Email is not valid.";
      } else if (await this.checkEmail() && (this.email != this.user.email)) {
        this.errors.email = "Email already exists.";
      }

      this.address = this.user.address;
      if (this.address == "") {
        this.errors.address = "Address is required.";
      }

      if (Object.keys(this.errors).length === 0) {
        await this.updateUser();
      }
    },

    async updateUser() {
      if (this.firstName != "") {
        this.user.firstName = this.firstName;
      }
      if (this.email != "") {
        this.user.email = this.email;
      }
      if (this.phone != "") {
        this.user.phone = this.phone;
      }
      if (this.address != "") {
        this.user.address = this.address;
      }
      if (this.newPassword != "") {
        this.user.password = this.newPassword;
      }

      try {
        const response = await axios.put(
          this.urlbe + "/user/update/" + this.user.id,
          {
            username: this.user.username,
            password: this.user.password,
            roles: this.user.roles,
            firstName: this.user.firstName,
            lastName: this.user.lastName,
            phone: this.user.phone,
            email: this.user.email,
            address: this.user.address,
            avatarUrl: this.user.avatarUrl,
            userInfoEntity: {
              id: this.user.userInfoEntity.id,
              firstName: this.user.firstName,
              lastName: this.user.lastName,
              avatarUrl: this.user.avatarUrl,
            },
          },
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        if (this.avatarUrl != "") {
          this.upLoadFile(this.avatarUrl, this.user.id);
        }
        this.user = response.data;
        alert("Cập nhật thông tin thành công");
        window.location.replace("http://localhost:8080/user");
        return response;
      } catch (error) {
        console.error(error);
      }
    },

    async upLoadFile(imgProduct, pid) {
      let formdata = new FormData();
      formdata.append("file", imgProduct);
      formdata.append("uid", pid);
      try {
        const response = await axios.post(
          this.urlbe + "/file/avatar_upload",
          formdata,
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        return response;
      } catch (error) {
        console.error(error);
      }
    },

    async current() {
      try {
        const response = await axios.get("http://localhost:8762/auth/current", {
          headers: {
            "Access-Control-Allow-Origin": "*",
            Authorization: "Bearer " + localStorage.getItem("token"),
          },
        });
        this.user = response.data;
        return this.user;
      } catch (error) {
        console.error(error);
      }
    },

    async getListOrder() {
      try {
        const response = await axios.get(
          this.urlbe +
            "/order/list/" +
            this.user.id +
            "?limit=1&page=" +
            this.pageNumber +
            "&sortby=id&sort=desc",
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        this.order = response.data;
        this.totalPage = this.order.totalPages;
        return this.user;
      } catch (error) {
        console.error(error);
      }
    },

    changePage(page) {
      if (page == "prev" && this.pageNumber > 1) {
        this.pageNumber--;
      } else if (page == "after" && this.pageNumber < this.totalPage) {
        this.pageNumber++;
      } else if (typeof page == "number") {
        this.pageNumber = page;
      }
      // this.$emit("update:pageNumber", this.pageNumber);
      this.getListOrder();
    },
  },

  async created() {
    if (!this.islogin) {
      this.$router.push("/login");
    } else {
      await this.current();
      this.email = this.user.email;
    }
  },

  computed: {
    pages() {
      let pages = [];
      for (let i = 1; i <= this.totalPage; i++) {
        if (
          i == 1 ||
          i == this.totalPage ||
          Math.abs(i - this.pageNumber) <= 1
        ) {
          pages.push(i);
        } else if (Math.abs(i - this.pageNumber) == 3) {
          pages.push("...");
        }
      }
      return pages;
    },
  },
};
</script>

<style scoped>
.user-container {
  max-width: 1440px;
  margin: 0 auto;
  margin-top: 100px;
  padding: 20px;
}

.user-heading {
  font-size: 30px;
  margin-bottom: 20px;
}

.avt-img {
  width: 120px;
  height: 120px;
  border: 3px solid #cccccc;
  border-radius: 200px;
  margin-right: 10px;
}

.user-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #ccc;
  padding-bottom: 20px;
  margin-bottom: 20px;
}

.user-details {
  flex-grow: 1;
}

.edit-button {
  padding: 8px 16px;
  border-radius: 5px;
  width: 171px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  background-color: #42b983;
  color: #fff;
  margin: 15px;
}

.edit-button:hover {
  background-color: #42b983;
}

.edit-form,
.password-form {
  background-color: #f9f9f9;
  border-radius: 10px;
  padding: 20px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  padding: 20px;
}

.form-heading {
  font-size: 30px;
}

.form {
  display: flex;
  display: flex;
  margin-top: 40px;
  flex-wrap: wrap;
}

.form-group {
  width: 50%;
  margin-bottom: 15px;
  display: flex;
  justify-content: space-around;
  position: relative;
}

.form-group span {
  bottom: 0;
  left: 1;
  position: absolute;
  color: red;
}

.form-group label {
  font-size: 20px;
  padding: 8px 16px;
  border-radius: 5px;
}

.form-input {
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  width: 500px;
}

.form-input:focus {
  outline: none;
  border-color: #42b983;
}

.display-btn {
  width: 100%;
  display: flex;
  justify-content: space-around;
}

.primary-button {
  width: 300px;
  background-color: #42b983;
  color: #fff;
  padding: 8px 16px;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 10px;
  margin-bottom: 10px;
}

.primary-button:hover {
  background-color: #42b983;
}

.secondary-button {
  width: 300px;
  background-color: #fff;
  color: #000;
  padding: 8px 16px;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 10px;
  margin-bottom: 10px;
}

.secondary-button:hover {
  background-color: #42b983;
  color: #fff;
}

@media (max-width: 600px) {
  .user-container {
    padding: 10px;
  }

  .user-info {
    flex-direction: column;
    align-items: flex-start;
  }

  .edit-button,
  .secondary-button {
    margin-top: 10px;
  }

  .form-input {
    padding: 8px;
  }
}

.user-details {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
}

.user-details th,
.user-details td {
  padding: 8px 16px;
  border: 1px solid #ccc;
}

.user-details th {
  width: 200px;
  background-color: #f2f2f2;
  text-align: left;
}

.order {
  border: 1px solid #ccc;
  border-radius: 10px;
  padding: 20px;
  background-color: #fff;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  margin-top: 20px;
}

.list-order h2 {
  text-align: left;
  margin-left: 30px;
  margin-bottom: 25px;
}

.display-item {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
}

.underline {
  border-bottom: 1px solid #ccc;
  padding-bottom: 10px;
  margin-bottom: 10px;
}

.cart-item {
  width: 100%;
  height: 150px;
  /* background: #c0392b; */
  border-radius: 20px;
  margin-top: 5px;
  margin-bottom: 5px;
  display: flex;
  justify-content: space-between;
  border: 1px solid #ccc;
}

.cart-item h2 {
  line-height: 150px;
  margin: 0px;
}

.cart-item h3 {
  line-height: 150px;
}

.item-img {
  width: 120px;
  height: 150px;
  /* object-fit: cover; */
  border-radius: 20px;
  margin-right: 10px;
}

.v-pagination__container {
  width: 100%;
  margin-top: 25px;
  margin-bottom: 25px;
  display: flex;
  justify-content: space-around;
}

.pagination {
  display: flex;
}

.pagination__prev,
.pagination__after,
.pagination__item {
  width: 40px;
  height: 40px;
  padding-left: 10px;
  padding-right: 10px;
  line-height: 40px;
  border: 1px solid #c0c0c0;
  cursor: pointer;
}

.pagination__prev,
.pagination__after,
.pagination__item:hover {
  background-color: #c0c0c0;
}

.pagination__item--active {
  box-sizing: border-box;
  border: 3px solid #42b983;
  line-height: 36px;
}

.logout {
  width: 171px;
  padding: 8px 16px;
  border-radius: 5px;
  cursor: pointer;
  background-color: #fff;
  color: #000;
  margin: 15px;
}

.logout:hover {
  background-color: #42b983;
  color: #fff;
}
</style>

