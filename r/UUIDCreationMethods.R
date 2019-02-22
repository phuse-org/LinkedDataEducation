# Programmatic UUID method
library(uuid)

Namespace    <- 'PharmaCo.com'
resourceType <- 'clinicaltrial'

UUID <- UUIDgenerate()
UID

studyURI <- paste0("http://", Namespace, "/", resourceType, "#", UUID)
studyURI


# Hash Method

library(digest)

Namespace    <- 'PharmaCo.com'
resourceType <- 'clinicaltrial'

# 1
protocolTitle <-"Safety and Efficacy of the Xanomeline Transdermal Therapeutic System (TTS) in Patients with Mild to Moderate Alzheimer's Disease"

# 2
protocolTitle_nws <- gsub(" ","", protocolTitle)

# 3
uuidTime <- '2019-02-14T09:30:10'

# 4
protocolTitleDate_nws <- paste0(protocolTitle_nws, uuidTime)
# 5
UUID <- sha1(protocolTitleDate_nws)

# 6
studyURI <- paste0("http://", Namespace, "/", resourceType, "#", UUID)
studyURI

# base64 Method

library(RCurl)

Namespace    <- 'PharmaCo.com'
resourceType <- 'clinicaltrial'

# 1
protocolTitle <-"Safety and Efficacy of the Xanomeline Transdermal Therapeutic 
  System (TTS) in Patients with Mild to Moderate Alzheimer's Disease"

# 2
protocolTitle_nws <- gsub(" ","", protocolTitle)

# 3
uuidTime <- '2019-02-14T09:30:10'

#4 
protocolTitleDate_nws <- paste0(protocolTitle_nws, uuidTime)

# 5 
UUID <- base64(protocolTitleDate_nws)

# 6
studyURI <- paste0("http://", Namespace, "/", resourceType, "#", UUID)
studyURI

# 7 
decoded_UUID <- base64Decode(UUID)
decoded_UUID
