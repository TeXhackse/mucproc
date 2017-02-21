BASE=mucproc_demo
TEX_FILES=${BASE}.tex ${BASE}.bib mucproc.cls mucfontsize10pt.clo
TEMP_FILES=${BASE}.aux ${BASE}.bbl ${BASE}.bbl ${BASE}.bcf ${BASE}.blg ${BASE}.log ${BASE}.out ${BASE}.run.xml ${BASE}.xmpdata pdfa.xmpi

all: ${BASE}.pdf
	okular ${BASE}.pdf

pdf: ${BASE}.pdf

${BASE}.pdf: pdflatex

lualatex: ${TEX_FILES}
	lualatex ${BASE}
	biber ${BASE}
	lualatex ${BASE}
	lualatex ${BASE}

xelatex: ${TEX_FILES}
	xelatex ${BASE}
	biber ${BASE}
	xelatex ${BASE}
	xelatex ${BASE}

pdflatex: ${TEX_FILES}
	while (pdflatex --synctex=1 ${BASE} ; \
		grep -q "Rerun to get cross" ${BASE}.log ) do true ; \
	done; 
	biber ${BASE}
	pdflatex ${BASE}
	pdflatex ${BASE}

clean: 
	-rm ${TEMP_FILES} ${BASE}.pdf
