
---- ***Update 2019-02-26: Pages undergoing significant restructure and re-write*** ---

# Prologue
This is a working draft proposal for creation, management, and use of Uniform Resource
Identifiers (URIs) for clinical trial identification. The work was inspired by the
PhUSE EUConnect18 paper "Study URI" [[Paper]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Papers/TT10-tt09-study-uri-19746.pdf) [[Presentation]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Presentations/TT10-tt09-study-uri-pub-19747.pdf) by Kerstin Forsberg
and Daniel Goude. These recommendations are under development and subject to change.

You may contribute to this project by branching the Github repository. Please
send comments and feedback by raising a Github *issue*.

[[Team Discussion of active questions]](StudyURI-questions.md)

## Introduction
The concept of unique identifiers for clinical trials is not new, but implementations are inconsistent and subject to change over time. The **NCT Number**, commonly referred to as the **ClinicalTrials.gov identifier**, is one of the most widely recognized study identifiers [[ClinicalTrials.gov]](https://clinicaltrials.gov/). This number is created after submission and review of the protocol at ClinicalTrials.gov, so it is not available earlier in the development process. The European Medicines Agency provides the capability to generate unique identifiers for trials, called the **EudraCT number**, which can be used to look up information in the [European Clinical Trials Database(EudraCT)](https://eudract.ema.europa.eu/). There are also repositories for specific countries, as well as multiple databases within the pharmaceutical companies themselves.There is no consistent way to bring this information together for patients, researchers, or regulatory organizations.

Historically, development of identifiers was driven by the need to identify trials in specific repositories, with the hope of leading to broader usage and application. Unfortunately, no one standard exists. Multiple repositories contain different types of information about the same trial, and companies maintain their own public and private information.

The use case for identifiers has progressed beyond the need for locating information within a single data silo. Web-based identifiers (URIs) can provide the required unique identifier while also facilitating links between repositories and to other materials both on the public internet and also private information inside a company's firewall. This dual functionality greatly enhances the utility of identifiers that use this approach.

Searching for information about clinical trials on the the web is now commonplace for both patients and researchers. In fact, patients and the general public have come to *expect* this information is available online. Without a common identifier, multiple searches must be executed using  synonyms (codes, numbers, acronyms) for the same trial. For example: `D3562C00096`, `4522IL/0096`, `NCT00240331`, `2004-001741-15`and `AURORA` all refer to the same study. Data must be merged from different systems that use these acronyms, often relying in free text fields for study codes and acronyms. Current expectations for ease of access to this information are not being met.



---------  WORK IN PROGRESS ----------------

[UUID Creation: Technical Details](./UUIDTechDetails.md)

This proposal addresses the multiple challenges surrounding clinical trial identifiers, including:


* **Multiple repositories**

* **Inconsisent synonyms**

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

A clinical trial requires an identifier that satisfies the following criteria: 

* ID is unique to the trial 
* Easy to create and use
* Is machine-readable, without human interpretable meaning (which is open to interpretation and change)
* Does not change over time (stable, immutable) 
* Facilitates links to other online repositories as well as internal and external information about the study. 
* Links to human-interpretable identifiers and metadata
* Can be created before submission to a repository or governing authority, while ensuring it is unique to that study.


# Proposal
##URIs
[Uniform Resource Identifiers](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) (URIs) as [Resource Description Framework](https://en.wikipedia.org/wiki/Resource_Description_Framework) (RDF) is an ideal candidate for clinical trial identifiers. By definition, they unambiguously identify a resource (in this case, a clinical trial) and are a well-established [W3C standard](https://www.w3.org/wiki/URI).



The proposed study URI is composed of three components:  A **Namespace**, **Resource Type**, and the **UUID**.

Example: `http://RepoAuthority.org/clinicaltrial/e92971d5421dd4e83ed3e6f6bcc6cf0bd3538d2a`

Where:

* `RepoAuthority.org` is the **Namespace**
* `clinicaltrial` is the **Resource Type**
* The string after /clinicaltrial/ is the **UUID** for the study.

*Note how URIs use the http scheme but this does not necessarily mean the data is available on the web! This type of identifier can be used in databases behind company firewalls and do not require http services to make use of the data.* 

##Namespace
Namespaces are subject to change over time and may represent different entities and use cases.

| Namespace | Description                                                     |
|-----------|-----------------------------------------------------------------|
| PharmaCo.com   | Publicly available information about the study at the "PharmaCo" company web site |
| PharmaCo.net   | Information available within the "PharmaCo" company firewall |
| RepoAuth.org   | Information at a specific repository (e.g.: clinicalTrials.gov, EudraCT, or others ) |


## Resource Type
We recommend the use of *clinicaltrial* for the resource type for clear identification of the resource type. 

## UUID
The UUID is the most critical component because it serves as the unique identifier. It must satisfy the aforementioned ID Requirements listed above. 

We propose three possible methods of constructing the UUID. All methods use the fictional company "PharmaCo.""




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
