README.md : README.Rmd
	-R -q -e "rmarkdown::render('$<')"

build :
	cd ../ \
	R CMD INSTALL --preclean --no-multiarch --with-keep.source --install-tests repvar

test : doc build
	R -q -e "devtools::test()"

doc :
	R -q -e "devtools::document()"

check : doc build
	R -q -e "devtools::check()"
