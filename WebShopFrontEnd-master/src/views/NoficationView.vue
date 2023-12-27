<template>
  <div class="nofication">
    <div class="grid">
      <div class="user-container">
        <div
          class="list-user"
          v-for="(user, key) in users"
          :key="key"
          @click="receiverId = user.id"
          :class="{ 'receiver-user': receiverId == user.id }"
        >
          <div>
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
            {{ user.firstName + user.lastName }}
          </div>
        </div>
      </div>
      <div class="message-container">
        <div class="chatbox" ref="scrollable">
          <div class="item" v-for="(message, key) in messages" :key="key">
            <h1>{{ message }}</h1>
            
          </div>
        </div>
        <form @submit.prevent="sendMessage(inputMessage)">
          <input type="text" v-model="inputMessage" />
          <button type="submit">Send</button>
        </form>
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
      name: "",
      messages: [],
      users: [],
      inputMessage: "",
      stompClient: null,
      typeSort: "id",
      isSort: "asc",
      totalItem: 0,
      totalPage: 0,
      pageNumber: 1,
      limit: 12,
      receiverId: 0,
    };
  },

  props: ["islogin", "isAdmin", "user", "urlbe"],

  created() {
    this.connect();
    this.getListFriend();
    console.log(this.users);
  },

  methods: {
    sendMessage(msg) {
      var objectMessage = {
        sender: this.user.id,
        content: msg,
        type: "CHAT",
        receiver: this.receiverId,
      };
      this.stompClient.send(
        "/app/chat.sendMessagePrivate",
        JSON.stringify(objectMessage)
      );
      this.messages.push(msg);
      const scrollableElement = this.$refs.scrollable;
      if (scrollableElement) {
        scrollableElement.scrollTop = scrollableElement.scrollHeight + 1;
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

    async getListFriend() {
      try {
        const response = await axios.get(
          "http://localhost:8081/userinfo/list?" +
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
        this.users = response.data.content;
        this.totalPage = response.data.totalPages;
        this.totalItem = response.data.totalElements;
        return response.data;
      } catch (error) {
        console.error(error);
      }
    },
  },

  computed: {},
};
</script>

<style scoped>
.user-container {
  width: 20%;
  height: 80vh;
  background-color: #fff;
  border: 1px solid #ccc;
  margin-right: 10px;
}

.list-user {
  width: 100%;
  height: 10%;
  display: flex;
  justify-content: center;
  align-items: center;
  border: 1px solid #ccc;
}

.list-user:hover {
  border: 3px solid #42b983;
}

.receiver-user {
  border: 3px solid #42b983;
}

.avt-img {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  margin-right: 10px;
}

.message-container {
  width: 80%; /* Chiều rộng của phần tử container */
  height: 80vh; /* Chiều cao của phần tử container */
  overflow: auto; /* Thanh cuộn sẽ chỉ xuất hiện khi nội dung vượt quá kích thước hiển thị */
  border: 1px solid #ccc;
  margin-bottom: 10px;
}

.chatbox {
  width: 100%;
  height: 90%;
  border: 1px solid #ccc;
  overflow: auto;
  overflow-y: scroll;
}

.grid {
  width: 100%;
  max-width: 1440px;
  max-height: 100%;
  margin: 0 auto;
  flex-shrink: 0;
  display: flex;
}
</style>

