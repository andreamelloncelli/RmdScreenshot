
#
import_screenshot <- function() {
	rmd_path  <- rstudioapi::getActiveDocumentContext()$path
	image_name <- take_screenshot(rmd_path)
  link <- paste0( "![](", image_name, ")" )
  ####
  rstudioapi::insertText(link)
}

take_screenshot <- function(rmd_path) {
	if (!all(grepl(pattern = ".*\\.Rmd", rmd_path))) stop("This function works only in a .Rmd buffer")
	rmd_name <-   gsub(pattern = "\\.Rmd$", "", basename(rmd_path) )
	image_dir <- 	paste0( dirname(rmd_path), "/", rmd_name, "_files" )
  system( paste0("mkdir -p ", image_dir) )
	image_name <- get_image_name(image_dir)
	command <- paste0(	"import ", image_name )
	message(command)
	system_out <-
		system(
			command,
			intern = TRUE
		)
	if  ( !is.null( attr(system_out, "status") ) ) {stop("import command failed on file ", image_name)}
	image_name
}

get_image_name <- function(dir) {
	tempfile(pattern =  "image_", tmpdir = dir,fileext = ".png")
}

