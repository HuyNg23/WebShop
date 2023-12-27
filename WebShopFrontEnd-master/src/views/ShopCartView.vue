<template>
  <div class="shopcart">
    <div class="grid">
      <div claSs="shopping-cart">
        <div class="list-item">
          <div
            class="item"
            v-for="(cartegoryItem, idx) in shoppingCart"
            :key="idx"
          >
            <img
              :src="
                this.urlbe +
                '/file/' +
                cartegoryItem.product.imageEntities[0].imgURL
              "
              alt=""
              class="item-img"
            />
            <div class="item-product">
              <h2>{{ cartegoryItem.product.productName }}</h2>
              <h3>Size: {{ cartegoryItem.size }}</h3>
              <h3>{{ formatPrice(cartegoryItem.product.price) }}</h3>
            </div>
            <div class="item-discount">
              <h2>Giảm giá(%)</h2>
              <h3>{{ cartegoryItem.product.discount }}</h3>
            </div>
            <div class="item-quantity">
              <h2>Số lượng:</h2>
              <div class="select__num-item">
                <div class="num-item" @click="setNumItem(idx, -1)">-</div>
                <input
                  type="text"
                  class="input__num-item"
                  :placeholder="cartegoryItem.quantity"
                  v-model="cartegoryItem.quantity"
                />
                <div class="num-item" @click="setNumItem(idx, 1)">+</div>
              </div>
            </div>
            <button class="decart" @click="deCart(idx)">x</button>
          </div>
        </div>
      </div>
      <div class="order-sumary">
        <h1>Tổng tiền:</h1>
        <div class="total">
          <h1>={{ formatPrice(amount) }}</h1>
        </div>
        <button class="btn-order" @click="sendOrder">Đặt hàng</button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import SockJS from "sockjs-client";
import Stomp from "webstomp-client";
export default {
  data() {
    return {
      shoppingCart: [],
      orderId: 0,
      amount: 0,
      messages: [],
    };
  },

  props: ["islogin", "isAdmin", "urlbe", "user"],

  created() {
    this.connect();
    if (
      JSON.parse(localStorage.getItem("shoppingCart")) == null ||
      JSON.parse(localStorage.getItem("shoppingCart")).length == 0
    ) {
      localStorage.setItem("shoppingCart", JSON.stringify(this.shoppingCart));
    } else {
      this.shoppingCart = JSON.parse(localStorage.getItem("shoppingCart"));
      this.shoppingCart.reverse();
      console.log(this.shoppingCart.length);
      this.shoppingCart.forEach((cartItem) => {
        this.amount +=
          ((cartItem.product.price * (100 - cartItem.product.discount)) / 100) *
          cartItem.quantity;
      });
    }
  },

  getAmount() {},

  methods: {
    formatPrice(number) {
      return new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
      }).format(number);
    },

    addCart(product) {
      this.shoppingCart.push(product);
      localStorage.setItem("shoppingCart", JSON.stringify(this.shoppingCart));
      console.log(localStorage.getItem("shoppingCart"));
    },

    setNumItem(idx, num) {
      if (this.shoppingCart[idx].quantity + num > 0) {
        this.shoppingCart[idx].quantity += num;
        localStorage.setItem(
          "shoppingCart",
          JSON.stringify(this.shoppingCart.reverse())
        );
        this.shoppingCart.reverse();
      }
      console.log(this.shoppingCart[idx].quantity + num);
      this.amount = 0;
      this.shoppingCart.forEach((cartItem) => {
        this.amount +=
          ((cartItem.product.price * (100 - cartItem.product.discount)) / 100) *
          cartItem.quantity;
      });
    },

    deCart(idx) {
      this.shoppingCart.splice(idx, 1);
      localStorage.setItem(
        "shoppingCart",
        JSON.stringify(this.shoppingCart.reverse())
      );
      this.shoppingCart.reverse();
      this.amount = 0;
      this.shoppingCart.forEach((cartItem) => {
        this.amount +=
          ((cartItem.product.price * (100 - cartItem.product.discount)) / 100) *
          cartItem.quantity;
      });
    },

    async sendOrder() {
      if (this.islogin) {
        this.orderId = await this.createOder();
        console.log(this.orderId);
        for (var i = 0; i < this.shoppingCart.length; i++) {
          this.addCartItemOder(
            this.shoppingCart[i].product.id,
            this.shoppingCart[i].size,
            this.shoppingCart[i].quantity
          );
          console.log(this.shoppingCart[i].product.id);
        }
        localStorage.removeItem("shoppingCart");
        this.sendMessage("đơn hàng #" + this.orderId);
        alert("Đặt hàng thành công");
        this.$router.push("/user");
      } else {
        alert("Bạn chưa đăng nhập");
        this.$router.push("/login");
      }
    },

    async createOder() {
      try {
        const response = await axios.post(
          // this.urlbe + "/order/create",
          "http://localhost:8762/order/create",
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        return response.data.id;
      } catch (error) {
        console.error(error);
      }
    },

    async addCartItemOder(pid, size, quantity) {
      try {
        const response = await axios.post(
          "http://localhost:8762/order/cart/create/" +
            this.orderId +
            "?pid=" +
            pid,
          // this.urlbe + "/cart/create/" + this.orderId + "?pid=" + pid,
          {
            size: size,
            quantity: quantity,
          },
          {
            headers: {
              "Access-Control-Allow-Origin": "*",
              Authorization: "Bearer " + localStorage.getItem("token"),
            },
          }
        );
        return response.data.id;
      } catch (error) {
        console.error(error);
      }
    },

    connect() {
      var socket = new SockJS("http://localhost:8085/ws");
      this.stompClient = Stomp.over(socket);
      this.stompClient.connect({}, () => {
        this.stompClient.subscribe("/topic/public", (tick) => {
          this.messages.push(tick.body);
        });
        this.stompClient.subscribe(
          "/user/" + this.user.id + "/queue/reply",
          (tick) => {
            this.messages.push(JSON.parse(tick.body).content);
          }
        );
      });
    },

    sendMessage(msg) {
      var objectMessage = {
        sender: this.user.id,
        content: msg,
        type: "CHAT",
        receiver: "1",
      };
      this.stompClient.send(
        "/app/chat.sendMessagePrivate",
        JSON.stringify(objectMessage)
      );
    },
  },
};
</script>

