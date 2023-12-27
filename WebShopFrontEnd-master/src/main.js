import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import "@fontsource/koho/200.css";
import "@fontsource/koho/300.css";
import "@fontsource/koho/400.css";
import "@fontsource/koho/500.css";
import "./assets/styles/style.css";
import Antd from 'ant-design-vue';
import 'ant-design-vue/dist/reset.css';

import { library } from '@fortawesome/fontawesome-svg-core'

/* import font awesome icon component */
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

/* import specific icons */
import { faCartShopping, faUserSecret, faFilter ,faUser, faBell, faMagnifyingGlass, faLock, faStar , faSortUp, faSortDown, faRightFromBracket, faUsers, faBars, faBagShopping, faCreditCard, faEnvelope, faPhone, faLocationDot} from '@fortawesome/free-solid-svg-icons'
import { faDownload} from '@fortawesome/free-solid-svg-icons'
import { faFacebookF, faTwitter, faInstagram } from '@fortawesome/free-brands-svg-icons'

library.add(faDownload)
library.add(faFacebookF, faTwitter, faInstagram)
library.add(faUserSecret, faCartShopping, faFilter, faUser, faBell, faMagnifyingGlass, faLock, faStar, faSortUp, faSortDown,faRightFromBracket, faUsers, faBars, faBagShopping,faCreditCard, faEnvelope, faPhone, faLocationDot)

createApp(App).use(Antd).use(router).component('font-awesome-icon', FontAwesomeIcon).mount("#app");

