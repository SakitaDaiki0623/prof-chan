// app/javascript/css/tailwind.config.js
module.exports = {
  purge: [
    "./app/**/*.html.erb",
    "./app/**/*.html.slim",
    "./app/**/*.js.erb",
    "./app/helpers/**/*.rb",
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      // backgroundImage: (theme) => ({
      //   backimage: "url('../images/backimage01.jpg')",
      //   "backimage-02": "url('../images/backimage02.jpg')",
      //   "prof-card": "url('../images/question_block_bg.jpg')",
      //   "text-prof-block": "url('../images/text_block_bg.jpg')",
      //   "question-prof-block": "url('../images/question_block_bg.jpg')",
      // }),
      colors: {
        brown: {
          "50": "#fffaf0",
          "100": "#EFEBE9",
          "200": "#D7CCC8",
          "300": "#BCAAA4",
          "400": "#A1887F",
          "500": "#8D6E63",
          "600": "#795548",
          "700": "#6D4C41",
          "800": "#5D4037",
          "900": "#4E342E",
        },
        beaver: {
          "50": "#fefdfb",
        },
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
