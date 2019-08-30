(use-modules
  (guix)
  (guix packages)
  (guix build-system trivial)
  ((guix licenses) #:prefix license:)
  (gnu packages base))

(package
  (name "texlive-beamertheme-saintpetersburg")
  (version "2019-02-11")
  (source (directory-union "source" (list (getcwd))))
  (build-system trivial-build-system)
  (arguments
    `(#:modules ((guix build utils))
      #:builder
      (begin
        (use-modules (guix build utils) (srfi srfi-26))
        (let*
          ((src (assoc-ref %build-inputs "source"))
           (out (assoc-ref %outputs "out"))
           (name "beamertheme-saintpetersburg")
           (tex (string-append out "/share/texmf-local/tex/latex/" name))
           (source (string-append out "/share/texmf-local/source/latex/" name))
           (doc (string-append out "/share/texmf-local/doc/latex/" name))
           (make (string-append (assoc-ref %build-inputs "make") "/bin/make")))
          (mkdir-p tex)
          (mkdir-p source)
          (mkdir-p doc)
          (chdir src)
          (invoke make)
          (chdir (string-append src "/build"))
          (for-each
            (cut install-file <> tex)
            '("beamerthemeSaintPetersburg.sty"
              "beamerfontthemeSaintPetersburg.sty"
              "beamercolorthemeSaintPetersburg.sty"))
          (for-each (cut install-file <> doc) '("SaintPetersburg.pdf"))
          (chdir (string-append src "/src"))
          (for-each
            (cut install-file <> source)
            '("beamerfontthemeSaintPetersburg.dtx"
              "SaintPetersburg.dtx"
              "beamerthemeSaintPetersburg.dtx"
              "beamercolorthemeSaintPetersburg.dtx"
              "SaintPetersburg.ins"))
          #t))))
  (native-inputs `(("make" ,gnu-make)))
  (synopsis "LaTeX/XeLaTeX Beamer theme for SPbU")
  (description "LaTeX/XeLaTeX Beamer theme for SPbU")
  (home-page "https://github.com/igankevich/SaintPetersburg")
  (license license:lppl1.3c+))
