project(
	'SaintPetersburg',
	'c',
	version: '1.0',
	meson_version: '>=0.31'
)
project_name = 'SaintPetersburg'
latexmk = find_program('latexmk')
slidesfiles = [
	'example.tex',
	'beamerthemeSaintPetersburg.sty'
]
custom_target(
	'slides',
	input: slidesfiles,
	output: ['SaintPetersburg.pdf'],
	command: [
		meson.source_root() + '/scripts/latexmk-with-env',
		meson.current_source_dir(),
		latexmk.path(),
		'-interaction=nonstopmode',
		'-output-directory=' + meson.build_root(),
		'-pdf',
		'-xelatex',
		'-bibtex',
		'-jobname=SaintPetersburg',
		meson.current_source_dir() + '/example.tex'
	]
)

# install file to TEXMFLOCAL directory tree
kpsewhich = find_program('kpsewhich')
texmf_local_dir = run_command([kpsewhich.path(), '--var-value', 'TEXMFLOCAL']).stdout().strip()
install_data(
	sources: [
		'beamerthemeSaintPetersburg.sty',
		'eps/spbu-block-ru.eps',
		'eps/spbu-block-en.eps',
		'eps/spbu-CoA.eps'
	],
	install_dir: texmf_local_dir + '/tex/latex/' + project_name
)

run_target('ctanify', 'scripts/ctanify')
