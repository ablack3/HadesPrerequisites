# This script runs when the package is loaded.
# Since R packages are loaded as part of the installation process this script will run when the package is installed.


# sessioninfo::os_name()
# sessioninfo::platform_info()
# is_windows <- grepl("Windows", sessioninfo::os_name(), ignore.case = T)
# is_mac <- grepl("Mac", sessioninfo::os_name(), ignore.case = T)
# is_linux <- grepl("Linux", sessionInfo()$platform, ignore.case = T)
# is_64bit_os <- grepl("64", sessionInfo()$platform)


# check that the OS is Windows, Mac, or Linux

install_error <- function(header, ...){
  paste0("\n\n",
      cli::style_bold("Error with Hades Prerequisites\n"),
      cli::rule(header), "\n",
      glue::glue(..., .sep = "\n"),
      "\n\n")
  # "Error with Hades Pre"
}

# make sure we can determine the host operating system since checks are OS specific
if(!grepl("windows|Mac|Linux", sessioninfo::os_name(), ignore.case = T)){
  stop(install_error("Operating system cannot be determined", "Are you on Windows, Mac, or Linux? \n<insert next steps>"))
}


# determine which versions of Java and R are installed (might need to check multiple directories)
if(grepl("windows", sessioninfo::os_name(), ignore.case = T)){
  is_64_bit_R_installed <- dir.exists("C:/Program Files/R")
  is_32_bit_R_installed <- dir.exists("C:/Program Files (x86)/R")
  is_64_bit_java_installed <- dir.exists("C:/Program Files/Java")
  is_32_bit_java_installed <- dir.exists("C:/Program Files (x86)/Java")
}

# same for Linux
# if(grepl("Linux", sessioninfo::os_name(), ignore.case = T)){
#   is_64_bit_R_installed <- dir.exists("C:/Program Files/R")
#   is_32_bit_R_installed <- dir.exists("C:/Program Files (x86)/R")
#   is_64_bit_java_installed <- dir.exists("C:/Program Files/Java")
#   is_32_bit_java_installed <- dir.exists("C:/Program Files (x86)/Java")
# }

# same for mac
# if(grepl("Mac", sessioninfo::os_name(), ignore.case = T)){
#   is_64_bit_R_installed <- dir.exists("C:/Program Files/R")
#   is_32_bit_R_installed <- dir.exists("C:/Program Files (x86)/R")
#   is_64_bit_java_installed <- dir.exists("C:/Program Files/Java")
#   is_32_bit_java_installed <- dir.exists("C:/Program Files (x86)/Java")
# }


# Check that Java and R versions match
if(is_64_bit_R_installed & !is_64_bit_java_installed){
  stop(install_error("Java and R versions don't match",
                     "It looks like you have 64 bit R installed but do not have 64 bit Java installed.",
                     "Next steps: Install the 64 bit Java development kit (JDK)"))
}

if(is_32_bit_R_installed & !is_32_bit_java_installed){
  stop(install_error("Java and R versions don't match",
                     "It looks like you have 32 bit R installed but do not have 32 bit Java installed.",
                     "Even if you are not using 32 bit R but it is installed you need to install 32 bit Java",
                     "Next steps: Install the 32 bit Java development kit (JDK)"))
}


# test Java with some Java commands that are commonly used in Hades
# to be done


# check that Rtools is installed
if(!pkgbuild::has_build_tools()){
  # Should this be different for linux
  stop(install_error("R build tools are not installed",
                     "Hades needs R build tools to install packages from source.",
                     "Next steps: Download and install the Rtools for your system from https://cran.r-project.org/"))
}


# check the version of C complier installed
# Just want to make sure we can compile xgboost for the PLP package

# anyway you get the idea...


