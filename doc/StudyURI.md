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

Information about trials is available in mutliple repsoitories including [[ClinicalTrials.gov]]](https://clinicaltrials.gov/),  [[European Clinical Trials Database(EudraCT)]](https://eudract.ema.europa.eu/), repositories for specific countries, and databases within pharmaceutical companies themselves.There is no consistent way to bring this information together for patients, researchers, or regulatory organizations.


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
[Uniform Resource Identifiers](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) (URIs) as [Resource Description Framework](https://en.wikipedia.org/wiki/Resource_Description_Framework) (RDF) is an ideal candidate for clinical study  identifiers. By definition, they unambiguously identify a resource (in this case, a clinical study) and are a well-established [W3C standard](https://www.w3.org/wiki/URI).



The proposed study URI is composed of three components:  A **Namespace**, **Resource Type**, and the **UUID**.

Example:

`http://RepoAuthority.org/clinicaltrial#e92971d5421dd4e83ed3e6f6bcc6cf0bd3538d2a`

Where:

* RepoAuthority.org is the **Namespace**
* clinicaltrial# is the **Resource Type**
* The string after the # is the **UUID** for the study.

*Note how URIs use the http scheme but this does not necessarily mean the data is available on the web! This type of identifier can be used in databases behind company firewalls and do not require http services to make use of the data.* 

##Namespace
Namespaces are subject to change over time and may represent different entities and use cases.

| Namespace | Description                                                     |
|-----------|-----------------------------------------------------------------|
| PharmaCo.com   | Publicly available information about the study at the company web site |
| PharmaCo.net   | Information available within the company firewall |
| RepoAuth.org   | information at a specific repository (eg: clinicalTriials.gov or EudraCT ) |


##Resource Type
We recommend the use of *clinicaltrial* for the resource type for clear identification of the resource type. 

##UUID
The UUID is the most critical component because it serves as the unique identifier. It must satisify the ID Requirements listed above. 

We propose three possible methods of constructing the UUID. All examples use the title of a study donated to the PhUSE organization.

###Method 1 : Online UUID Generator

An online UUID generator is used and there is no dependency on the study title. Several online UUID generators are available and the one chosen here is for example purposes only. A generator will be recommended at a later time.



*TODO: Add Instructions and example*


Pros:  
* Ease of creation
Cons:  
* Not reproducible
* Not decodable back to original source


###Method 2: Hash of Study Title (+Datetime stamp)

This method creates an SHA-1 hash for the study title + datetime stamp for when the hash is created. The time is entered manually for this example but could be captured automatically by the software at the exact time of creation and recorded along with the hash value.

Steps:

1.  Original Study title:
`Safety and Efficacy of the Xanomeline Transdermal Therapeutic System (TTS) in Patients with Mild to Moderate Alzheimer's Disease`

2. Study title is stripped of all spaces to remove potential variability. 
`SafetyandEfficacyoftheXanomelineTransdermalTherapeuticSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease"`

3. DateTime at creation of the UUID:
`2019-02-14T09:30:10`

4. Study title appended with date:
`SafetyandEfficacyoftheXanomelineTransdermalTherapeuticSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease2019-02-14T09:30:10`
5. SHA-1 hash of the title+date:
`d7e0929abed16e739e67c0a26a1a036f76b0bc79`

R Code for steps 1 through 5:
```
library(digest)

protocolTitle <-"Safety and Efficacy of the Xanomeline Transdermal Therapeutic System (TTS) in Patients with Mild to Moderate Alzheimer's Disease"

protocolTitle_nws <- gsub(" ","", protocolTitle)

hashTime <- '2019-02-14T09:30:10'

protocolTitleDate_nws <- paste0(protocolTitle_nws, hashTime)

studyURIHash <- sha1(protocolTitleDate_nws)

studyURIHash
```

Pros:  
* Shorter UUID compared to the other metods
* Reproducible

Cons:  
* Not decodable back to orginal source


###Method 3: Encoding (base64) of Study Title (+Datetime stamp) 

Original:

`Safety and Efficacy of the Xanomeline Transdermal Therapeutic System (TTS) in Patients with Mild to Moderate Alzheimer's Disease`

Value to encode

`SafetyandEfficacyoftheXanomelineTransdermalTherapeutic\nSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease2019-02-1`

base64 encoded:

`U2FmZXR5YW5kRWZmaWNhY3lvZnRoZVhhbm9tZWxpbmVUcmFuc2Rlcm1hbFRoZXJhcGV1dGljClN5c3RlbShUVFMpaW5QYXRpZW50c3dpdGhNaWxkdG9Nb2RlcmF0ZUFsemhlaW1lcidzRGlzZWFzZTIwMTktMDItMTQ=`

Decoded:
`SafetyandEfficacyoftheXanomelineTransdermalTherapeutic\nSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease2019-02-1`


```
library(RCurl)

protocolTitle <-"Safety and Efficacy of the Xanomeline Transdermal Therapeutic 
  System (TTS) in Patients with Mild to Moderate Alzheimer's Disease"

protocolTitle_nws <- gsub(" ","", protocolTitle)

dateToday <- '2019-02-14'

protocolTitleDate_nws <- paste0(protocolTitle_nws, dateToday)

protocolTitleDate_nws 

# Encode a UUID 
dev_UUID <- base64(protocolTitleDate_nws)
dev_UUID

decoded_UUID <- base64Decode(dev_UUID)
decoded_UUID
```


Pros:  
* Can be decoded back to original source
* Reproducible

Cons:  
* Long UUID




**OLD DRAFT TEXT BELOW HERE. CLEAN IT UP!**


The following triples tie the information together:

```
https://RepoAuthority.org/clinicaltrial#e92971d5421dd4e83ed3e6f6bcc6cf0bd3538d2a
   eg:hasUUID         "e92971d5421dd4e83ed3e6f6bcc6cf0bd3538d2a"^^xsd:string;
   eg:hasCompanyIntURI  https://data.abcPharma.com/clinicaltrial/ALZ-XAN-0005 ;
   eg:hasCompanyExtURI  https://data.abcPharma.net/clinicaltrial/ALZ-XAN-0005 ;
.
```

## Recommended Predicates
TODO: Develop a list of recommended predicates.

| Predicate     | Description   |
| ------------- |:-------------:|
| hasNCTID      |  |
| hasCompanyID  |  |
| hasAcronym    |  |
| hasEuroCTID   |  | 

(To Add: prefLabel, description, recommended/mandatory/optional,  etc.)

## Examples


## Use Cases
(Advantages, linking to other information. May link to separate pages)

## Governance
A central organization is needed to create study URIs, ensure their uniqueness, and make them available. A logical choice would be [[ClinicalTrials.gov]](https://clinicaltrials.gov). They could be approached when the idea is more developed. 

## References
[Cool URIs for the Semantic Web](https://www.w3.org/TR/cooluris/)
Study URI" [[Paper]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Papers/TT10-tt09-study-uri-19746.pdf) [[Presentation]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Presentations/TT10-tt09-study-uri-pub-19747.pdf)

## Contributors
    - Kerstin Forsberg (AstraZeneca)
    - Daniel Goude (AstraZeneca)
    - Nolan Nichols (Genentech)
    - Johannes Ulander (A3 Informatics)
    - Tim Williams (UCB Biosciences)
