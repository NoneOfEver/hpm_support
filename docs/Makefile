# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
EN            = source/en
ZH            = source/zh
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile clean

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(EN)" "$(BUILDDIR)/en" $(SPHINXOPTS) $(O)
	@$(SPHINXBUILD) -M $@ "$(ZH)" "$(BUILDDIR)/zh" $(SPHINXOPTS) $(O)

# Enhanced clean target
clean:
	@echo "Cleaning Sphinx build directories..."
	@$(SPHINXBUILD) -M clean "$(EN)" "$(BUILDDIR)/en" $(SPHINXOPTS) $(O)
	@$(SPHINXBUILD) -M clean "$(ZH)" "$(BUILDDIR)/zh" $(SPHINXOPTS) $(O)
	@echo "Removing build directory..."
	@rm -rf $(BUILDDIR)
	@echo "Removing samples directories..."
	@rm -rf $(ZH)/samples
	@rm -rf $(EN)/samples
	@echo "Cleaning snippets directories (keeping verified_samples files)..."
	@find $(ZH)/snippets -mindepth 1 ! -name 'verified_samples_zh.rst' -type f -delete
	@find $(ZH)/snippets -mindepth 1 ! -name 'verified_samples_zh.rst' -type d -exec rm -rf {} + 2>/dev/null || true
	@find $(EN)/snippets -mindepth 1 ! -name 'verified_samples_en.rst' -type f -delete
	@find $(EN)/snippets -mindepth 1 ! -name 'verified_samples_en.rst' -type d -exec rm -rf {} + 2>/dev/null || true
	@echo "Clean completed."
