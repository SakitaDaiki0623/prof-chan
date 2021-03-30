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
        "note": "url('/app/assets/images/note_bg.jpg')",
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
