#!/bin/sh
pandoc -s -o output.md ./README.md ./DC.md ./Background.md ./Security-SharedConcern.md ./Strategy-MIM.md ./Implementations.md ./azure-key-vault-strategy-mim.md ./acm-strategy-mim.md ./hashicorp-vault-strategy-mim.md ./k8s-strategy-mim.md ./iac-strategy-mim.md ./Summary.md
pandoc -s -o output.docx output.md --lua-filter=pagebreak.lua
pandoc -s -o strategy-mim-devops-cloud-paper.pdf output.md --lua-filter=pagebreak.lua -V geometry:margin=0.5in