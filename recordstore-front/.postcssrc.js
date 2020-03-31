// https://github.com/michael-ciniawsky/postcss-load-config
/*const purgecss = require('@fullhuman/postcss-purgecss')({
	content: [
		'./src/components/*.vue'
	],
	defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || []
})
*/

module.exports = {
	plugins: {
		"postcss-import": {},
		"postcss-url": {},
		tailwindcss: {},
		// to edit target browsers: use "browserslist" field in package.json
		"autoprefixer": {}
		//cssnano: {},
		//purgecss: {},
	}

}
