# Study URI
This is a working draft for developing a guide to creating Uniform Resource
Identifiers (URIs) for clinical studies/trials. The work was inspired by the
PhUSE EUConnect18 paper "Study URI" [[Paper]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Papers/TT10-tt09-study-uri-19746.pdf) [[Presentation]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Presentations/TT10-tt09-study-uri-pub-19747.pdf) by Kerstin Forsberg
and Daniel Goude, with follow up discussions including Johannes Ulander and
Tim Williams. These recommendations are under development and subject to change.

You may contribute to this project by  branching the Github repository. Please
send comments and feedback by raising a Github issue.

## Background
A fundamental problem when referencing studies and when integrating information
on clinical studies is that we use synonyms (codes, numbers, acronyms) for the
same study. For example: `D3562C00096`, `4522IL/0096`, `NCT00240331`, `2004-001741-15`
and `AURORA` all refer to the same study. To understand that we are referring to
the same study, there is a need to cross match the same study across different
systems, often with different free text field for study codes and acronyms.

One use case is the lookup of study codes and acronyms to identify studies in
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

## Proposed Structure
A Study URI is comprised of three components. The Global Namespace, Resource Type, and Trial ID.

`https://data.pharma.abc/clinicaltrial/D3562C00096`

![](https://github.com/phuse-org/LinkedDataEducation/blob/master/doc/images/StudyURIComponents.png)

### Details

**1. Global Namespace**  `https://data.pharma.abc`

[To add: How to specify. Implications for derefencing will be described below]

**2. Resource type**  `clinicaltrial`

[To add: why "clinicialtrial', ontology considerations, and other possible resource types]

**3. Trial ID**   `D3562C00096`

The first choice for the Trial ID component is the NCT ID from ClinicalTrials.gov.

Choice 1: Is the clinical trials.gov ID available for the drug?

 [To add: Instructions for how to search ct.gov for this information]

Choice 2: A combo of internal ID's 
[To add: Generic recommendations for internal IDS, how to update when NCT ID becomes available]


## Derefencing Guidance
[To add: Implications for internal and external de-referencing]


## Additional Triples
[To add: The minimal recommended relations attached to Study URI]


## Contributors
Kerstin Forsberg

Daniel Goude

Nolan Nichols

Johannes Ulander

Tim Williams

