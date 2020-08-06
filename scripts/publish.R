source("scripts/lib/utils.R")

output <- jsonlite::read_json("datapackage.json")$resources[[1]]$path

res <- ckanr::resource_update(id = "43570463-76a2-407e-89f9-4bfd10638354",
                       path = output, 
                       url = "http://dados.mg.gov.br", 
                       key = Sys.getenv("DADOSMG_PROD"))

stopifnot(check_upload(file = output, url = res$url))
