const colors = require('tailwindcss/colors')

module.exports = {
  darkMode: 'class',
  content: [

    './app/helpers/**/*.rb',

    './app/javascript/**/*.js',

    './app/views/**/*',

  ],

  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      gray: colors.gray,
      emerald: colors.emerald,
      indigo: colors.indigo,
      yellow: colors.yellow,
    },
    extend: {
      fontFamily: {
        orbitron: ['Orbitron', 'sans-serif'],
        sans: ['Roboto', 'sans-serif'],
      },

    },

  },

  plugins: [],

}
