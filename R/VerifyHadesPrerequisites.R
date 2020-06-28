# @file VerifyHadesPrerequisites
#
# Copyright 2020 Observational Health Data Sciences and Informatics
#
# This file is part of ROhdsiWebApi
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
# This is essentially a test script runs when the package is loaded.
# The purpose of this script is to test that Hades package system dependencies are met
# and produce helpful error messages if the system dependencies are not met.

# Checks depend on the system. Possible system configurations at the level of abstraction important for us are
# Windows with 64 bit R running and no other versions of R installed
# Windows OS with 32 bit R running and no other versions of R installed
# Windows running 64 bit R with 32 bit R installed
# Windows running 32 bit R with 64 bit R installed
# Mac OS (what else matters?)
# Linux (what else matters?)

# Since OHDSI tools run in secured environments this package will take the approach of identifying issues but not trying to fix them.
# Making system changes and installing software will be left to someone with admin privilages on the host machine.
# This package makes the assumption that the user does not have admin privilages on the host machine.


# A function that prints a formatted error message during package installation
installError <- function(header, ...) {
  paste0("\n\n",
      cli::style_bold("Error with Hades Prerequisites\n"),
      cli::rule(header), "\n",
      glue::glue(..., .sep = "\n"),
      "\n\n")
}

### Collect system information ###

# Determine the host operating system
osInfo <- tolower(paste(sessionInfo()$platform, sessionInfo()$running))
os <- stringr::str_extract(osInfo, "windows|mac|linux")
is64BitOs <- grepl("64", osInfo)

if(is.na(os)) {
  stop(installError("Operating system cannot be determined",
                    "Please create a new issue at https://github.com/ablack3/HadesPrerequisites/issues",
                    "and include the output of sessionInfo()"))
}

# Determine version of R that is currently running
is64BitR <- .Machine$sizeof.pointer == 8 # 8 Bytes is 64 bits
is32BitR <- .Machine$sizeof.pointer == 4 # 4 Bytes is 32 bits
# is64BitR <- grepl("64", Sys.info()[["machine"]])
# is32BitR <- grepl("32", Sys.info()[["machine"]])
if(!xor(is64BitR, is32BitR)) {
  stop(installError("R version (32 or 64 bit) cannot be determined",
                    "Please create a new issue at https://github.com/ablack3/HadesPrerequisites/issues",
                    "and include the output of Sys.info()[1:5] and .Machine$sizeof.pointer"))
}


### Begin tests ###
if(os == "windows") {

  # Test that java is installed
  tryCatch({
    invisible(system("java -version", intern = T)) # should this use system2? or shell()? What does system2 do with errors?
  }, error = function(e) {
    stop(installError("Java has not been installed properly",
                      "Please install the Java Development Kit",
                      "java -version should print the java version number.",
                      paste(e, collapse = "\n")))
  })


  # Test that the JAVA_HOME envirmonment variable is set if 32 bit R is in use
  if(is32BitR & Sys.getenv("JAVA_HOME") == "") {
    stop(installError("The JAVA_HOME environment variable has not been set.",
                      "Please create the JAVA_HOME environment variable."))
  }

  # Test that the JAVA_HOME envirmonment variable is not set if 64 bit R is in use
  # see https://stackoverflow.com/questions/7019912/using-the-rjava-package-on-win7-64-bit-with-r
  if(is64BitR & Sys.getenv("JAVA_HOME") != "") {
    stop(installError("The JAVA_HOME environment variable has been set.",
                      "When using 64 bit R and a recent version of rJava the JAVA_HOME environment variable should not be set.",
                      "Please delete the JAVA_HOME environment variable.",
                      "reference: https://stackoverflow.com/questions/7019912/using-the-rjava-package-on-win7-64-bit-with-r"))
  }

  # Test that if 32 or 64 bit R is installed then 32 or 64 bit Java is also installed
  RDirs <- list.files(dirname(R.home("bin")), include.dirs = TRUE)
  is64BitRInstalled <- any(grepl("64", RDirs))
  is32BitRInstalled <- any(grepl("32", RDirs))
  is64BitJavaInstalled <- dir.exists("C:/Program Files/Java")
  is32BitJavaInstalled <- dir.exists("C:/Program Files (x86)/Java")

  if(is64BitRInstalled & !is64BitJavaInstalled){
    stop(installError("Java and R versions don't match",
                       "It looks like you have 64 bit R installed but do not have 64 bit Java installed.",
                       "Next steps: Install the 64 bit Java development kit (JDK)"))
  }

  if(is32BitRInstalled & !is32BitJavaInstalled){
    stop(installError("Java and R versions don't match",
                       "It looks like you have 32 bit R installed but do not have 32 bit Java installed.",
                       "Even if you are not using 32 bit R but it is installed you need to install 32 bit Java",
                       "Next steps: Install the 32 bit Java development kit (JDK)"))
  }

  # Test that Rtools is installed
  if(!pkgbuild::has_build_tools()){
    stop(installError("R build tools are not installed",
                      "Hades needs R build tools to install packages from source.",
                      "Next steps: Download and install the Rtools for your system from https://cran.r-project.org/",
                      "Instructions can be found at http://jtleek.com/modules/01_DataScientistToolbox/02_10_rtools/"))
  }
}

if(os == "mac"){

}

if(os == "linux"){

}
