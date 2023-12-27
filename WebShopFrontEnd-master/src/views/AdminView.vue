<template>
  <div class="user-container">
    <div class="grid">
      <div class="dashboard">
        <div class="dashboard-avt"
            @click="goToUser">
          <img
            :src="this.urlbe + '/file/' + user.avatarUrl"
            alt=""
            class="item-img"
            v-if="user.avatarUrl != null"
            @click="goToUser"
          />
          <img
            src="../assets/images/people/143086968_2856368904622192_1959732218791162458_n.png"
            alt=""
            class="item-img"
            v-if="user.avatarUrl == null"
          />
          Hello, {{ user.username }}
        </div>
        <div
          class="dashboard-item"
          @click="dashboardItemSelect(1, this.urlbe + '/product/list?')"
          :class="{ 'dashboard-item__active': dashboardSelect == 1 }"
        >
          <font-awesome-icon :icon="['fas', 'user']" />Quản lý
        </div>
        <div
          class="dashboard-item"
          @click="dashboardItemSelect(2, this.urlbe + '/product/list?')"
          :class="{ 'dashboard-item__active': dashboardSelect == 2 }"
        >
          <font-awesome-icon :icon="['fas', 'bag-shopping']" /> Sản phẩm
        </div>
        <div
          class="dashboard-item"
          @click="dashboardItemSelect(3, this.urlbe + '/product/list?')"
          :class="{ 'dashboard-item__active': dashboardSelect == 3 }"
        >
          <font-awesome-icon :icon="['fas', 'bars']" />Danh mục
        </div>
        <div
          class="dashboard-item"
          @click="dashboardItemSelect(4, this.urlbe + '/order/list?')"
          :class="{ 'dashboard-item__active': dashboardSelect == 4 }"
        >
          <font-awesome-icon :icon="['fas', 'credit-card']" />Đơn hàng
        </div>
        <div
          class="dashboard-item"
          @click="dashboardItemSelect(5, this.urlbe + '/user/list?')"
          :class="{ 'dashboard-item__active': dashboardSelect == 5 }"
        >
          <font-awesome-icon :icon="['fas', 'users']" />Tài khoản
        </div>
        <div class="dashboard-item" @click="logout">
          <font-awesome-icon :icon="['fas', 'right-from-bracket']" />Đăng xuất
        </div>
      </div>
      <div class="dashboard-content">
        <h1>Dashboard</h1>
        <div class="dashboard-content__maneger" v-if="dashboardSelect == 1">
          <div style="font-size: 30px; font-weight: 500">Thống kê</div>
          <div class="dashboard-content__list">
            <div
              class="dashboard-content__item"
              style="border-left: 5px solid red"
              v-if="products"
            >
              Sản phẩm: {{ products.totalElements }}
            </div>
            <div
              class="dashboard-content__item"
              style="border-left: 5px solid #00b7ff"
            >
              Danh mục: {{ categories.length }}
            </div>
            <div
              class="dashboard-content__item"
              style="border-left: 5px solid yellow"
              v-if="order"
            >
              Đơn hàng: {{ order.totalElements }}
            </div>
            <div
              class="dashboard-content__item"
              style="border-left: 5px solid #00ff44"
              v-if="users"
            >
              Tài khoản: {{ users.totalElements }}
            </div>
          </div>
          <div class="dashboard-evaluate">
            <div class="chart">
              <Bar
                id="my-chart-id"
                :options="chartOptions"
                :data="chartData"
                v-if="updateChart"
              />
              <button
                @click="getChart"
                class="btn__update-chart"
                v-if="!updateChart"
              >
                Lấy dữ liệu biểu đồ doanh thu năm
              </button>
              <input type="number" v-model="currentYear" v-if="!updateChart" />
            </div>
            <div class="sales">
              <div>Tổng doanh thu:</div>
              {{ formatPrice(totalPrice) }}
            </div>
          </div>
        </div>

        <div class="dashboard-content__product" v-if="dashboardSelect == 2">
          <div
            style="display: flex; width: 90%; justify-content: space-between"
          >
            <div class="btn-search__product"></div>
            <div
              class="btn-add__product"
              @click="displayModalAddProduct = true"
            >
              + Add product
            </div>
            <div class="modal" v-if="displayModalAddProduct">
              <div class="modal__container">
                <header class="modal__header">
                  <div></div>
                  <div
                    class="modal__btn-close"
                    @click="displayModalAddProduct = false"
                  >
                    x
                  </div>
                </header>
                <div class="modal__add-product">
                  <form>
                    <h1 style="margin-top: 0px">Thêm sản phẩm</h1>
                    <div class="modal__add-item">
                      <span>Tên sản phẩm:</span>
                      <input type="text" v-model="newProduct.productName" />
                    </div>
                    <div class="modal__add-item">
                      <span>Loại sản phẩm:</span>
                      <select name="" id="" v-model="newProduct.category">
                        <option
                          :value="type"
                          v-for="type in categories"
                          :key="type.id"
                        >
                          {{ type.categoryName }}
                        </option>
                      </select>
                    </div>
                    <div class="modal__add-item">
                      <span>Giới tính:</span>
                      <input type="text" v-model="newProduct.gender" />
                    </div>
                    <div class="modal__add-item">
                      <span>Giá sản phẩm:</span>
                      <input type="number" v-model="newProduct.price" />
                    </div>
                    <div class="modal__add-item">
                      <span>Mô tả sản phẩm:</span>
                      <input type="text" v-model="newProduct.description" />
                    </div>
                    <div class="modal__add-item">
                      <span>Ảnh sản phẩm:</span>
                      <input
                        type="file"
                        @change="inputImage1"
                        accept="image/gif, image/jpeg, image/png"
                        style="width: 160px"
                      />
                      <input
                        type="file"
                        @change="inputImage2"
                        accept="image/gif, image/jpeg, image/png"
                        style="width: 160px"
                      />
                      <input
                        type="file"
                        @change="inputImage3"
                        accept="image/gif, image/jpeg, image/png"
                        style="width: 160px"
                      />
                    </div>
                  </form>
                  <button @click="createProduct" class="btn__modal-add">
                    Thêm
                  </button>
                </div>
              </div>
            </div>
          </div>
          <div class="product-table">
            <table border="1">
              <thead style="height: 40px">
                <td style="width: 40px">ID</td>
                <td>IMAGE</td>
                <td style="width: 250px">NAME</td>
                <td style="width: 200px">CATEGORY</td>
                <td style="width: 120px">PRICE</td>
                <td style="width: 400px">DESCRIPTION</td>
                <td style="width: 170px">DISCOUNT(%)</td>
                <td style="width: 150px">OPTION</td>
              </thead>
              <tr v-for="product in products.content" :key="product.id">
                <td>{{ product.id }}</td>
                <td>
                  <img
                    :src="urlbe + '/file/' + product.imageEntities[0].imgURL"
                    alt=""
                    class="product-img"
                  />
                </td>
                <td>
                  <textarea
                    cols="1"
                    rows="1"
                    class="product-name"
                    v-model="product.productName"
                  >
                  </textarea>
                </td>
                <td>
                  <!-- {{ product.category.categoryName }} -->
                  <select
                    style="width: 100%"
                    name=""
                    id=""
                    v-model="product.category"
                  >
                    <option
                      :value="type"
                      v-for="type in categories"
                      :key="type.id"
                    >
                      {{ type.categoryName }}
                    </option>
                  </select>
                </td>
                <td>
                  <input
                    type="text"
                    v-model="product.price"
                    style="text-align: center; border: none"
                  />
                </td>
                <td>
                  <textarea
                    cols="1"
                    rows="1"
                    class="product-name"
                    v-model="product.description"
                  >
                  </textarea>
                </td>
                <td>
                  <input
                    type="text"
                    v-model="product.discount"
                    style="text-align: center; border: none"
                  />
                </td>
                <td>
                  <div style="width: 100%">
                    <button class="btn-update" @click="updateProduct(product)">
                      UPDATE
                    </button>
                    <button
                      class="btn-update"
                      @click="deleteProduct(product.id)"
                    >
                      DELETE
                    </button>
                  </div>
                </td>
              </tr>
            </table>
          </div>

          <div class="v-pagination__container">
            <div class="pagination__left"></div>
            <div class="pagination__right">
              <div class="pagination">
                <div class="pagination__prev" @click="changePage('prev')">
                  &lt;
                </div>
                <div
                  v-for="(page, index) in pages"
                  :key="index"
                  class="pagination__item"
                  :class="{ 'pagination__item--active': page == pageNumber }"
                  @click="changePage(page)"
                >
                  {{ page }}
                </div>
                <div class="pagination__after" @click="changePage('after')">
                  >
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="dashboard-content__category" v-if="dashboardSelect == 3">
          <div v-for="(type, idx) in categoriesType" :key="idx">
            <div
              v-if="displayCategory == 0"
              class="category-list"
              @click="categoryShow(idx + 1)"
            >
              <div>{{ type.categoryType }}</div>
              <div>Tổng: {{ categoryListLength[idx] }} Danh mục</div>
            </div>

            <div
              v-if="displayCategory == idx + 1"
              style="position: absolute; left: 400px"
            >
              <div class="category-table">
                <table border="1">
                  <thead style="height: 40px">
                    <td style="width: 40px">ID</td>
                    <td style="width: 150px">CATEGORY TYPE</td>
                    <td style="width: 300px">CATEGORY NAME</td>
                  </thead>
                  <tr v-for="category in categoryList[idx]" :key="category.id">
                    <td>{{ category.id }}</td>
                    <td>{{ type.categoryType }}</td>
                    <td>{{ category.categoryName }}</td>
                  </tr>
                </table>
              </div>
              <div style="display: flex; justify-content: space-between">
                <button
                  class="btn-back"
                  @click="displayModalAddCategory = true"
                >
                  Add cartegory
                </button>
                <button @click="displayCategory = 0" class="btn-back">
                  Back
                </button>
              </div>
              <div class="modal" v-if="displayModalAddCategory">
                <div class="modal__container">
                  <header class="modal__header">
                    <div></div>
                    <div
                      class="modal__btn-close"
                      @click="displayModalAddCategory = false"
                    >
                      x
                    </div>
                  </header>
                  <div class="modal__add-product">
                    <form>
                      <h1 style="margin-top: 0px">Thêm danh mục</h1>
                      <div class="modal__add-item">
                        <span>Tên danh mục:</span>
                        <input type="text" v-model="newCategory" />
                      </div>
                    </form>
                    <button
                      @click="createCategory(type)"
                      class="btn__modal-add"
                    >
                      Thêm
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="dashboard-content__order" v-if="dashboardSelect == 4">
          <div class="order-table" style="">
            <table border="1">
              <thead style="height: 40px">
                <td style="width: 70px">ID</td>
                <td style="width: 200px">USER FIRSTNAME</td>
                <td style="width: 220px">USER LASTNAME</td>
                <td style="width: 180px">TOTAL PRICE</td>
                <td style="width: 180px">ORDER DATE</td>
                <td style="width: 170px">STATUS</td>
                <td style="width: 170px">OPTION</td>
              </thead>
              <tr v-for="o in order.content" :key="o.id">
                <td style="width: 70px; height: 40px">{{ o.id }}</td>
                <td style="width: 200px">{{ o.userInfoEntity.firstName }}</td>
                <td style="width: 220px">{{ o.userInfoEntity.lastName }}</td>
                <td style="width: 180px">{{ o.totalPrice }}</td>
                <td style="width: 170px">{{ o.orderDate }}</td>
                <td style="width: 180px">{{ getStatus(o.hasProcess) }}</td>
                <td style="width: 150px; padding: 5px">
                  <button
                    @click="processOrder(o)"
                    v-if="!o.hasProcess"
                    style="width: 100%"
                  >
                    Xử lý đơn hàng
                  </button>
                  <div v-if="o.hasProcess">Đơn hàng đã được xử lý</div>
                </td>
              </tr>
            </table>
          </div>

          <div class="v-pagination__container">
            <div class="pagination__left"></div>
            <div class="pagination__right">
              <div class="pagination">
                <div class="pagination__prev" @click="changePage('prev')">
                  &lt;
                </div>
                <div
                  v-for="(page, index) in pages"
                  :key="index"
                  class="pagination__item"
                  :class="{ 'pagination__item--active': page == pageNumber }"
                  @click="changePage(page)"
                >
                  {{ page }}
                </div>
                <div class="pagination__after" @click="changePage('after')">
                  >
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="dashboard-content__user" v-if="dashboardSelect == 5">
          <div class="order-table" style="">
            <table border="1">
              <thead style="height: 40px">
                <td style="width: 70px">ID</td>
                <td style="width: 250px">USERNAME</td>
                <td style="width: 400px">EMAIL</td>
                <td style="width: 200px">PASSWORD</td>
                <td style="width: 200px">FRISTNAME</td>
                <td style="width: 200px">LASTNAME</td>
                <td style="width: 170px">PHONE</td>
                <td style="width: 200px">ADDRESS</td>
                <td style="width: 200px">ROLE</td>
                <td style="width: 170px">OPTION</td>
              </thead>
              <tr v-for="user in users.content" :key="user.id">
                <td style="">{{ user.id }}</td>
                <td style="">
                  <input
                    type="text"
                    style="border: none"
                    v-model="user.username"
                  />
                </td>
                <td style="width: 400px">
                  <input
                    type="text"
                    style="border: none"
                    v-model="user.email"
                  />
                </td>
                <td style="width: 300px; height: 50px">
                  <input
                    type="text"
                    style="border: none"
                    v-model="user.password"
                  />
                </td>
                <td style="">
                  <input
                    type="text"
                    style="border: none"
                    v-model="user.firstName"
                  />
                </td>
                <td style="">
                  <input
                    type="text"
                    style="border: none"
                    v-model="user.lastName"
                  />
                </td>
                <td style="">
                  <input
                    type="text"
                    style="border: none"
                    v-model="user.phone"
                  />
                </td>
                <td style="">
                  <input
                    type="text"
                    style="border: none"
                    v-model="user.address"
                  />
                </td>
                <td style="">
                  <input
                    type="text"
                    style="border: none"
                    v-model="user.roles"
                  />
                </td>
                <td style="">
                  <button @click="updateUser(user)">Update</button>
                  <button @click="deleteUser(user.id)">Delete</button>
                </td>
              </tr>
            </table>
          </div>

          <div class="v-pagination__container">
            <div class="pagination__left"></div>
            <div class="pagination__right">
              <div class="pagination">
                <div class="pagination__prev" @click="changePage('prev')">
                  &lt;
                </div>
                <div
                  v-for="(page, index) in pages"
                  :key="index"
                  class="pagination__item"
                  :class="{ 'pagination__item--active': page == pageNumber }"
                  @click="changePage(page)"
                >
                  {{ page }}
                </div>
                <div class="pagination__after" @click="changePage('after')">
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { Bar } from "vue-chartjs";
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from "chart.js";
ChartJS.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
);

