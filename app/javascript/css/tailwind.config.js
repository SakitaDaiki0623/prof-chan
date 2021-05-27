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
    screens: {
      sm: "600px",
      // => @media (min-width: 640px) { ... }

      md: "960px",
      // => @media (min-width: 768px) { ... }

      lg: "1264px",
      // => @media (min-width: 1024px) { ... }

      xl: "1904px",
      // => @media (min-width: 1280px) { ... }

      "2xl": "1536px",
      // => @media (min-width: 1536px) { ... }
    },
    extend: {
      backgroundImage: (theme) => ({
        "prof-normal": "url('../images/prof_normal.png')",
      }),
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
