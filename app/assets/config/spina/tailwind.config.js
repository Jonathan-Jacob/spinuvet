module.exports = {
  content: [
    '/Users/jonathan/code/Jonathan-Jacob/SpinaJJ/app/views/**/*.*',
'/Users/jonathan/code/Jonathan-Jacob/SpinaJJ/app/components/**/*.*',
'/Users/jonathan/code/Jonathan-Jacob/SpinaJJ/app/helpers/**/*.*',
'/Users/jonathan/code/Jonathan-Jacob/SpinaJJ/app/assets/javascripts/**/*.js',
'/Users/jonathan/code/Jonathan-Jacob/SpinaJJ/app/**/application.tailwind.css'
  ],
  theme: {
    fontFamily: {
      body: ['Metropolis'],
      mono: ['ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', "Liberation Mono", "Courier New", 'monospace']
    },
    extend: {
      colors: {
        spina: {
          light: '#123142',
          DEFAULT: '#a73f44',
          dark: '#9b2d32'
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
	require('@tailwindcss/aspect-ratio'),
	require('@tailwindcss/typography')
  ]
}
