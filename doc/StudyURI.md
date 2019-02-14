# Study URI
This is a working draft propsoal for creation, management, and use of Uniform Resource
Identifiers (URIs) for clinical trial identification. The work was inspired by the
PhUSE EUConnect18 paper "Study URI" [[Paper]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Papers/TT10-tt09-study-uri-19746.pdf) [[Presentation]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Presentations/TT10-tt09-study-uri-pub-19747.pdf) by Kerstin Forsberg
and Daniel Goude, with follow up discussions including Johannes Ulander and
Tim Williams. These recommendations are under development and subject to change.

You may contribute to this project by branching the Github repository. Please
send comments and feedback by raising a Github issue.

[[Discussion of active questions]](StudyURI-questions.md)


## Problem Statement
The proposal addresses multiple challenges surrounding clinical trial identifiers. The concept
of a unique identifier for a clinical trials is not new, but implementations are inconsistent 
and subject to change over time. 

* Multiple repositories
Information about trials is available in mutliiple repsoitories [TODO: ADD links]. There is no
consistent way to bring this information together.


* Inconsisent synonyms
Mutliple synonyms (codes, numbers, acronyms) are used for the same trial. For example: `D3562C00096`, `4522IL/0096`, `NCT00240331`, `2004-001741-15`and `AURORA` all refer to the same study. Data must be 
merged from different systems that use these acronyms, often relying in free text fields for study codes and acronyms.

* Difficulty with Lookups
Multiple, inconsistent acronyms and synonyms complicate obtaining information from 
public data request portals such as https://www.clinicalstudydatarequest.com
and https://astrazenecagroup-dt.pharmacm.com  Clinical studies are key entities
over time, as study data can be of renewed interest in collaborative research
projects years after the study was conducted. This is a challenge in a changing
pharmaceutical landscape where companies merge, and medical products are
divested and acquired. Meanwhile the operating models within companies change,
systems are upgraded, information is migrated, and code standards change. As a
result, studies have multiple identifiers associated with them. Some
identifiers are public, such as registry IDs and the identifiers assigned by
regulatory authorities. Others are internal, such as the codes and acronyms
used by sponsors. Some of the study codes are a consequence of different code
standards. Different code standards can be seen as a representation of the
history of the investigated medical product and of the sponsor company.

[TODO: Are there concepts to be used from CoolURIs, or is it misleading]
https://www.w3.org/TR/cooluris/

# Proposed Solution
* A single identifier for a study that does not change over time and serves as a link between
various online repositories, internal and external information about the study. 
This single identifier:
* Provides the basis for linking to existing identifiers in  online and internal systems.
* Is immutable
* Is machine-readable, without human-interpretable meaning (which is open to interperation and change)
* Links to human-interpretable identifiers and metadata

# Proposed Structure

## Parent URI
The URI contains an unique, machine readable value (UUID) that is stable over time. It can be recreated based on known data fed into the hashing algorithm (ie, it is not a randomly generated UUID or UUID based on a changing timestamp). The known date is the title on the study protocol (on the date that the UUID is generated) and the date in format YYYY-MM-DD.

## Create the Study UUID
This example uses a study donated to the PhUSE organization. The study title is strippled of all white space, combined with the date the UUID is created, and hashed using the SHA1 algorithm. Spaces are removed due to potential variability in leading and trailing whitespace as well as inconsistent spacing between words. 

1.  Study title:
`Safety and Efficacy of the Xanomeline Transdermal Therapeutic System (TTS) in Patients with Mild to Moderate Alzheimer's Disease`

2. Study title with no spaces:
`SafetyandEfficacyoftheXanomelineTransdermalTherapeutic\nSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease"`

3. Todays date in YYYY-MM-DD format:
`2019-02-14`
4. Study title appended with date:
`SafetyandEfficacyoftheXanomelineTransdermalTherapeutic\nSystem(TTS)inPatientswithMildtoModerateAlzheimer'sDisease2019-02-14`
5. Create SHA-1 hash of the title+date:
`e92971d5421dd4e83ed3e6f6bcc6cf0bd3538d2a`

Example R Code for steps 1 through 5:
```
library(digest)

protocolTitle <-"Safety and Efficacy of the Xanomeline Transdermal Therapeutic 
  System (TTS) in Patients with Mild to Moderate Alzheimer's Disease"

protocolTitle_nws <- gsub(" ","", protocolTitle)

dateToday <- '2019-02-14'

protocolTitleDate_nws <- paste0(protocolTitle_nws, dateToday)

studyURIHash <- sha1(protocolTitleDate_nws)

studyURIHash
```

## Form the Study URI
The study URI is composed of 3 components:  A **Namespace**, **Resource Type**, and the **UUID**.
If ClinicalTrials.gov were to be the hosting respository, URI for our example study could be:

`https://ct.gov/clinicaltrial#e92971d5421dd4e83ed3e6f6bcc6cf0bd3538d2a`

Where:

* ct.gov is the Namespace
* clinicaltrial# is the Resource Type
* the hash value is the UUID for the study.

If another organization like the FDA were to host information about the same study, the URI could be formed as:
`https://fda.gov/study#e92971d5421dd4e83ed3e6f6bcc6cf0bd3538d2a`

In this example both the Namspace and Resource Type changed, but the study id remains stable.

## URI for Company Internal and External resolution

This example shows how a company's identifier (ALZ-XAN-0005)for the trial could be used for external and internal websites.
External facing addresses could use .com and resolve publically available information about the study. the .net address could be used to link to company-confidential information behind the company firewall.


`https://data.abcPharma.com/clinicaltrial/ALZ-XAN-0005`

`https://data.abcPharma.net/clinicaltrial/ALZ-XAN-0005`


The following triples tie the information together:

```
https://ct.gov/clinicaltrial#e92971d5421dd4e83ed3e6f6bcc6cf0bd3538d2a
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
A central organization is needed to create study URIs, ensure their uniqueness, and make then available. A logical choice would be [[ClinicalTrials.gov]](https://clinicaltrials.gov) . 

## References
[Cool URIs for the Semantic Web](https://www.w3.org/TR/cooluris/)
Study URI" [[Paper]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Papers/TT10-tt09-study-uri-19746.pdf) [[Presentation]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Presentations/TT10-tt09-study-uri-pub-19747.pdf)

## Contributors
    - Kerstin Forsberg
    - Daniel Goude
    - Nolan Nichols
    - Johannes Ulander
    - Tim Williams
