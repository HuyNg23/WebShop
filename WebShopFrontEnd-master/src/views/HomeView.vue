<template>
  <div>
    <swiper
      :modules="modules"
      :loop="true"
      :pagination="true"
      :autoplay="{
        delay: 5000,
        disableOnInteraction: false,
      }"
    >
      <swiper-slide v-for="item in banner" :key="item">
        <div class="slider slider1" v-if="item.url == 1"></div>
        <div class="slider slider2" v-if="item.url == 2"></div>
        <div class="slider slider3" v-if="item.url == 3"></div>
        <div class="slider slider4" v-if="item.url == 4"></div>
      </swiper-slide>
    </swiper>

    <div class="grid">
      <div class="new-product">
        <h1>New arrivals</h1>
        <swiper
          :modules="modules"
          :loop="true"
          :pagination="true"
          :autoplay="{
            delay: 5000,
            disableOnInteraction: false,
          }"
          class="list-new"
        >
          <swiper-slide class="" v-for="idx in 4" :key="idx">
            <div class="list-item">
              <div
                class="item"
                v-for="product in products[idx]"
                :key="product.id"
              >
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
                      style="width: 100px; height: 100px"
                    />
                    {{ product.discount }}%
                  </div>
                  <div class="product-name">{{ product.productName }}</div>
                  <div class="price-sold">
                    <h2>{{ formatPrice(product.price) }}</h2>
                    <h4>Đã bán {{ product.numOrder }}</h4>
                  </div>
                </router-link>
              </div>
            </div>
          </swiper-slide>
        </swiper>
        <div class="viewmore">
          <div></div>
          <router-link to="/shop" class="viewmore-btn">Xem thêm</router-link>
        </div>
      </div>

        <img
          src="../assets/images/banner/bi-quyet-cho-sale-bach-phat-bach-trung.jpg"
          alt=""
          class=""
          style="width: 500px; height: 200px"
        />
      <div class="new-product" style="">
        <swiper
          :modules="modules"
          :loop="true"
          :pagination="true"
          :autoplay="{
            delay: 5000,
            disableOnInteraction: false,
          }"
          class="list-new"
        >
          <swiper-slide class="" v-for="idx in totalPage" :key="idx">
            <div class="list-item">
              <div
                class="item"
                v-for="product in saleproducts[idx]"
                :key="product.id"
              >
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
                      style="width: 100px; height: 100px"
                    />
                    {{ product.discount }}%
                  </div>
                  <div class="product-name">{{ product.productName }}</div>
                  <div class="price-sold">
                    <h2>{{ formatPrice(product.price) }}</h2>
                    <h4>Đã bán {{ product.numOrder }}</h4>
                  </div>
                </router-link>
              </div>
            </div>
          </swiper-slide>
        </swiper>
        <div class="viewmore">
          <div></div>
          <router-link to="/sale" class="viewmore-btn">Xem thêm</router-link>
        </div>
      </div>
    </div>

    <div class="grid">
      <div style="display: flex; width: 100%; margin-top: 40px">
        <router-link to="/men" class="gender-view men-view"></router-link>
        <router-link to="/women" class="gender-view women-view"></router-link>
      </div>
    </div>
    <div class="grid new-product" style="margin-top: 40px; margin-bottom: 10px">
      <h1>Bộ sưu tập mới</h1>
      <router-link
        to="/collection/summercollection"
        class="banner banner1"
      ></router-link>
    </div>
  </div>
</template>

<script>
import { Swiper, SwiperSlide } from "swiper/vue";
import { Autoplay, Pagination } from "swiper/modules";
import "swiper/css";
import "swiper/css/pagination";
import axios from "axios";