export default {
  components: { Bar },
  data() {
    return {
      chartDataa: {
        labels: [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "June",
          "July",
          "Aug",
          "Sept",
          "Oct",
          "Nov",
          "Dec",
        ],
        datasets: [
          {
            data: [],
          },
        ],
      },
      chartOptionss: {
        responsive: true,
      },

      dashboardSelect: 1,

      url: "",
      search: "",
      gender: "",
      categorytype: 0,
      category: 0,
      type: "",
      userRateFilter: 0,
      priceGT: 0,
      priceLT: 0,
      typeSort: "id",
      isSort: "asc",
      totalItem: 0,
      totalPage: 0,
      pageNumber: 1,
      limit: 12,

      products: [],
      displayModalAddProduct: false,
      newProduct: {
        productName: "",
        category: {},
        price: 0,
        description: "",
        gender: "",
      },
      imgProduct1: null,
      imgProduct2: null,
      imgProduct3x: null,

      categories: [],
      categoriesType: [
        {
          id: 1,
          categoryType: "Áo",
        },
        {
          id: 2,
          categoryType: "Quần",
        },
        {
          id: 3,
          categoryType: "Váy",
        },
        {
          id: 4,
          categoryType: "Phụ kiện",
        },
      ],
      displayCategory: 0,
      categoryList: [],
      categoryListLength: [],
      displayModalAddCategory: false,
      newCategory: "",

      order: [],
      totalPrice: 0,
      totalByMonth: [],
      updateChart: false,
      currentYear: new Date().getFullYear(),

      users: [],
    };
  },

  props: ["islogin", "isAdmin", "user", "urlbe"],

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

    inputImage1(event) {
      this.imgProduct1 = event.target.files[0];
    },

    inputImage2(event) {
      this.imgProduct2 = event.target.files[0];
    },

    inputImage3(event) {
      this.imgProduct3 = event.target.files[0];
    },

    async upLoadFile(imgProduct, pid) {
      let formdata = new FormData();
      formdata.append("file", imgProduct);
      formdata.append("pid", pid);
      try {
        const response = await axios.post(
          this.urlbe + "/file/upload",
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

    async createProduct() {
      if (
        this.newProduct.productName != null &&
        this.newProduct.category != null &&
        this.newProduct.price != null &&
        this.newProduct.description != null &&
        this.newProduct.gender != null &&
        this.imgProduct1 != null &&
        this.imgProduct2 != null &&
        this.imgProduct3 != null
      ) {
        try {
          const response = await axios.post(
            this.urlbe + "/product/create",
            {
              productName: this.newProduct.productName,
              category: this.newProduct.category,
              price: this.newProduct.price,
              description: this.newProduct.description,
              gender: this.newProduct.gender,
            },
            {
              headers: {
                "Access-Control-Allow-Origin": "*",
                Authorization: "Bearer " + localStorage.getItem("token"),
              },
            }
          );

          this.upLoadFile(this.imgProduct1, response.data.id);
          this.upLoadFile(this.imgProduct2, response.data.id);
          this.upLoadFile(this.imgProduct3, response.data.id);

          alert("Thêm sản phẩm thành công");
          this.getListProduct();
          this.displayModalAddProduct = false;
          return response;
        } catch (error) {
          console.error(error);
        }
      } else {
        alert("Vui lòng nhập đầy đủ thông tin");
      }
    },

    async getListProduct() {
      try {
        const response = await axios.get(
          this.url +
            "search=" +
            this.search +
            "&gender=" +
            this.gender +
            "&categorytype=" +
            this.categorytype +
            "&category=" +
            this.category +
            "&type=" +
            this.type +
            "&rate=" +
            this.userRateFilter +
            "&pricegt=" +
            this.priceGT +
            "&pricelt=" +
            this.priceLT +
            "&limit=" +
            this.limit +
            "&page=" +
            this.pageNumber +
            "&sortby=" +
            this.typeSort +
            "&sort=" +
            this.isSort
        );
        this.products = response.data;
        this.totalPage = response.data.totalPages;
        this.totalItem = response.data.totalElements;
        return response.data;
      } catch (error) {
        console.error(error);
      }
    },

    async updateProduct(product) {
      try {
        const response = await axios.put(
          this.urlbe + "/product/update/" + product.id,
          {
            productName: product.productName,
            category: product.category,
            price: product.price,
            description: product.description,
            discount: product.discount,
            gender: product.gender,
            typeProductEntities: product.typeProductEntities,
            imageEntities: product.imageEntities,
            rate: product.rate,
            numEvaluate: product.numEvaluate,
            numOrder: product.numOrder
          },
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        alert("Cập nhật sản phẩm thành công");
        this.getListProduct();
        return response;
      } catch (error) {
        console.error(error);
      }
    },

    async deleteProduct(id) {
      try {
        const response = await axios.delete(
          this.urlbe + "/product/delete/" + id,
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        alert("Xóa sản phẩm thành công");
        this.getListProduct();
        return response;
      } catch (error) {
        console.error(error);
      }
    },

    async getListCategory(type) {
      try {
        const response = await axios.get(
          this.urlbe + "/category/list?type=" + type + "&limit=100&page=1"
        );
        return response.data.content;
      } catch (error) {
        console.error(error);
      }
    },

    async createCategory(type) {
      if (this.newCategory != "") {
        try {
          const response = await axios.post(
            this.urlbe + "/category/create",
            {
              categoryName: this.newCategory,
              categoryType: type,
            },
            {
              headers: {
                "Access-Control-Allow-Origin": "*",
                Authorization: "Bearer " + localStorage.getItem("token"),
              },
            }
          );

          alert("Thêm danh mục thành công");
          this.categoryList[type.id - 1] = await this.getListCategory(type.id);
          this.displayModalAddCategory = false;
          return response;
        } catch (error) {
          console.error(error);
        }
      } else {
        alert("Vui lòng nhập đầy đủ thông tin");
      }
    },

    categoryShow(idx) {
      this.displayCategory = idx;
      console.log(this.displayCategory);
    },

    async getListOrder() {
      // try {
      //   const response = await axios.get(
      //     this.urlbe + "/order/list/" +
      //       this.user.id +
      //       "?limit=1&page=" +
      //       this.pageNumber +
      //       "&sortby=id&sort=desc",
      //     {
      //       headers: {
      //         "Access-Control-Allow-Origin": "*",
      //         Authorization: "Bearer " + localStorage.getItem("token"),
      //       },
      //     }
      //   );
      //   // this.order = response.data;
      //   this.totalPage = this.order.totalPages;
      //   return this.user;
      // } catch (error) {
      //   console.error(error);
      //   alert("Lỗi lấy danh sách đơn hàng");
      // }
    },

    async getListAllOrder() {
      try {
        const response = await axios.get(
          this.url +
            "limit=" +
            this.limit +
            "&page=" +
            this.pageNumber +
            "&sortby=" +
            this.typeSort +
            "&sort=" +
            this.isSort,
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        this.order = response.data;
        this.totalPage = response.data.totalPages;
        this.totalItem = response.data.totalElements;
        return response.data;
      } catch (error) {
        console.error(error);
      }
    },

    getStatus(status) {
      if (status == true) {
        return "Đã được xử lý";
      }
      return "Chưa được xử lý";
    },

    async processOrder(order) {
      order.hasProcess = true;
      console.log(order);
      try {
        const response = await axios.put(
          this.urlbe + "/order/update/" + order.id,
          {
            userInfoEntity: order.userInfoEntity,
            orderDate: order.orderDate,
            totalPrice: order.totalPrice,
            hasProcess: order.hasProcess,
          },
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        const response2 = await axios.post(
          this.urlbe + "/mail/success/" + order.id,
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        alert("xử lý đơn hàng thành công");
        this.getListAllOrder();
        console.log(response2);
        return response;
      } catch (error) {
        console.error(error);
      }
    },

    async getToTalPrice() {
      try {
        const response = await axios.get(this.urlbe + "/order/total", {
          headers: {
            "Access-Control-Allow-Origin": "*",
            Authorization: "Bearer " + localStorage.getItem("token"),
          },
        });
        return response.data;
      } catch (error) {
        console.error(error);
      }
    },

    async getToTalByMonth(fromDate, toDate) {
      try {
        const response = await axios.get(
          this.urlbe + "/order/listdate?from=" + fromDate + "&to=" + toDate,
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        let totalprice = 0;
        for (let i = 0; i < response.data.length; i++) {
          totalprice += response.data[i].totalPrice;
        }
        return totalprice;
      } catch (error) {
        console.error(error);
      }
    },

    async getListUser() {
      try {
        const response = await axios.get(
          this.url +
            "limit=" +
            this.limit +
            "&page=" +
            this.pageNumber +
            "&sortby=" +
            this.typeSort +
            "&sort=" +
            this.isSort,
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        this.users = response.data;
        this.totalPage = response.data.totalPages;
        this.totalItem = response.data.totalElements;
        return response.data;
      } catch (error) {
        console.error(error);
      }
    },

    async updateUser(user) {
      if (
        user.firstName != "" &&
        user.lastName != "" &&
        user.email != "" &&
        user.phone != "" &&
        user.address != "" &&
        user.password != ""
      ) {
        try {
          const response = await axios.put(
            this.urlbe + "/user/update/" + user.id,
            {
              username: user.username,
              password: user.password,
              roles: user.roles,
              firstName: user.firstName,
              lastName: user.lastName,
              phone: user.phone,
              email: user.email,
              address: user.address,
              avatarUrl: user.avatarUrl,
              userInfoEntity: {
                id: user.userInfoEntity.id,
                firstName: user.firstName,
                lastName: user.lastName,
                avatarUrl: user.avatarUrl,
              },
            },
            {
              headers: {
                "Access-Control-Allow-Origin": "*",
                Authorization: "Bearer " + localStorage.getItem("token"),
              },
            }
          );
          alert("Cập nhật thông tin thành công");
          return response;
        } catch (error) {
          console.error(error);
        }
      }
    },

    async deleteUser(id) {
      try {
        const response = await axios.delete(this.urlbe + "/user/delete/" + id, {
          headers: {
            "Access-Control-Allow-Origin": "*",
            Authorization: "Bearer " + localStorage.getItem("token"),
          },
        });
        alert("Xóa user thành công");
        this.getListUser();
        return response;
      } catch (error) {
        console.error(error);
      }
    },

    async getChart() {
      this.totalByMonth[0] = await this.getToTalByMonth(
        this.currentYear + "-01-01",
        this.currentYear + "-01-31"
      );
      this.totalByMonth[1] = await this.getToTalByMonth(
        this.currentYear + "-02-01",
        this.currentYear + "-02-29"
      );
      this.totalByMonth[2] = await this.getToTalByMonth(
        this.currentYear + "-03-01",
        this.currentYear + "-03-31"
      );
      this.totalByMonth[3] = await this.getToTalByMonth(
        this.currentYear + "-04-01",
        this.currentYear + "-04-30"
      );
      this.totalByMonth[4] = await this.getToTalByMonth(
        this.currentYear + "-05-01",
        this.currentYear + "-05-31"
      );
      this.totalByMonth[5] = await this.getToTalByMonth(
        this.currentYear + "-06-01",
        this.currentYear + "-06-30"
      );
      this.totalByMonth[6] = await this.getToTalByMonth(
        this.currentYear + "-07-01",
        this.currentYear + "-07-31"
      );
      this.totalByMonth[7] = await this.getToTalByMonth(
        this.currentYear + "-08-01",
        this.currentYear + "-08-31"
      );
      this.totalByMonth[8] = await this.getToTalByMonth(
        this.currentYear + "-09-01",
        this.currentYear + "-09-30"
      );
      this.totalByMonth[9] = await this.getToTalByMonth(
        this.currentYear + "-10-01",
        this.currentYear + "-10-31"
      );
      this.totalByMonth[10] = await this.getToTalByMonth(
        this.currentYear + "-11-01",
        this.currentYear + "-11-30"
      );
      this.totalByMonth[11] = await this.getToTalByMonth(
        this.currentYear + "-12-01",
        this.currentYear + "-12-31"
      );
      console.log(this.totalByMonth);
      this.chartDataa.datasets[0].data = this.totalByMonth;
      this.updateChart = true;
      console.log(this.updateChart);
    },

    goToUser() {
      this.$router.push('/user')
    },

    changePage(page) {
      if (page == "prev" && this.pageNumber > 1) {
        this.pageNumber--;
      } else if (page == "after" && this.pageNumber < this.totalPage) {
        this.pageNumber++;
      } else if (typeof page == "number") {
        this.pageNumber = page;
      }
      if (this.dashboardSelect == 2) {
        this.getListProduct();
      } else if (this.dashboardSelect == 4) {
        this.getListAllOrder();
      } else if (this.dashboardSelect == 5) {
        this.getListUser();
      }
    },

    dashboardItemSelect(num, url) {
      this.dashboardSelect = num;
      this.url = url;
      this.pageNumber = 1;
      console.log(this.url);
      if (num == 2) {
        this.getListProduct();
      } else if (num == 4) {
        this.getListAllOrder();
      } else if (num == 5) {
        this.getListUser();
      }
    },
  },

  async created() {
    if (!this.isAdmin || !this.islogin) {
      this.$router.push("/404");
    } else {
      this.url = this.urlbe + "/user/list?";
      this.users = await this.getListUser();
      this.categories = await this.getListCategory(0);
      this.url = this.urlbe + "/product/list?";
      this.products = this.getListProduct();
      this.url = this.urlbe + "/order/list?";
      this.order = await this.getListAllOrder();
      this.url = "";

      this.categoryList[0] = await this.getListCategory(1);
      this.categoryList[1] = await this.getListCategory(2);
      this.categoryList[2] = await this.getListCategory(3);
      this.categoryList[3] = await this.getListCategory(4);
      for (let i = 0; i < this.categoryList.length; i++) {
        this.categoryListLength[i] = this.categoryList[i].length;
      }

      this.totalPrice = await this.getToTalPrice();

      
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

    chartData() {
      return this.chartDataa; /* mutable chart data */
    },
    chartOptions() {
      return this.chartOptionss; /* mutable chart options */
    },
  },
};
</script>

<style scoped>
.user-container {
  /* max-width: 1440px; */
  margin: 0 auto;
  margin-top: 70px;
  padding: 20px;
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
  border-bottom: 1px solid #cccccc;
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
  height: 120px;
  border: 3px solid #cccccc;
  border-radius: 100px;
  margin-right: 10px;
}

.v-pagination__container {
  width: 90%;
  margin-top: 25px;
  margin-bottom: 25px;
  display: flex;
  justify-content: space-between;
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
  padding: 8px 16px;
  border-radius: 5px;
  cursor: pointer;
  background-color: #fff;
  color: #000;
  margin: 15px;
}

.logout:hover {
  background-color: #42b9ad;
  color: #fff;
}

.grid {
  width: 100%;
  /* max-width: 1440px; */
  max-height: 100%;
  margin: 0 auto;
  flex-shrink: 0;
  display: flex;
  justify-content: space-between;
}

.dashboard {
  width: 25%;
  height: 700px;
  background-color: #42b983;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
}

.dashboard-avt {
  font-size: 30px;
  height: 150px;
  line-height: 150px;
  font-weight: 500;
  color: #fff;
  cursor: pointer;
}

.dashboard-item {
  width: 100%;
  height: 70px;
  background-color: #42b983;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0);
  display: flex;
  justify-content: center;
  align-items: center;
  border-top: 1px solid #c0c0c0;
  font-size: 20px;
  color: #fff;
}

.dashboard-item:hover {
  cursor: pointer;
  background-color: #fff;
  color: #000;
}

.dashboard-item__active {
  background-color: #fff;
  color: #000;
}

.dashboard-content {
  width: 75%;
  height: 700px;
  background-color: #fff;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
}

.dashboard-content h1 {
  margin: 20px;
  text-align: left;
}

.dashboard-content__maneger {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  flex-direction: column;
}

.dashboard-content__list {
  width: 90%;
  display: flex;
  justify-content: space-around;
  border: 1px solid #c0c0c0;
}

.dashboard-content__item {
  width: 250px;
  height: 100px;
  background-color: #fff;
  border: 1px solid #c0c0c0;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
  cursor: pointer;
  padding: 10px;
  margin: 20px;
  font-size: 25px;
  font-weight: 500;
}

.dashboard-evaluate {
  display: flex;
  width: 90%;
  height: 400px;
  justify-content: space-between;
}

.sales {
  margin-top: 20px;
  margin-left: 20px;
  padding: 10px;
  width: 300px;
  height: 150px;
  font-size: 30px;
  text-align: center;
  border: 1px solid #c0c0c0;
  border-top: 10px solid #ee00ff;
}

.chart {
  width: 80%;
  margin-top: 20px;
  padding-top: 20px;
  padding-bottom: 20px;
  border: 1px solid #c0c0c0;
  display: flex;
  justify-content: center;
  align-items: center;
}

.dashboard-content__user,
.dashboard-content__order,
.dashboard-content__product {
  display: flex;
  align-content: center;
  flex-wrap: wrap;
  flex-direction: column;
}

.btn-add__product {
  width: 250px;
  height: 50px;
  background-color: #42b983;
  margin-bottom: 20px;
  color: #fff;
  font-size: 20px;
  line-height: 50px;
  border-radius: 20px;
  border: 1px solid #000;
}

.modal__add-product {
  width: 100%;
  height: 600px;
  padding: 50px;
  background-color: #fff;
}

.modal__add-item {
  display: flex;
  margin-bottom: 20px;
}

.modal__add-item span {
  width: 200px;
  height: 40px;
  font-size: 20px;
  font-weight: 500;
  line-height: 40px;
  text-align: start;
}
.modal__add-item select,
.modal__add-item input {
  width: 500px;
  height: 40px;
  font-size: 20px;
  font-weight: 500;
  line-height: 30px;
  border: 1px solid #000;
  border-radius: 5px;
}

.modal {
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background: rgba(0, 0, 0, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal__container {
  width: 800px;
  background-color: #fff;
}

.modal__header {
  width: 100%;
  height: 50px;
  background-color: #42b983;
  display: flex;
  justify-content: space-between;
}

.modal__btn-close {
  width: 50px;
  height: 50px;
  line-height: 50px;
  font-size: 25px;
  font-weight: 500;
  border-left: 1px solid #c0c0c0;
  color: #fff;
}

.modal__btn-close:hover {
  cursor: pointer;
  opacity: 0.5;
}

.btn-add__product:hover {
  cursor: pointer;
  background-color: #fff;
  color: #000;
}

.order-table {
  width: 90%;
  height: 450px;
  border: 1px solid #000;
  margin-bottom: 10px;
  color: #000;
  margin-top: 50px;
  font-size: 17px;
  font-weight: 300px;
  overflow: auto;
  overflow-y: scroll;
}

.product-table {
  width: 90%;
  height: 450px;
  border: 1px solid #000;
  margin-bottom: 10px;
  color: #000;
  font-size: 17px;
  font-weight: 300px;
  overflow: auto;
  overflow-y: scroll;
}

.product-img {
  width: 120px;
  height: 150px;
  background-color: #c0c0c0;
}

.product-name {
  width: 100%;
  height: 150px;
  border: none;
  padding: 5px;
}

.btn-update {
  width: 80%;
  height: 30px;
  margin: 10px;
  background-color: #fff;
}

.btn-update:hover {
  cursor: pointer;
  background-color: #42b983;
  color: #fff;
}

.btn__modal-add {
  width: 300px;
  height: 50px;
  margin: 10px;
  background-color: #42b983;
  border-radius: 20px;
  color: #fff;
  font-size: 20px;
}

.btn__modal-add:hover {
  cursor: pointer;
  opacity: 0.5;
}

.dashboard-content__category {
  position: relative;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  padding: 50px;
}

.category-list {
  width: 500px;
  height: 200px;
  background-color: #fff;
  border: 2px solid #c0c0c0;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.4);
  border-left: 10px solid #01ffe6;
  cursor: pointer;
  margin: 20px;
  font-size: 40px;
  padding: 20px;
}

.category-list:hover {
  opacity: 0.8;
}

.category-table {
  width: 100%;
  height: 450px;
  border: 1px solid #000;
  margin-bottom: 10px;
  color: #000;
  font-size: 17px;
  font-weight: 300px;
  overflow: auto;
  overflow-y: scroll;
}

.btn-back {
  width: 100px;
  height: 50px;
  background-color: #fff;
  border: 1px solid #c0c0c0;
  border-radius: 10px;
  margin-bottom: 20px;
  font-size: 20px;
  cursor: pointer;
  font-weight: 500;
}

.btn__update-chart {
  width: 200px;
  /* height: 50px; */
  font-size: 20px;
  margin: 20px;
  background-color: #fff;
  /* border: 1px solid #000; */
  border-radius: 10px;
}

.btn__update-chart:hover {
  cursor: pointer;
  /* background-color: #42b983; */
  /* color: #fff; */
}
</style>

