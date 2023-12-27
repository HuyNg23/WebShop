<template>
  <div class="product-view-page">
    <div v-if="product.imageEntities" class="product-view grid">
      <div class="img-select">
        <img
          :src="urlbe + '/file/' + product.imageEntities[0].imgURL"
          alt=""
          class="img-select__img"
          @click="imgNumber = 0"
        />
        <img
          :src="urlbe + '/file/' + product.imageEntities[1].imgURL"
          alt=""
          class="img-select__img"
          @click="imgNumber = 1"
        />
        <img
          :src="urlbe + '/file/' + product.imageEntities[2].imgURL"
          alt=""
          class="img-select__img"
          @click="imgNumber = 2"
        />
      </div>
      <img
        :src="urlbe + '/file/' + product.imageEntities[imgNumber].imgURL"
        alt=""
        class="img-product"
      />
      <div class="product-info">
        <h2 class="products-name">
          {{ product.productName }}
          <div class="sale" v-if="product.discount > 0">
            <img
              src="../assets/images/features/—Pngtree—sale_146155.png"
              alt=""
              class=""
              style="width: 100px; height: 100px;"
            />
            {{product.discount}}%
            </div>
          </h2>
        <h1 class="products-price">{{ formatPrice(product.price) }}</h1>
        <h2 class="products-price" v-if="product.discount > 0" style="color: red; font-weight: 700">{{ formatPrice(product.price * (100 - product.discount)/100) }}</h2>
        <h3 class="">Chọn size</h3>
        <div class="size-select">
          <div
            class="size-item"
            @click="changeSize('XS')"
            :class="{ 'size-item__active': sizeItem == 'XS' }"
          >
            XS
          </div>
          <div
            class="size-item"
            @click="changeSize('S')"
            :class="{ 'size-item__active': sizeItem == 'S' }"
          >
            S
          </div>
          <div
            class="size-item"
            @click="changeSize('M')"
            :class="{ 'size-item__active': sizeItem == 'M' }"
          >
            M
          </div>
          <div
            class="size-item"
            @click="changeSize('L')"
            :class="{ 'size-item__active': sizeItem == 'L' }"
          >
            L
          </div>
          <div
            class="size-item"
            @click="changeSize('XL')"
            :class="{ 'size-item__active': sizeItem == 'XL' }"
          >
            XL
          </div>
          <div
            class="size-item"
            @click="changeSize('XXL')"
            :class="{ 'size-item__active': sizeItem == 'XXL' }"
          >
            XXL
          </div>
        </div>
        <h3 class="">Chọn số lượng: {{ numItem }}</h3>
        <div class="select__num-item">
          <div class="num-item" @click="setNumItem(-1)">-</div>
          <input
            type="text"
            class="input__num-item"
            :placeholder="numItem"
            v-model="numItem"
          />
          <div class="num-item" @click="setNumItem(1)">+</div>
        </div>
        <button class="btn-buy" @click="addCart()">Add to cart</button>

        <h2>Thông tin chi tiết</h2>
        <div class="description">
          {{ product.description }}
        </div>
      </div>
    </div>
    <div v-else>
      <h1>Loading...</h1>
    </div>
    <div class="grid">
      <div class="evaluate-product">
        <div class="content">Đánh giá sản phẩm</div>
        <div class="comment">
          <div class="user-comment">
            <div class="username">
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
              {{ user.lastName }}
            </div>
            <div class="rate-star">
              <font-awesome-icon
                :icon="['fas', 'star']"
                class="star"
                :class="{ 'star-active': userRate == 1 }"
                @click="userRateStar(1)"
              />
              <font-awesome-icon
                :icon="['fas', 'star']"
                class="star"
                :class="{ 'star-active': userRate == 2 }"
                @click="userRateStar(2)"
              />
              <font-awesome-icon
                :icon="['fas', 'star']"
                class="star"
                :class="{ 'star-active': userRate == 3 }"
                @click="userRateStar(3)"
              />
              <font-awesome-icon
                :icon="['fas', 'star']"
                class="star"
                :class="{ 'star-active': userRate == 4 }"
                @click="userRateStar(4)"
              />
              <font-awesome-icon
                :icon="['fas', 'star']"
                class="star"
                :class="{ 'star-active': userRate == 5 }"
                @click="userRateStar(5)"
              />
            </div>
            <div class="comment-place">
              <textarea
                name=""
                id=""
                cols="1"
                rows="20"
                class="comment-input"
                v-model="comment"
              >
              </textarea>
              <button class="comment-btn" @click="evaluate">Bình luận</button>
            </div>
          </div>
        </div>
        <div class="content">
          {{ rate }}/5
          <font-awesome-icon :icon="['fas', 'star']" class="star-rate-point" />
        </div>
        <div class="num-comment">{{ numComment }} đánh giá</div>
        <div class="user-comment">
          <div class="comment-list">
            <div
              class="comment-item"
              v-for="comment in comments"
              :key="comment.id"
            >
              <div class="comment-item__user">
                <div class="comment-item__user-name">
                  <img
                    :src="this.urlbe + '/file/' + comment.userInfoEntity.avatarUrl"
                    alt=""
                    class="avt-img"
                    v-if="comment.userInfoEntity.avatarUrl != null"
                  />
                  <img
                    src="../assets/images/people/143086968_2856368904622192_1959732218791162458_n.png"
                    alt=""
                    class="avt-img"
                    v-if="comment.userInfoEntity.avatarUrl == null"
                  />
                  {{ comment.userInfoEntity.firstName }}
                  {{ comment.userInfoEntity.lastName }}
                </div>

                <div
                  class="comment-item__user-rate"
                  v-for="i in comment.rate"
                  :key="i"
                >
                  <font-awesome-icon
                    :icon="['fas', 'star']"
                    class="star star-active"
                  />
                </div>
                <div class="comment-item__get-comment">
                  {{ comment.comment }}
                </div>
                <button v-if="isAdmin" style="margin: 10px" @click="deleteEvaluate(comment.id)">Xóa đánh giá này</button>
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
export default {
  data() {
    return {
      product: {},
      comments: {},
      imgNumber: 0,
      numComment: 0,
      rate: 0,
      userRate: 0,
      comment: "",
      numItem: 1,
      sizeItem: "",
    };
  },

  props: ["islogin", "isAdmin", "user", "urlbe"],

  created() {
    this.getProduct();
  },

  methods: {
    formatPrice(number) {
      return new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
      }).format(number);
    },

    userRateStar(star) {
      this.userRate = star;
      console.log(this.userRate);
    },

    getRate() {
      var sum = 0;
      if (this.comments.length > 0) {
        for (let i = 0; i < this.comments.length; i++) {
          sum += this.comments[i].rate;
        }
        return sum / this.comments.length;
      }
      return 0;
    },

    reversedItems() {
      this.comments.reverse();
    },

    changeSize(size) {
      this.sizeItem = size;
    },

    setNumItem(num) {
      this.numItem = Number(this.numItem);
      if (this.numItem + num > 0) {
        this.numItem += Number(num);
      }
    },

    async getProduct() {
      try {
        const response = await axios.get(
          this.urlbe + "/product/list/" + this.$route.params.id
        );
        this.product = response.data;
        this.comments = response.data.evaluateEntities;
        this.rate = response.data.rate;
        this.numComment = response.data.numEvaluate;
      } catch (error) {
        console.error(error);
      }
    },

    addCart() {
      if (this.sizeItem != "" && this.numItem > 0) {
        this.shoppingCart = JSON.parse(localStorage.getItem("shoppingCart"));
        if (this.shoppingCart == null) {
          this.shoppingCart = [];
          this.shoppingCart.push({
            product: this.product,
            size: this.sizeItem,
            quantity: this.numItem,
          });
          localStorage.setItem(
            "shoppingCart",
            JSON.stringify(this.shoppingCart)
          );
          alert("Thêm vào giỏ hàng thành công");
          console.log(localStorage.getItem("shoppingCart"));
          return;
        } else {
          for (let i = 0; i < this.shoppingCart.length; i++) {
            if (
              this.shoppingCart[i].product.id == this.product.id &&
              this.shoppingCart[i].size == this.sizeItem
            ) {
              this.shoppingCart[i].quantity += this.numItem;
              localStorage.setItem(
                "shoppingCart",
                JSON.stringify(this.shoppingCart)
              );
              alert("Thêm vào giỏ hàng thành công");
              console.log(localStorage.getItem("shoppingCart"));
              return;
            }
          }
          this.shoppingCart.push({
            product: this.product,
            size: this.sizeItem,
            quantity: this.numItem,
          });
          localStorage.setItem(
            "shoppingCart",
            JSON.stringify(this.shoppingCart)
          );
          alert("Thêm vào giỏ hàng thành công");
          console.log(localStorage.getItem("shoppingCart"));
          return;
        }
      } else {
        alert("Bạn chưa chọn size");
      }
    },

    async evaluate() {
      if (!this.islogin) {
        alert("Bạn chưa đăng nhập");
        this.$router.push("/login");
        return;
      }
      if (this.userRate == 0) {
        alert("Bạn chưa đánh giá");
        return;
      }
      try {
        const response = await axios.post(
          this.urlbe + "/evaluate/create/" + this.$route.params.id,
          {
            rate: this.userRate,
            comment: this.comment,
          },
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        console.log(response);
        window.location.replace(
          "http://localhost:8080/shop/" + this.product.id
        );
      } catch (error) {
        console.error(error);
      }
    },

    async deleteEvaluate(id) {
      try {
        const response = await axios.delete(
          this.urlbe + "/evaluate/delete/" + id,
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        response
        window.location.replace(
          "http://localhost:8080/shop/" + this.product.id
        );
      } catch (error) {
        console.error(error);
      }
    }
  },
};
</script>

