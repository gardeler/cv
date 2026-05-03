.PHONY: examples private-cv

TEX_ENGINE ?= /usr/local/texlive/2026/bin/universal-darwin/lualatex
EXAMPLES_DIR = examples
RESUME_DIR = examples/resume
CV_DIR = examples/cv
PRIVATE_DIR = private
TEXMFVAR ?= /private/tmp/codex-texmf-var
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')
PRIVATE_CV_SRCS = $(shell find $(PRIVATE_DIR)/cv -name '*.tex')

examples: $(foreach x, coverletter cv resume, $x.pdf)

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	$(TEX_ENGINE) -output-directory=$(EXAMPLES_DIR) $<

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	$(TEX_ENGINE) -output-directory=$(EXAMPLES_DIR) $<

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	$(TEX_ENGINE) -output-directory=$(EXAMPLES_DIR) $<

private-cv: $(PRIVATE_DIR)/cv.pdf

$(PRIVATE_DIR)/cv.pdf: $(PRIVATE_DIR)/cv.tex $(PRIVATE_CV_SRCS) awesome-cv.cls awesome-cv-custom.sty
	mkdir -p $(TEXMFVAR)
	cd $(PRIVATE_DIR) && TEXMFVAR=$(TEXMFVAR) TEXINPUTS=.:..//: $(TEX_ENGINE) -interaction=nonstopmode -halt-on-error cv.tex

clean:
	rm -rf $(EXAMPLES_DIR)/*.pdf
