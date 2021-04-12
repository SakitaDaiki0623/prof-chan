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
        "backimage": "url('../tail_images/backimage01.jpg')",
        "backimage-02": "url('../tail_images/backimage_kari.jpg')",
        "prof-card": "url('../tail_images/prof_card.jpg')",
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
