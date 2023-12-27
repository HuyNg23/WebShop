<template>
  <div class="grid">
    <div class="products">
      <router-link to="/women/women-top" class="banner banner1"></router-link>
      <router-link to="/women/women-bottom" class="banner banner2"></router-link>
      <router-link to="/women/women-dress" class="banner banner3"></router-link>
    </div>
  </div>
</template>

<style scoped>
.products {
  width: 100%;
  margin-top: 70px;
  margin-bottom: 10px;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
}

.banner {
  width: 100%;
  height: 400px;
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
  border: 1px solid #ccc;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  margin: 5px;
  border-radius: 10px;
}

.banner:hover {
  opacity: 0.8;
  transition: 0.5s;
  transform: scale(1.05);
}

.banner1 {
  background-image: url("../assets/images/features/ao-nu-routine-min.jpg");
}

.banner2 {
  background-image: url("../assets/images/features/quan-nu-routine-min.jpg");
}

.banner3 {
  background-image: url("../assets/images/features/chan-vay-va-dam-nu-routine-min.jpg");
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
