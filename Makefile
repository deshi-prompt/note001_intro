# Makefile for *.dot --> *.png

SUBDIRS := image

BUILD_DIR= build
SRC_DIR= src
TEMPLATE_DIR=`pwd`/template

#SRCS= $(wildcard src/*.md)
BODY_BASENAME= 2015_winter_body
AWORD_BASENAME= 2015_winter_afterword
BODY_SRC= ${SRC_DIR}/${BODY_BASENAME}.md
AWORD_SRC= ${SRC_DIR}/${AWORD_BASENAME}.md
SRCS= ${BODY_SRC} ${AWORD_SRC}
#TGT= $(basename $(SRCS)).png
PDF_TGT_= 2015winter.pdf
PDF_TGT= ${BUILD_DIR}/${PDF_TGT_}
TEX_TGTS= $(SRCS:.md=.tex)
TEX_TGTS2 = $(patsubst src/%.tex,${BUILD_DIR}/%.tex,$(TEX_TGTS))
TEX_FULL_TGT= $(basename ${PDF_TGT}).tex
HTML_TGT= index.html

PRE_PANDOC_CMD=./image2eps.sh
POST_PANDOC_CMD=./htbp2H.sh
CMD=./build.sh

.SUFFIXES:
.SUFFIXES: .md .tex .pdf .html

all: $(SUBDIRS) ${PDF_TGT}
tex: ${TEX_TGTS}
#tex2: ${TEX_TGTS2}
fulltex:${TEX_FULL_TGT}
pdf: $(SUBDIRS) ${PDF_TGT}
html: $(SUBDIRS) ${HTML_TGT}

.PHONY: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.md.tex:
	@${PRE_PANDOC_CMD} $< ${BUILD_DIR}/$(notdir $<) eps
	@pandoc -f markdown -t latex ${BUILD_DIR}/$(notdir $<) -o${BUILD_DIR}/$(notdir $@).tmp
	@${POST_PANDOC_CMD} ${BUILD_DIR}/$(notdir $@).tmp ${BUILD_DIR}/$(notdir $@)
	@rm ${BUILD_DIR}/$(notdir $<)
	@rm ${BUILD_DIR}/$(notdir $@).tmp

.tex.pdf:
	@platex -kanji=utf8 -output-directory=${BUILD_DIR} $<
	@dvipdf ${BUILD_DIR}/$(notdir $(basename $<)).dvi $@

${HTML_TGT}:${TEX_FULL_TGT}
	@pandoc -f latex -t html5 -c style/markdown.css $< -o${BUILD_DIR}/tmp
	@${PRE_PANDOC_CMD} ${BUILD_DIR}/tmp $@ PNG
	@rm -f ${BUILD_DIR}/tmp

${TEX_TGTS2}:${TEX_TGTS}
	@echo "$? --> $@"

${PDF_TGT}:${TEX_FULL_TGT}

${TEX_FULL_TGT}:${TEX_TGTS2}
	@echo "$? --> $@"
	@cat ${TEMPLATE_DIR}/tex_header.tex > $@
	@cat ${BUILD_DIR}/${BODY_BASENAME}.tex >> $@
	@cat ${TEMPLATE_DIR}/tex_bibitem.tex >> $@
	@cat ${BUILD_DIR}/${AWORD_BASENAME}.tex >> $@
	@cat ${TEMPLATE_DIR}/tex_hooter.tex >> $@

.PHONY: list
list:
	@echo sources : ${SRCS}
	@echo targets : ${PDF_TGT}
	@echo tex_targets : ${TEX_TGTS}
	@echo tex_targets2 : ${TEX_TGTS2}

.PHONY: show
show: ${PDF_TGT}
	@for TGT in ${PDF_TGT} ; do \
		evince $$TGT ; done

.PHONY: clean
clean: $(SUBDIRS)
	@rm -f ${TEX_TGTS2} ${TEX_FULL_TXT} ${PDF_TGT}

html: $(SUBDIRS)


