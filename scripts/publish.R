library(reticulate)

source("scripts/lib/utils.R")

use_virtualenv("r-reticulate", required = TRUE)
source_python("scripts/lib/utils.py")

output <- jsonlite::read_json("datapackage.json")$resources[[1]]$path

res <- upload_resource(output, 
                       resource_id = "42fd644d-6a50-4539-a825-05b2460adfa0", 
                       url = "http://dados.mg.gov.br", 
                       key = Sys.getenv("DADOSMG_PROD"))

stopifnot(check_upload(file = output, url = res$url))
