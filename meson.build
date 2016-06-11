project(
	'beamer-spbu',
	'c',
	version: '1.0',
	meson_version: '>=0.31'
)
latexmk = find_program('latexmk')
slidesfiles = [
	'example.tex',
	'beamerthemespbu.sty'
]
custom_target(
	'slides',
	input: slidesfiles,
	output: ['beamer-spbu.pdf'],
	command: [
		meson.source_root() + '/latexmk-with-env',
		meson.current_source_dir(),
		latexmk.path(),
		'-interaction=nonstopmode',
		'-output-directory=' + meson.build_root(),
		'-pdf',
		'-xelatex',
		'-bibtex',
		'-jobname=beamer-spbu',
#		'-r', meson.source_root() + '/latexmkrc',
		meson.current_source_dir() + '/example.tex'
	]
)
