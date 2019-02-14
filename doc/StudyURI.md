# Study URI
This is a working draft for developing a guide to creating Uniform Resource
Identifiers (URIs) for clinical studies/trials. The work was inspired by the
PhUSE EUConnect18 paper "Study URI" [[Paper]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Papers/TT10-tt09-study-uri-19746.pdf) [[Presentation]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Presentations/TT10-tt09-study-uri-pub-19747.pdf) by Kerstin Forsberg
and Daniel Goude, with follow up discussions including Johannes Ulander and
Tim Williams. These recommendations are under development and subject to change.

You may contribute to this project by  branching the Github repository. Please
send comments and feedback by raising a Github issue.

[[Discussion of active questions]](StudyURI-questions.md)  (development team)


## Problem Statement
* Multiple repositories

### Inconsisent synonyms
A fundamental problem when referencing studies and when integrating information
on clinical studies is that we use synonyms (codes, numbers, acronyms) for the
same study. For example: `D3562C00096`, `4522IL/0096`, `NCT00240331`, `2004-001741-15`
and `AURORA` all refer to the same study. To understand that we are referring to
the same study, there is a need to cross match the same study across different
systems, often with different free text field for study codes and acronyms.

restructure this:
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

(ADD information from CoolURIs that fit the proposed approach)
https://www.w3.org/TR/cooluris/

## Proposed Solution
* A single identifier for a study that does not change over time and serves as a link between
various online repositories, internal and external information about the study. 

## Proposed Structure


## Parent URI

### External URI  (.com)

`https://data.pharma.com/clinicaltrial/D3562C00096`

###  Internal URI (.net)
`https://data.pharma.net/clinicaltrial/D3562C00096`

## Derefencing Guidance
[To add: Implications for internal and external de-referencing]


## Recommended Predicates
| Predicate     | Description   |
| ------------- |:-------------:|
| hasNCTID      |  |
| hasCompanyID  |  |
| hasAcronym    |  |
| hasEuroCTID   |  | 

(To Add: prefLabel, description, recommended/mandatory/optional,  etc.)

## Examples
(Triples illustrating the most common implementations : use of NCTIID, use prior to NCTID, etc.)

## Evolution (?)
How to manage the URI as the study evolves from not having NCTID to having one, etc.

## Use Cases
(Advantages, linking to other information. May link to separate pages)

## References
[Cool URIs for the Semantic Web](https://www.w3.org/TR/cooluris/)
Study URI" [[Paper]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Papers/TT10-tt09-study-uri-19746.pdf) [[Presentation]](http://www.phusewiki.org/docs/Frankfut%20Connect%202018/TT/Presentations/TT10-tt09-study-uri-pub-19747.pdf)

## Contributors
    - Kerstin Forsberg
    - Daniel Goude
    - Nolan Nichols
    - Johannes Ulander
    - Tim Williams
