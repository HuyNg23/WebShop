<template>
  <div class="products">
    <div class="banner"></div>
    <div class="grid">
      <div class="select-type">
        <div
          class="sort__by-name"  v-for="type in listType" :key="type.id"
          @click="changeType(type.id)"
          :class="{ typesort__active: category == type.id }"
        >
          {{ type.categoryName }}
        </div>
        
        <div class="btn_untype" @click="unType" v-if="displayTypeFilter">x</div>
      </div>

      <div class="show">
        <select
          class="combo-box__size"
          v-model="limit"
          @change="changePageLimit(limit)"
        >
          <option v-for="k in records" :key="k.key" :value="k.key">
            {{ k.value }}
          </option>
        </select>
        <div
          class="sort__by-name"
          @click="changeTypeSort(`id`)"
          :class="{ typesort__active: typeSort == 'id' }"
        >
          Mới
        </div>
        <div
          class="sort__by-name"
          @click="changeTypeSort(`productName`)"
          :class="{ typesort__active: typeSort == 'productName' }"
        >
          Tên
        </div>
        <div
          class="sort__by-name"
          @click="changeTypeSort(`price`)"
          :class="{ typesort__active: typeSort == 'price' }"
        >
          Giá
        </div>
        <div
          class="sort__by-name"
          @click="changeTypeSort(`rate`)"
          :class="{ typesort__active: typeSort == 'rate' }"
        >
          Sao
        </div>
        <div
          class="sort__by-name"
          @click="changeTypeSort(`numEvaluate`)"
          :class="{ typesort__active: typeSort == 'numEvaluate' }"
        >
          Lượt đánh giá
        </div>
        <div
          class="sort__by-name"
          @click="changeTypeSort(`numOrder`)"
          :class="{ typesort__active: typeSort == 'numOrder' }"
        >
          Lượt mua
        </div>

        <div class="change__sort-arr" @click="sortChange">
          <font-awesome-icon
            :icon="['fas', 'sort-up']"
            class="sort-arr"
            :class="{ sort__active: isSort == 'asc' }"
          />
          <font-awesome-icon
            :icon="['fas', 'sort-down']"
            class="sort-arr"
            :class="{ sort__active: isSort == 'desc' }"
          />
        </div>

        <font-awesome-icon
          :icon="['fas', 'filter']"
          class="filter"
          @click="openFilter"
        />
        <div class="filter-list" v-if="displayFilter">
          <form>
            <div>Lọc giá trong khoảng</div>
            Từ&nbsp;&nbsp;&nbsp;<input
              type="text"
              class="input-filter"
              v-model="priceGT"
            />
            Đến
            <input type="text" class="input-filter" v-model="priceLT" />
            <br />
            <br />
            <div>Đánh giá từ</div>
            <div class="rate-star">
              <font-awesome-icon
                :icon="['fas', 'star']"
                class="star"
                :class="{ 'star-active': userRateFilter == 1 }"
                @click="userRateStar(1)"
              />
              <font-awesome-icon
                :icon="['fas', 'star']"
                class="star"
                :class="{ 'star-active': userRateFilter == 2 }"
                @click="userRateStar(2)"
              />
              <font-awesome-icon
                :icon="['fas', 'star']"
                class="star"
                :class="{ 'star-active': userRateFilter == 3 }"
                @click="userRateStar(3)"
              />
              <font-awesome-icon
                :icon="['fas', 'star']"
                class="star"
                :class="{ 'star-active': userRateFilter == 4 }"
                @click="userRateStar(4)"
              />
              <font-awesome-icon
                :icon="['fas', 'star']"
                class="star"
                :class="{ 'star-active': userRateFilter == 5 }"
                @click="userRateStar(5)"
              />
            </div>
            <div>trở lên</div>
          </form>
          <button class="filter-btn" @click="filter">Lọc</button>
          <button class="unfilter-btn" @click="unfilter">Hủy Lọc</button>
        </div>
      </div>

      <div class="pagination__left">
        <span>Tìm thấy {{ totalItem }} kết quả : </span>
      </div>

      <div class="list-item">
        <div class="item" v-for="product in products" :key="product.id">
          <router-link
            class="item-link"
            :to="{ name: 'product', params: { id: product.id } }"
          >
            <img
              :src="
                this.urlbe + '/file/' + product.imageEntities[0].imgURL
              "
              alt=""
              class="item-img"
            />
            <div class="sale" v-if="product.discount > 0">
            <img
              src="../assets/images/features/—Pngtree—sale_146155.png"
              alt=""
              class=""
              style="width: 100px; height: 100px;"
            />
            {{product.discount}}%
            </div>
            <div class="product-name">{{ product.productName }}</div>
            <div class="price-sold">
              <h2 v-if="product.discount == 0">{{ formatPrice(product.price) }}</h2>
              <h2 v-if="product.discount > 0" style="color: red; font-weight: 700">{{ formatPrice(product.price * (100 - product.discount)/100) }}</h2>
              <h4>Đã bán {{ product.numOrder }}</h4>
            </div>
          </router-link>
        </div>
      </div>

      <div class="v-pagination__container">
        <div class="pagination__left"></div>

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
      listType: [],
      products: [],
      url: this.urlbe + "/product/list?",
      search: "",
      gender: "Nữ",
      categorytype: 3,
      category: 0,
      type: "",
      userRateFilter: 0,
      priceGT: 0,
      priceLT: 0,
      typeSort: "id",
      isSort: "desc",
      totalItem: 0,
      totalPage: 0,
      pageNumber: 1,
      limit: 12,
      shoppingCart: [],
      displayFilter: false,
      displayTypeFilter: false,
    };
  },
  
    props: ["islogin", "isAdmin", "urlbe"],

  created() {
    this.getList();
    this.getTypeList();
  },

  methods: {
    formatPrice(number) {
      return new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
      }).format(number);
    },

    changePageLimit(k) {
      this.limit = k;
      this.getList();
    },

    openFilter() {
      this.displayFilter = !this.displayFilter;
    },

    sortChange() {
      if (this.isSort == "asc") {
        this.isSort = "desc";
      } else {
        this.isSort = "asc";
      }
      this.getList();
    },

    userRateStar(star) {
      this.userRateFilter = star;
    },

    onSearch() {
      this.pageNumber = 1;
      this.getList();
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
      this.getList();
    },

    changeType(typeId) {
      this.category = typeId;
      this.pageNumber = 1;
      this.getList();
      this.displayTypeFilter = true;
    },

    changeTypeSort(nameType) {
      this.typeSort = nameType;
      this.pageNumber = 1;
      this.getList();
    },

    filter() {
      this.pageNumber = 1;
      this.getList();
      this.displayFilter = false;
    },

    unType() {
      this.category = 0;
      this.pageNumber = 1;
      this.getList();
      this.displayTypeFilter = false;
    },

    unfilter() {
      this.pageNumber = 1;
      (this.userRateFilter = 0),
        (this.priceGT = 0),
        (this.priceLT = 0),
        this.getList();
      this.displayFilter = false;
    },

    async getTypeList() {
      try {
        const response = await axios.get(
          this.urlbe + "/category/list?type=3&limit=100&page=1"
        );
        this.listType = response.data.content;
      } catch (error) {
        console.error(error);
      }
    },

    async getList() {
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
        this.products = response.data.content;
        this.totalPage = response.data.totalPages;
        this.totalItem = response.data.totalElements;
      } catch (error) {
        console.error(error);
      }
    },

    // addCart(product) {
    //   this.shoppingCart = JSON.parse(localStorage.getItem("shoppingCart"));
    //   if (this.shoppingCart == null) {
    //     this.shoppingCart = [];
    //     this.shoppingCart.push({
    //       product: product,
    //       quantity: 1,
    //     });
    //   } else {
    //     for (let i = 0; i < this.shoppingCart.length; i++) {
    //       if (this.shoppingCart[i].product.id == product.id) {
    //         this.shoppingCart[i].quantity++;
    //         localStorage.setItem(
    //           "shoppingCart",
    //           JSON.stringify(this.shoppingCart)
    //         );
    //         console.log(localStorage.getItem("shoppingCart"));
    //         return;
    //       }
    //     }
    //     this.shoppingCart.push({
    //       product: product,
    //       quantity: 1,
    //     });
    //     localStorage.setItem("shoppingCart", JSON.stringify(this.shoppingCart));
    //     console.log(localStorage.getItem("shoppingCart"));
    //     return;
    //   }
    //   localStorage.setItem("shoppingCart", JSON.stringify(this.shoppingCart));
    //   console.log(localStorage.getItem("shoppingCart"));
    // },
  },

  computed: {
    records() {
      return [
        { key: 12, value: "12 sản phẩm trên 1 trang" },
        { key: 24, value: "24 sản phẩm trên 1 trang" },
        { key: 36, value: "36 sản phẩm trên 1 trang" },
      ];
    },
    pages() {
      let pages = [];
      for (let i = 1; i <= this.totalPage; i++) {
        if (
          i == 1 ||
          i == this.totalPage ||
          Math.abs(i - this.pageNumber) <= 2
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
.select-type {
  width: 100%;
  display: flex;
  flex-wrap: wrap;
  border: 1px solid #c0c0c0;
  border-radius: 10px;
  padding: 20px;
  box-sizing: border-box;
}

.show {
  width: 100%;
  height: 100px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  /* border: 1px solid #c0c0c0; */
  border-radius: 10px;
}

.banner {
  background-image: url("../assets/images/banner/chan-vay-va-dam-nu-routine-min.jpg");
  width: 100%;
  height: 400px;
  /* background-repeat: no-repeat; */
  background-size: cover;
  background-position: center;
  margin-bottom: 20px;
}

.combo-box__size {
  width: 230px;
  height: 30px;
  /* border-radius: 20px; */
  border: 1px solid #c0c0c0;
  background-color: #fff;
  color: black;
  font-size: 16px;
  margin-left: 10px;
  font-weight: 500;
}

.search {
  margin-bottom: 20px;
}

.search-input {
  width: 40%;
  height: 40px;
  border-radius: 20px;
  border: 1px solid #c0c0c0;
  padding: 0 20px;
  font-size: 16px;
}

.search-btn {
  width: 100px;
  height: 40px;
  border-radius: 20px;
  border: 1px solid #c0c0c0;
  background-color: #fff;
  color: black;
  font-size: 16px;
  margin-left: 10px;
  font-weight: 500;
}

.search-btn:hover {
  background-color: #c0c0c0;
}

.sort_fil {
  display: flex;
  align-items: center;
}

.filter {
  font-size: 25px;
  margin-right: 25px;
  position: relative;
}

.filter:hover {
  cursor: pointer;
}

.filter-list {
  position: absolute;
  width: 400px;
  height: 400px;
  background-color: #fff;
  border: 3px solid #42b983;
  box-shadow: 0px 0px 10px 0px #c0c0c0;
  top: 500px;
  right: 250px;
  font-size: 20px;
  box-sizing: border-box;
  padding: 20px;
  z-index: 1;
}

.input-filter {
  width: 80%;
  padding: 5px;
  margin: 15px;
}

.filter-btn {
  width: 100px;
  height: 40px;
  border-radius: 10px;
  border: 1px solid #000;
  background-color: #42b983;
  color: #fff;
  font-size: 16px;
  margin-left: 10px;
  font-weight: 500;
  margin-top: 20px;
}

.btn_untype {
  width: 20px;
  height: 20px;
  border: 1px solid #c0c0c0;
  border-radius: 30px;
  line-height: 15px;
  margin: 10px;
  transform: translateY(10px);
}

.btn_untype:hover {
  background-color: #42b983;
  cursor: pointer;
  color: #fff;
  border: 1px solid #000;
}

.unfilter-btn {
  width: 100px;
  height: 40px;
  border-radius: 10px;
  border: 1px solid #000;
  background-color: #fff;
  color: #000;
  font-size: 16px;
  margin-left: 10px;
  font-weight: 500;
  margin-top: 20px;
}

.unfilter-btn:hover {
  background-color: #c0c0c0;
  cursor: pointer;
}

.rate-star {
  font-size: 20px;
  margin: 20px;
}

.star {
  font-size: 20px;
  line-height: 50px;
  margin-left: 20px;
}

.star:hover {
  color: rgb(255, 251, 8);
}

.star-active {
  color: rgb(255, 251, 8);
}

.change__sort-arr {
  position: relative;
  width: 30px;
  height: 30px;
}

.sort-arr {
  position: absolute;
  width: 30px;
  height: 30px;
  top: 0;
  left: 0;
  padding: 0px;
}

.sort__active {
  color: #42b983;
}

.pagination__left {
  margin: 30px;
  font-size: 20px;
  font-weight: 500;
}

.list-item {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}

.item {
  width: 330px;
  height: 540px;
  border-radius: 30px;
  margin: 15px;
  border: 2px solid #c0c0c0;
position: relative;
}

.sale {
  position: absolute;
  top: 0;
  right: 10px;
  font-size: 20px;
  color: red;
  font-weight: 700;
}

.item:hover {
  /* transform: scale(1.05); */
  box-shadow: 0 0 10px #c0c0c0;
  border: 2px solid #c0c0c0;
}

.item-link {
  text-decoration: none;
  color: black;
  width: 100%;
}

.item-link h3 {
  margin: 5px;
}

.item-img {
  width: 100%;
  height: 400px;
  border-radius: 35px;
  padding: 30px;
  padding-bottom: 0;
}

.product-name {
  width: 100%;
  padding: 0 30px;
  height: 60px;
  margin-top: 10px;
  font-size: 25px;
  font-weight: 700;
}

.price-sold {
  display: flex;
  justify-content: space-between;
  padding: 0 30px;
  width: 100%;
  margin-top: 10px;
}

/* .btn-addcart {
  width: 80%;
  height: 40px;
  border-radius: 20px;
  border: 1px solid #c0c0c0;
  background-color: #fff;
  color: black;
  font-size: 16px;
  font-weight: 500; */
/* margin-bottom: 10px; */
/* margin-top: 5px;
} */

/* .btn-addcart:hover {
  background-color: #c0c0c0;
} */

.sort__by-name {
  width: 120px;
  height: 40px;
  line-height: 40px;
  border: 1px solid #c0c0c0;
  border-radius: 10px;
  margin: 10px;
}

.sort__by-name:hover {
  cursor: pointer;
  border: 1px solid #000;
  background-color: #42b983;
  color: #fff;
}

.typesort__active {
  color: #42b983;
  border: 1px solid #000;
  background-color: #42b983;
  color: #fff;
}

.v-pagination__container {
  width: 100%;
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

.grid {
  width: 100%;
  max-width: 1440px;
  max-height: 100%;
  margin: 0 auto;
  flex-shrink: 0;
  display: flex;
  flex-wrap: wrap;
}
</style>
