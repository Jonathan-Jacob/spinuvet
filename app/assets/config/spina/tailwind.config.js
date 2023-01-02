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
          light: '#92de21',
          DEFAULT: '#78b41b',
          dark: '#58990f'
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
