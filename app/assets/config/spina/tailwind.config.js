module.exports = {
  content: [
    '/Users/jonathan/code/Jonathan-Jacob/spinuvet/app/views/**/*.*',
'/Users/jonathan/code/Jonathan-Jacob/spinuvet/app/components/**/*.*',
'/Users/jonathan/code/Jonathan-Jacob/spinuvet/app/helpers/**/*.*',
'/Users/jonathan/code/Jonathan-Jacob/spinuvet/app/assets/javascripts/**/*.js',
'/Users/jonathan/code/Jonathan-Jacob/spinuvet/app/**/application.tailwind.css'
  ],
  theme: {
    fontFamily: {
      body: ['Metropolis'],
      mono: ['ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', "Liberation Mono", "Courier New", 'monospace']
    },
    extend: {
      colors: {
        spina: {
          light: '#58990f',
          DEFAULT: '#78b41b',
          dark: '#306e01'
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
