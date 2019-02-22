# Study URI
This is a working draft propsoal for creation, management, and use of Uniform Resource
Identifiers (URIs) for clinical trial identification. The work was inspired by the
PhUSE EUConnect18 paper "Study URI" [[Paper]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Papers/TT10-tt09-study-uri-19746.pdf) [[Presentation]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Presentations/TT10-tt09-study-uri-pub-19747.pdf) by Kerstin Forsberg
and Daniel Goude. These recommendations are under development and subject to change.

You may contribute to this project by branching the Github repository. Please
send comments and feedback by raising a Github issue.

[[Team Discussion of active questions]](StudyURI-questions.md)

## Problem Statement
The proposal addresses multiple challenges surrounding clinical trial identifiers. The concept
of a unique identifier for a clinical trials is not new, but implementations are inconsistent 
and subject to change over time. Challenges include:

* **Multiple repositories**

Information about trials is available in mutliple repsoitories including [ClinicalTrials.gov](https://clinicaltrials.gov/), [European Clinical Trials Database(EudraCT)](https://eudract.ema.europa.eu/), repositories for specific countries, and databases within pharmaceutical companies themselves.There is no consistent way to bring this information together for patients, researchers, or regulatory organizations.


* **Inconsisent synonyms**

Mutliple synonyms (codes, numbers, acronyms) are used for the same trial. For example: `D3562C00096`, `4522IL/0096`, `NCT00240331`, `2004-001741-15`and `AURORA` all refer to the same study. Data must be merged from different systems that use these acronyms, often relying in free text fields for study codes and acronyms.

* **Difficulty with Lookups**

Multiple, inconsistent acronyms and synonyms complicate obtaining information from 
public data request portals such as https://www.clinicalstudydatarequest.com
and https://astrazenecagroup-dt.pharmacm.com  Clinical studies are key entities
over time, as study data can be of renewed interest in collaborative research
projects years after the study was conducted. This is a challenge in a changing
pharmaceutical landscape where companies merge, and medical products are
divested and acquired. Meanwhile, the operating models within companies change,
systems are upgraded, information is migrated, and coding standards change. As a
result, multiple identifiers become associated with a single study. Some
identifiers are public, such as registry IDs and the identifiers assigned by
regulatory authorities. Others are internal, such as the codes and acronyms
used by sponsors. Some of the study codes are a consequence of different code
standards. Different code standards can be seen as a representation of the
history of the investigated medical product and of the sponsor company.

# ID Requirements

A clinical trial requires an identifier that satisifies the following criteria: 

* ID is unique to the trial 
* Easy to create and use
* Is machine-readable, without human-interpretable meaning (which is open to interperation and change)
* Does not change over time (stable, immutable) 
* Facilitates links to other online repositories as well as internal and external information about the study. 
* Links to human-interpretable identifiers and metadata
* Can be created before submission to a repository or governing authority, while ensuring it is unique to that study.


# Proposal
##URIs
[Uniform Resource Identifiers](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) (URIs) as [Resource Description Framework](https://en.wikipedia.org/wiki/Resource_Description_Framework) (RDF) is an ideal candidate for clinical trial identifiers. By definition, they unambiguously identify a resource (in this case, a clinical trial) and are a well-established [W3C standard](https://www.w3.org/wiki/URI).



The proposed study URI is composed of three components:  A **Namespace**, **Resource Type**, and the **UUID**.

Example: `http://RepoAuthority.org/clinicaltrial#e92971d5421dd4e83ed3e6f6bcc6cf0bd3538d2a`

Where:

* `RepoAuthority.org` is the **Namespace**
* `clinicaltrial#` is the **Resource Type**
* The string after the `#` is the **UUID** for the study.

*Note how URIs use the http scheme but this does not necessarily mean the data is available on the web! This type of identifier can be used in databases behind company firewalls and do not require http services to make use of the data.* 

##Namespace
Namespaces are subject to change over time and may represent different entities and use cases.

| Namespace | Description                                                     |
|-----------|-----------------------------------------------------------------|
| PharmaCo.com   | Publicly available information about the study at the "PharmaCo" company web site |
| PharmaCo.net   | Information available within the "PharmaCo" company firewall |
| RepoAuth.org   | Information at a specific repository (eg: clinicalTriials.gov, EudraCT, or others ) |


## Resource Type
We recommend the use of *clinicaltrial* for the resource type for clear identification of the resource type. 

## UUID
The UUID is the most critical component because it serves as the unique identifier. It must satisify the aforementioned ID Requirements listed above. 

We propose three possible methods of constructing the UUID. All methods use the fictional company "PharmaCo.""

### Method 1 : UUID Generators

#### 1 a)  Online UUID Generator
This method relies on an online UUID generator and has no dependency on the study title. Several online UUID generators are available and the one chosen here is for example purposes only. 

Example: `http://PharmaCo.com/clinicaltrial#2fff60b1-4d16-4721-adee-56a8563f5a92`


Steps:

1. Browse to the online UUID generator https://www.uuidgenerator.net/
2. Generate a UUID. 
 ![](images/UUIDGenerator.png)
3. Copy the UUID
`2fff60b1-4d16-4721-adee-56a8563f5a92`
4. Create the URI by concatenating the *Namespace*, *Resource type*, and *UUID*.
`http://PharmaCo.com/clinicaltrial#2fff60b1-4d16-4721-adee-56a8563f5a92`

Pros:  

* Ease of creation

Cons:  

* Not reproducible
* Cannot decode value back to original source
* Does not scale. This manual method is more labor-intensive than programmatic methods
* Susceptible to copy-paste errors.

#### 1 b)  Programmatic UUID Generator

This example uses the R package `uuid` to programatically create UUIDs. Other languages can be used in a similar fashion. Code concatenates the generated UUID with a specified *Namespace* and *Resource Type* to create a URI for study. The UUID is different each time the code is run. 

Example: `http://PharmaCo.com/clinicaltrial#3ddf3c44-36b9-11e9-a4c9-c9e469aa18e6`

Steps:

Create a program that:
1. Generates a UUID. 
2. Concatenates the *Namespace*, *Resource Type*, and *UUID*.

Example R Code:

```
# Create Study URI from rogrammatically generated UUID

library(uuid)

Namespace    <- 'PharmaCo.com'
resourceType <- 'clinicaltrial'

UUID <- UUIDgenerate()
UID

studyURI <- paste0("http://", Namespace, "/", resourceType, "#", UUID)
studyURI
```

Pros:  

* Ease of creation

* Scalable

Cons:  

* Not reproducible: A new UUID is generated each time the script is run.
* Cannot decode value back to original source


###Method 2: Hash of Study Title (+Datetime stamp)

This method creates an SHA-1 hash for the study title combined with the time stamp for when the hash is created. The time is entered manually for this example but could be captured automatically by the software at the exact time of creation and recorded along with the hash value. This example uses the R package `digest` to create the hash. Other languages can be used in a similar fashion.

Example Result

`http://PharmaCo.com/clinicaltrial#d7e0929abed16e739e67c0a26a1a036f76b0bc79`

Steps:

1.  Specify the study title:
`Safety and Efficacy of the Xanomeline Transdermal Therapeutic System (TTS) in Patients with Mild to Moderate Alzheimer's Disease`

2. Strip the study title of all spaces to remove potential variability of leading, trailing, and spaces within the title. 
`SafetyandEfficacyoftheXanomelineTransdermalTherapeuticSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease"`

3. Time stamp at creation of the UUID could be captured dynamically at run-time. For this example it is hard-coded in the scipt.
`2019-02-14T09:30:10`

4. Contentate the modified study title with the time stamp:
`SafetyandEfficacyoftheXanomelineTransdermalTherapeuticSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease2019-02-14T09:30:10`

5. Create an SHA-1 hash of the title+date:
`d7e0929abed16e739e67c0a26a1a036f76b0bc79`

6. Combine the hash value with the *Namespace* and *Resource Type*.

Example R Code
```
# Create Study URI from SHA-1 hash of study title

library(digest)

Namespace    <- 'PharmaCo.com'
resourceType <- 'clinicaltrial'

# 1
protocolTitle <-"Safety and Efficacy of the Xanomeline Transdermal Therapeutic System (TTS) in Patients with Mild to Moderate Alzheimer's Disease"

# 2
protocolTitle_nws <- gsub(" ","", protocolTitle)

# 3
hashTime <- '2019-02-14T09:30:10'

# 4
protocolTitleDate_nws <- paste0(protocolTitle_nws, hashTime)
# 5
UUID <- sha1(protocolTitleDate_nws)

# 6
studyURI <- paste0("http://", Namespace, "/", resourceType, "#", UUID)
studyURI
```

Pros:  
* Shorter UUID compared to the other metods
* Reproducible

Cons:  
* Not decodable back to orginal source


### Method 3: base64 Encoding of Study Title (+ time stamp) 
This method creates the UUID using base64 encoding the study title combined with the time stamp for when the encoding is created. The time is entered manually for this example but could be captured automatically by the software at the exact time of creation and recorded along with the hash value. The example uses the R package `RCurl` to create the hash. Other languages can be used in a similar fashion.

Steps:
1. Specify the study title:

`Safety and Efficacy of the Xanomeline Transdermal Therapeutic System (TTS) in Patients with Mild to Moderate Alzheimer's Disease`

2. Strip the study title of all spaces to remove potential variability of leading, trailing, and spaces within the title. 
`SafetyandEfficacyoftheXanomelineTransdermalTherapeuticSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease`

3. Time stamp at creation of the UUID could be captured dynamically at run-time. For this example it is hard-coded in the scipt. `2019-02-14T09:30:10`

4. Contentate the modified study title with the time stamp:

`SafetyandEfficacyoftheXanomelineTransdermalTherapeuticSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease2019-02-14T09:30:10`

5. Ceate the base64 encoding of the title+time stamp:

`U2FmZXR5YW5kRWZmaWNhY3lvZnRoZVhhbm9tZWxpbmVUcmFuc2Rlcm1hbFRoZXJhcGV1dGljClN5c3RlbShUVFMpaW5QYXRpZW50c3dpdGhNaWxkdG9Nb2RlcmF0ZUFsemhlaW1lcidzRGlzZWFzZTIwMTktMDItMTRUMDk6MzA6MTA=`

6. Combine the hash value with the *Namespace* and *Resource Type*:


7. Test Decoding back to the value used for the encoding.

`SafetyandEfficacyoftheXanomelineTransdermalTherapeuticSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease2019-02-14T09:30:10`


```
# Create Study URI from 64encode of study title

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
```

Pros:  

* Can be decoded back to original source
* Reproducible
* Scalable

Cons:  

* Long UUID


## Recommended Predicates
*Section under development.*

| Predicate            | Object Description   |
| ---------------------|:-------------:|
| hasEudraCTID         | EudraCT ID number.  | 
| hasNCTID             | ClinicalTrials.gov ID (NCT number)   |
| hasUUID              | UUID used to form Study URI 
| hasUUIDCreateDate    | Date UUID created
| hasUUIDCreateMethod  | Method used to generate UUID
| hasCompanyID         | Company identifiers  |
| hasCompanyAcronym    | Company acronyms |


## Examples
*Section to be developed*

## Use Cases
*Section to be developed*

## Governance
A central organization is needed to create study URIs, ensure their uniqueness, and make them available. A logical choice would be [ClinicalTrials.gov](https://clinicaltrials.gov). They could be approached when the idea is more developed. 

## References
[Cool URIs for the Semantic Web](https://www.w3.org/TR/cooluris/)
Study URI" [[Paper]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Papers/TT10-tt09-study-uri-19746.pdf) [[Presentation]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Presentations/TT10-tt09-study-uri-pub-19747.pdf)

"Study URI" [[Paper]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Papers/TT10-tt09-study-uri-19746.pdf) [[Presentation]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Presentations/TT10-tt09-study-uri-pub-19747.pdf)

## Contributors
    - Kerstin Forsberg (AstraZeneca)
    - Daniel Goude (AstraZeneca)
    - Nolan Nichols (Genentech)
    - Johannes Ulander (A3 Informatics)
    - Tim Williams (UCB Biosciences)
