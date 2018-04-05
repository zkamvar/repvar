README.md : README.Rmd
	-R -q -e "rmarkdown::render('$<')"

build :
	R CMD INSTALL --preclean --no-multiarch --with-keep.source --install-tests .

test : doc build
	R -q -e "devtools::test()"

doc :
	R -q -e "devtools::document()"

check : doc build
	R -q -e "devtools::check()"

html : build README.md
	R -q -e "pkgdown::build_site()"
