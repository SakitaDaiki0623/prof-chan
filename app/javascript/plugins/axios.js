import axios from "axios";

const axiosInstance = axios.create({
  baseURL: "/api/v1",
});

export default axiosInstance;
