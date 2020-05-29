# @file PackageMaintenance
#
# Copyright 2020 Observational Health Data Sciences and Informatics
#
# This file is part of SelfControlledCaseSeries
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


# create the DESCRIPTION file
usethis::use_description(fields = list(Package = "HadesPrerequisites",
                                       Title = "Check for system dependecies required by the OHDSI R packages",
                                       Version =  "0.1.0",
                                       `Authors@R` = 'person("Adam", "Black", email = "adam.black@odysseusinc.com", role = c("aut", "cre"))',
                                       Description = "HADES (formally known as the OHDSI Methods Library) is a set of open source R packages for large scale analytics,
      including population characterization, population-level causal effect estimation, and patient-level prediction.
      HadesPrerequisites is a simple packages that checks system prerequisites needed to successfully install HADES.
      If HadesPrerequisites installs successfully then the user should be confident that the rest of the OHDSI R packages will also install and load successfully.
      Learn more at <https://ohdsi.github.io/Hades/>.",
                                       URL = "https://ohdsi.github.io/Hades",
                                       Depends = "R (>= 3.2)"))


usethis::use_package("devtools")
usethis::use_package("rJava")
usethis::use_apl2_license("Observational Health Data Sciences and Informatics")

