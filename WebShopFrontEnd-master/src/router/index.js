import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";

const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/shop",
    name: "shop",
    component: () =>
      import("../views/ShopView.vue"),
  },
  {
    path: "/about",
    name: "about",
    component: () =>
      import("../views/AboutView.vue"),
  },
  {
    path: "/shopcart",
    name: "shopcart",
    component: () =>
      import("../views/ShopCartView.vue"),
  },
  {
    path: "/shop/:id",
    name: "product",
    component: () =>
      import("../views/ProductView.vue"),
  },
  {
    path: "/login",
    name: "login",
    component: () =>
      import("../views/LoginView.vue"),
  },
  {
    path: "/register",
    name: "register",
    component: () =>
      import("../views/RegisterView.vue"),
  },
  {
    path: "/forgot",
    name: "forgot",
    component: () =>
      import("../views/ForgotPasswordView.vue"),
  },
  {
    path: "/change/:token",
    name: "change",
    component: () =>
      import("../views/ChangePasswordView.vue"),
  },
  {
    path: "/search",
    name: "search",
    component: () =>
      import("../views/SearchView.vue"),
  },
  {
    path: "/men",
    name: "men",
    component: () =>
      import("../views/MenView.vue"),
  },
  {
    path: "/men/men-top",
    name: "men-top",
    component: () =>
      import("../views/MenTopView.vue"),
  },
  {
    path: "/men/men-bottom",
    name: "men-bottom",
    component: () =>
      import("../views/MenBottomView.vue"),
  },
  {
    path: "/women",
    name: "women",
    component: () =>
      import("../views/WomenView.vue"),
  },
  {
    path: "/women/women-top",
    name: "women-top",
    component: () =>
      import("../views/WomenTopView.vue"),
  },
  {
    path: "/women/women-bottom",
    name: "women-bottom",
    component: () =>
      import("../views/WomenBottomView.vue"),
  },
  {
    path: "/women/women-dress",
    name: "women-dress",
    component: () =>
      import("../views/WomenDressView.vue"),
  },
  {
    path: "/accessories",
    name: "accessories",
    component: () =>
      import("../views/AccessoriesView.vue"),
  },
  {
    path: "/sale",
    name: "sale",
    component: () =>
      import("../views/SaleView.vue"),
  },
  {
    path: "/collection",
    name: "collection",
    component: () =>
      import("../views/CollectionView.vue"),
  },
  {
    path: "/collection/summercollection",
    name: "summercollection",
    component: () =>
      import("../views/SummerCollectionView.vue"),
  },
  {
    path: "/nofication",
    name: "nofication",
    component: () =>
      import("../views/NoficationView.vue"),
  },
  {
    path: "/user",
    name: "user",
    component: () =>
      import("../views/UserView.vue"),
  },
  {
    path: "/admin",
    name: "admin",
    component: () =>
      import("../views/AdminView.vue"),
  },
  {
    path: "/404",
    name: "404",
    component: () =>
      import("../views/404View.vue"),
  },
  {
    path: "/:pathMatch(.*)*",
    name: "404",
    component: () =>
      import("../views/404View.vue"),
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
  scrollBehavior(to, from, savedPosition) {
    // Nếu có savedPosition, sử dụng nó để di chuyển đến vị trí đã lưu trước đó
    if (savedPosition) {
      return savedPosition;
    }
    
    // Di chuyển đến đầu trang của trang mới khi chuyển đổi router
    return { top: 0};
  }
});

export default router;
