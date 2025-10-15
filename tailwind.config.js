/** @type {import('tailwindcss').Config} */
export default {
  darkMode: 'class', // Enable dark mode based on the 'dark' class
  content: [
    './index.html',
    './src/**/*.{svelte,js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}