<style scoped>
.product-view-page {
  margin-top: 100px;
}

.product-view {
  display: flex;
}

.product-info {
  width: calc(100% - 550px);
  padding: 50px;
  text-align: left;
}

.img-product {
  width: 500px;
  border: 1px solid #c0c0c0;
}

.img-select {
  width: 200px;
  border: 1px solid black;
  margin-right: 10px;
  padding: 10px;
  box-sizing: border-box;
}

.img-select__img {
  width: 100%;
  height: 200px;
  border: 1px solid #c0c0c0;
  margin-bottom: 10px;
}

.img-select__img:hover {
  cursor: pointer;
  border: 2px solid #42b983;
}

.products-name {
  font-size: 30px;
  margin-bottom: 20px;
  position: relative;
}

.sale {
  position: absolute;
  top: 0;
  transform: translateY(15px);
  left: 0;
  font-size: 20px;
  color: red;
  font-weight: 700;
}

.products-price {
  font-size: 30px;
  margin-bottom: 20px;
}

.size-select {
  display: flex;
  margin-top: 20px;
  margin-bottom: 20px;
}

.size-item {
  width: 50px;
  height: 50px;
  border: 1px solid #c0c0c0;
  margin-right: 20px;
  text-align: center;
  line-height: 50px;
  font-size: 20px;
  cursor: pointer;
}

