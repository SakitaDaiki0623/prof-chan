// app/javascript/store/modules/users.js
import axios from "../../plugins/axios.js";

export const users = {
  namespaced: true,
  state: {
    users: [],
  },
};
