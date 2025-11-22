SOURCE = cv
TARGET = $(SOURCE).pdf

LATEX_ENGINE = pdflatex

.PHONY: all build clean

all: build

build: $(TARGET)

$(TARGET): $(SOURCE).tex
	@echo "--- Running $(LATEX_ENGINE) Pass 1 (Generates initial PDF and .aux) ---"
	@$(LATEX_ENGINE) -shell-escape -halt-on-error $(SOURCE).tex

	@echo "--- Running $(LATEX_ENGINE) Pass 2 (Resolves references and TOC) ---"
	@$(LATEX_ENGINE) -shell-escape -halt-on-error $(SOURCE).tex
	@echo "--- Build successful: $(TARGET) ---"

clean:
	@echo "--- Cleaning up intermediate files ---"
	@rm -f *.aux *.log *.out *.toc *.nav *.snm *.dvi *.idx *.ind *.ilg *.bbl *.blg *.synctex.gz *.fls *.fdb_latexmk $(TARGET)
	@echo "--- Cleanup complete ---"