.size-item:hover {
  cursor: pointer;
  background-color: #42b983;
  border: 2px solid #000;
  color: #fff;
}
.size-item__active {
  cursor: pointer;
  background-color: #42b983;
  border: 2px solid #000;
  color: #fff;
}

.select__num-item {
  display: flex;
  margin-top: 20px;
  margin-bottom: 20px;
}

.num-item {
  width: 50px;
  height: 50px;
  border: 1px solid #c0c0c0;
  text-align: center;
  line-height: 50px;
  font-size: 20px;
  cursor: pointer;
}

.input__num-item {
  width: 50px;
  height: 50px;
  border: 1px solid #c0c0c0;
  text-align: center;
  line-height: 50px;
  font-size: 20px;
  color: black;
}

.btn-buy {
  width: 400px;
  height: 50px;
  border: 2px solid #000;
  background-color: #42b983;
  color: #fff;
  border-radius: 10px;
  margin-top: 20px;
  margin-bottom: 25px;
}

.btn-buy:hover {
  cursor: pointer;
  opacity: 0.8;
}

.description {
  padding: 10px;
}

.evaluate-product {
  width: 100%;
}

.content {
  font-size: 40px;
  height: 40px;
  text-align: left;
  margin-left: 50px;
  margin-top: 50px;
  margin-bottom: 20px;
}

.comment {
  width: 100%;
  display: block;
  box-sizing: border-box;
  border-top: 1px solid black;
}

.user-comment {
  /* height: 250px; */
  margin: 20px;
  box-sizing: border-box;
  border: 1px solid black;
  position: relative;
}

.username {
  width: 100%;
  font-size: 20px;
  height: 100px;
  line-height: 50px;
  text-align: left;
  margin-left: 30px;
  display: inline-block;
}

.avt-img {
  width: 70px;
  height: 70px;
  border: 3px solid #cccccc;
  border-radius: 200px;
  margin: 10px;
}

.rate-star {
  position: absolute;
  top: 40px;
  left: 50%;
  transform: translateX(-50%);
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

.comment-input {
  width: 100%;
  height: 100px;
  font-size: 20px;
  padding: 20px;
  box-sizing: border-box;
  border-radius: 20px;
}

.comment-place {
  width: 100%;
  padding: 20px;
  padding-top: 0px;
}

textarea {
  resize: none;
}

.comment-btn {
  width: 100px;
  height: 40px;
  font-size: 20px;
  border: 1px solid black;
  cursor: pointer;
  /* margin-right: 25px; */
  margin-top: 20px;
}

.star-rate-point {
  font-size: 30px;
  color: rgb(255, 251, 8);
  margin-bottom: 5px;
}

.comment-item__user {
  margin: 20px;
  border: 1px solid black;
  /* display: flex; */
}

.comment-item__user-name {
  text-align: left;
  font-size: 20px;
  padding: 20px;
  padding-bottom: 0px;
  text-decoration: underline;
}

.comment-item__user-rate {
  display: inline-block;
  transform: translateY(-50px);
}

.comment-item__user-rate .star {
  margin-left: 0px;
}

.comment-item__get-comment {
  text-align: left;
  font-size: 20px;
  padding: 30px;
  padding-top: 0px;
}

.grid {
  width: 100%;
  max-width: 1440px;
  max-height: 100%;
  margin: 0 auto;
  flex-shrink: 0;
  display: flex;
  justify-content: space-between;
}
</style>
