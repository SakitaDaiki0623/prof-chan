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
      backgroundImage: (theme) => ({
        backimage: "url('../images/backimage01.jpg')",
        "backimage-02": "url('../images/backimage02.jpg')",
        "prof-card": "url('../images/question_block_bg.jpg')",
        "text-prof-block": "url('../images/text_block_bg.jpg')",
        "question-prof-block": "url('../images/question_block_bg.jpg')",
      }),
      fontFamily: {
        "prof-default": [
          "TsukuARdGothic-Regular",
          "klee",
          "Hannotate SC",
          "Chalkboard SE",
          "Comic Sans MS",
          "sans-serif",
        ],
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