<style scoped>
.shopcart {
  margin-top: 100px;
}

.shopping-cart {
  width: 850px;
  height: 600px;
  display: flex;
  margin-top: 20px;
  margin-bottom: 20px;
  background-color: #c0c0c0;
}

.order-sumary {
  width: 500px;
  text-align: left;
}

.total {
  height: 200px;
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
  margin-bottom: 20px;
  background-color: #c0c0c0;
  border-radius: 20px;
  padding: 20px;
}

.list-item {
  width: 100%;
  height: 100%;
  background-color: #c0c0c0;
  overflow: auto;
  overflow-y: scroll;
  padding: 20px;
}

.item {
  width: 100%;
  height: 150px;
  background-color: #fff;
  /* padding: 20px; */
  border: 2px solid #000;
  border-radius: 20px;
  box-sizing: border-box;
  box-shadow: 0 0 10px #c0c0c0;
  display: flex;
  justify-content: space-between;
}

.item img {
  width: 100px;
  object-fit: cover;
  border: 1px solid #000;
  border-radius: 20px;
}

.item-product {
  padding: 20px;
  width: 330px;
  display: inline-block;
  text-align: left;
}

.decart {
  width: 60px;
  background-color: #fff;
  border: none;
  border-radius: 20px;
  font-size: 20px;
}

.decart:hover {
  opacity: 0.5;
  cursor: pointer;
}

.item-quantity {
  width: 120px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin-left: 20px;
}

.item-discount {
  width: 130px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin-bottom: 40px;
}

.select__num-item {
  display: flex;
  width: 100%;
  padding-bottom: 30px;
}

.input__num-item {
  width: 40px;
  height: 40px;
  border: 1px solid #c0c0c0;
  text-align: center;
  line-height: 40px;
  font-size: 20px;
  color: black;
}

.num-item {
  width: 40px;
  height: 40px;
  border: 1px solid #c0c0c0;
  text-align: center;
  line-height: 40px;
  font-size: 20px;
  cursor: pointer;
}

.btn-order {
  width: 80%;
  height: 50px;
  border-radius: 20px;
  background-color: #fff;
  border: 2px solid #000;
  margin-left: 50px;
}

.btn-order:hover {
  color: #fff;
  background-color: #42b983;
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
