# Makefile for *.png *.jpg *.PNG *.JPG --> *.eps *.png

FILES= $(wildcard section*/*)
EPS_SRCS= $(filter-out %.eps, ${FILES})
PNG_SRCS= $(filter-out %.eps, ${FILES})
EPS_TGTS= $(addsuffix .eps, $(basename ${EPS_SRCS}))
PNG_TGTS= $(addsuffix .PNG, $(basename ${PNG_SRCS}))

CONVERT=convert -density 300 -resize 960
CONVERT2=convert -density 300 -resize 480

.SUFFIXES:
.SUFFIXES: .png .jpg .PNG .JPG .eps

.png.PNG:
	@${CONVERT2} $< $@
.jpg.PNG:
	@${CONVERT2} $< $@
.JPG.PNG:
	@${CONVERT2} $< $@

.png.eps:
	@${CONVERT} $< $@
.jpg.eps:
	@${CONVERT} $< $@
.JPG.eps:
	@${CONVERT} $< $@

all:${EPS_TGTS}

html:${PNG_TGTS}

.PHONY: list
list:
	@echo sources eps : ${EPS_SRCS}
	@echo targets eps : ${EPS_TGTS}
	@echo sources PNG : ${PNG_SRCS}
	@echo targets PNG : ${PNG_TGTS}

.PHONY: clean
clean:
	@rm -f ${EPS_TGTS} ${PNG_TGTS}


