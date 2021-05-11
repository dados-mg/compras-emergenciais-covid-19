.PHONY: help all clean sync build publish

#====================================================================
# PHONY TARGETS

help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

all: clean check sync publish # Limpeza, upload e sincronizacao git

clean: data/compras-emergenciais-covid-19.csv ## Limpeza data-raw/ para data/

data/compras-emergenciais-covid-19.csv: scripts/clean.R scripts/lib/utils.R data-raw/compras-coronavirus.xlsx data-raw/compras-coronavirus-controle.csv
	@Rscript --verbose $< 2> logs/log.Rout

build: ## Compilação datapackage.json para buid/
	@Rscript --verbose scripts/build.R 2> logs/log.Rout

sync: ## Stage, commit e push das alterações
	git add -u
	git commit -m "Atualiza conjunto de dados"
	git push origin master

publish: ## Upload data/ para dados.mg.gov.br/
	@Rscript --verbose scripts/publish.R 2> logs/log.Rout

check: ## Executa conferência
	@Rscript --verbose scripts/check.R 2> logs/log.Rout
