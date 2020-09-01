#' accdb_to_csv
#'
#' @param accdb_file path to access database
#' @param output_dir directory to output the results
#' @param ... arguments to pass to fwrite
#'
#' @return vector of table names
#' @export
accdb_to_csv <- function(accdb_file, output_dir, ...) {
  jackcess_loc <- file.path(system.file('', package = 'accdbexport'), "jackcess-3.5.0.jar")
  logging_loc  <- file.path(system.file('', package = 'accdbexport'), "commons-logging-1.2.jar")
  common_loc   <- file.path(system.file('', package = 'accdbexport'), "commons-lang3-3.11.jar")

  rJava::.jinit()

  rJava::.jaddClassPath(jackcess_loc)
  rJava::.jaddClassPath(common_loc)
  rJava::.jaddClassPath(logging_loc)

  dbb     <- rJava::.jnew("com/healthmarketscience/jackcess/DatabaseBuilder")
  dbjfile <- rJava::.jnew('java/io/File', accdb_file)
  dbop    <- rJava::J(dbb, "open", dbjfile)


  db_tbls  <- rJava::J(dbop, "getTableNames")
  tbl_name <- rJava::J(db_tbls, "toString")
  tbl_name <- gsub("[", '', tbl_name, fixed = TRUE)
  tbl_name <- gsub("]", '', tbl_name, fixed = TRUE)
  tbl_name <- strsplit(tbl_name, ', ')[[1]]

  for(i in seq_along(tbl_name)) {

    do_export <- !rJava::J(dbop, "getTableMetaData", tbl_name[i])$isLinked()

    if(do_export) {

      tab <- rJava::J(dbop, "getTable", tbl_name[i])

      data.table::fwrite(data.table::fread(rJava::J(tab, "display")),
                         paste0(output_dir, tbl_name[i], '.gz'), ...)

    }
  }

  invisible(tbl_name)
}