export default {
  components: {
    Swiper,
    SwiperSlide,
  },

  data() {
    return {
      banner: [
        {
          url: "1",
        },
        {
          url: "2",
        },
        {
          url: "3",
        },
        {
          url: "4",
        },
      ],
      modules: [Autoplay, Pagination],
      products: [],
      saleproducts: [],
      url: this.urlbe + "/product/list?",
      search: "",
      gender: "",
      categorytype: 0,
      category: 0,
      type: "",
      userRateFilter: 0,
      priceGT: 0,
      priceLT: 0,
      typeSort: "id",
      isSort: "desc",
      totalItem: 0,
      totalItemSale: 0,
      totalPage: 0,
      pageNumber: 1,
      limit: 4,
    };
  },

  props: ["islogin", "isAdmin", "urlbe"],

  methods: {
    formatPrice(number) {
      return new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
      }).format(number);
    },

    async getList(page) {
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
            page +
            "&sortby=" +
            this.typeSort +
            "&sort=" +
            this.isSort
        );
        return response.data.content;
      } catch (error) {
        console.error(error);
      }
    },

    async getListSale(page) {
      try {
        const response = await axios.get(
          this.urlbe +
            "/product/sale?" +
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
            page +
            "&sortby=" +
            this.typeSort +
            "&sort=" +
            this.isSort
        );
        this.totalPage = Math.ceil(response.data.totalElements / 4);
        return response.data.content;
      } catch (error) {
        console.error(error);
      }
    },
  },

  async created() {
    this.products[1] = await this.getList(1);
    this.products[2] = await this.getList(2);
    this.products[3] = await this.getList(3);
    this.products[4] = await this.getList(4);

    this.saleproducts[1] = await this.getListSale(1);
    this.saleproducts[2] = await this.getListSale(2);
  },
};
</script>


<style scoped>
/* :deep(.slick-slide) {
  text-align: center;
  height: 700px;
  line-height: 160px;
  background: #364d79;
  overflow: hidden;
}
:deep(.slick-slide h3) {
  color: #fff;
} */

.slider {
  width: 100%;
  height: 700px;
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
}

.slider1 {
  background-image: url("../assets/images/banner/banner.png");
}

.slider2 {
  background-image: url("../assets/images/banner/lb_2_98_44_anhslide.jpg");
}

.slider3 {
  background-image: url("../assets/images/banner/b19.jpg");
}

.slider4 {
  background-image: url("../assets/images/banner/lb_3_97_45_anhslide.jpg");
}

.new-product {
  margin-top: 30px;
  width: 100%;
}

.new-product h1 {
  text-align: left;
  margin-left: 40px;
  font-size: 50px;
}

.list-new {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  /* height: 300px; */
  background-color: #fff;
  border-radius: 30px;
  padding: 20px;
}

.list-item {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}

.item {
  width: 300px;
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
  /* height: 400px; */
  border-radius: 35px;
  padding: 30px;
  padding-bottom: 0;
}

.product-name {
  width: 100%;
  padding: 0 30px;
  height: 60px;
  /* white-space: nowrap; Ngăn văn bản xuống dòng
  overflow: hidden; /* Ẩn phần văn bản vượt quá chiều rộng */
  /* text-overflow: ellipsis;  */
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

.viewmore {
  display: flex;
  justify-content: space-between;
}

.viewmore-btn {
  font-size: 20px;
  text-decoration: none;
  color: black;
}

.gender-view {
  width: 50%;
  height: 600px;
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
  border: 1px solid #ccc;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
  margin: 2px;
}

.gender-view:hover {
  opacity: 0.8;
  transition: 0.5s;
  transform: scale(1.02);
}

.men-view {
  background-image: url("../assets/images/banner/Thoi-trang-nam.jpg");
}

.women-view {
  background-image: url("../assets/images/banner/Thoi-trang-nu.jpg");
}

.banner {
  width: 100%;
  height: 400px;
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
  border: 1px solid #ccc;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
  margin: 5px;
}

.banner:hover {
  opacity: 0.8;
  transition: 0.5s;
  transform: scale(1.05);
}

.banner1 {
  background-image: url("../assets/images/banner/Screenshot 2023-08-22 193919.png");
}

.grid {
  width: 100%;
  height: 100%;
  max-width: 1440px;
  margin: 0 auto;
  flex-shrink: 0;
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
  flex-wrap: wrap;
}
@media (max-width: 739px) {
  .slider {
    height: 500px;
  }
  .slider4,
  .slider2 {
    padding-left: 1000px;
  }
}
</style>