CSB PDB RESTful Web Service interface

The RCSB PDB supports RESTful (REpresentational State Transfer) Web Services to make accessing data easier. Please use these services instead of screen-scraping.
Generally we are trying to implement two types of services for our RESTful interface:

Search services: to return a list of IDs (e.g., PDB IDs, chain IDs, ligand IDs)
Fetch services: to return data given a ID (e.g. reports, descriptions, data items)
The services below are currently provided; please let us know if you have additional suggestions.
SEARCH services

A generic SEARCH service allowing to POST advanced queries
Search for ligands and PDB IDs based on a SMILES query
 
FETCH services

Custom Reports
Retrieve a custom report with a list of PDB IDs and fields
 
Descriptions
Get descriptions for the whole PDB file
Get descriptions for PDB entities
Get descriptions of chemical components
Get ligands that are present in a single PDB entry
 
Lists and status
Get a PDB ID's release status
Get a list of all currently released PDB IDs
Get a list of unreleased PDB IDs
Get the pre-release sequences in FASTA format
 
Annotations
Third-party annotations mapped onto PDB chains
A PDB to UniProtKB mappings
Pfam mappings for PDB
Access Gene Ontology terms for a PDB chain.
 
Sequence and Structure Clusters
Sequence and Structure cluster related services
 
PDB File Description Service
Access general information about a PDB entry (e.g., Header information).
Example: Access the information for one file: /pdb/rest/describePDB?structureId=4hhb
Example: Access the information only for multiple files: /pdb/rest/describePDB?structureId=4hhb,1hhb
Describe the molecular entities that are contained in a PDB entry. Also provides information on the number of available biological assemblies.
Example: Access for one PDB ID/pdb/rest/getEntityInfo?structureId=1hv4
Example: Access the information for all PDB IDs: /pdb/rest/getEntityInfo
 
Descriptions of PDB entities
Access the descriptions of the entities that are contained in a PDB file.
Example: Access the information for all entities in the file: /pdb/rest/describeMol?structureId=4hhb
Example: Access the information only for a single PDB chain: /pdb/rest/describeMol?structureId=4hhb.A
 
Descriptions of Chemical Components
Access the descriptions of the chemical components based on their IDs. XML contains a PDB ID as an example of where it can be found.
Example: Access the information for one components: /pdb/rest/describeHet?chemicalID=NAG
Example: Access the information for multiple components: /pdb/rest/describeHet?chemicalID=NAG,EBW
 
List all current/obsolete PDB IDs
Get a list of all current PDB IDs.
Example: List all current PDB IDs: /pdb/rest/getCurrent
Get a list of all obsolete PDB IDs.
Example: List all obsolete PDB IDs: /pdb/rest/getObsolete
 
BLAST search on the PDB database
BLAST with Sequence.
Example: HTML output: /pdb/rest/getBlastPDB1?sequence=VLSPADKTNVKAAWGKVGAHAGEYGAEALERMFLSFPTTKTYFPHFDLSHGSAQVKGHGKKVADALTAVAHVDDMPNAL&eCutOff=10.0&matrix=BLOSUM62&outputFormat=HTML
Example: XML output: /pdb/rest/getBlastPDB1?sequence=VLSPADKTNVKAAWGKVGAHAGEYGAEALERMFLSFPTTKTYFPHFDLSHGSAQVKGHGKKVADALTAVAHVDDMPNAL&eCutOff=10.0&matrix=BLOSUM62&outputFormat=XML
Example: Plain text output: /pdb/rest/getBlastPDB1?sequence=VLSPADKTNVKAAWGKVGAHAGEYGAEALERMFLSFPTTKTYFPHFDLSHGSAQVKGHGKKVADALTAVAHVDDMPNAL&eCutOff=10.0&matrix=BLOSUM62
BLAST with Structure ID and Chain ID.
Example: HTML output: /pdb/rest/getBlastPDB2?structureId=4HHB&chainId=A&eCutOff=10.0&matrix=BLOSUM62&outputFormat=HTML
Example: XML output: /pdb/rest/getBlastPDB2?structureId=4HHB&chainId=A&eCutOff=10.0&matrix=BLOSUM62&outputFormat=XML
Example: Plain text output: /pdb/rest/getBlastPDB2?structureId=4HHB&chainId=A&eCutOff=10.0&matrix=BLOSUM62
View a Java example that submits a BLAST search via a POST: PostBLASTQuery.java
 
Information about release status
Get Information about the release status for one or multiple PDB ids.
Example: Access the information for a one PDB ID: /pdb/rest/idStatus?structureId=4HHB
Example: Access the information for a set of PDB IDs: /pdb/rest/idStatus?structureId=450D,451D
 
List unreleased PDB IDs
Get a list of PDB IDs that have not been released yet.
Example: Access the information for a subset of PDB IDs: /pdb/rest/getUnreleased?structureId=450D,451D
Example: Access the information for all unreleased PDB IDs: /pdb/rest/getUnreleased
 
List pre-release sequences in FASTA format
Get a list of pre-release sequence in FASTA format.
Example: Access the information for a subset of PDB IDs: /pdb/rest/getStatusSequence?structureId=3MU6,3QV1,3SSF
Example: Access the information for a subset of PDB IDs, entity type, and range of deposition date: /pdb/rest/getStatusSequence?entityType=RNA&depositionDateMin=2011-07-01&depositionDateMax=2011-07-30 (The entity type can be RNA, DNA, and Polypeptide.)
Example: Access the information for all unreleased PDB IDs: /pdb/rest/getStatusSequence
 
Ligands in PDB files
List the ligands that can be found in a PDB entry.
Example: /pdb/rest/ligandInfo?structureId=4HHB
 
Gene Ontology terms for PDB chains
List the Gene Ontology terms that have been annotated for a PDB chain. (Same as on the Annotations tab in the structure explorer pages).
Example: /pdb/rest/goTerms?structureId=4HHB
Example: /pdb/rest/goTerms?structureId=4HHB.A
Example: /pdb/rest/goTerms?structureId=4HHB.A,1A4W.H
 
Pfam annotations for PDB entries
The Pfam annotations that are displayed on the RCSB PDB web site are calculated by weekly scripting the Hmmer web site. The calculated annotations can be downloaded using any of these options:
per PDB ID: /pdb/rest/hmmer?structureId=4hhb
all annotations in one XML file /pdb/rest/hmmer
all annotations in one tab-delimited file /pdb/rest/hmmer?file=hmmer_pdb_all.txt
 
Sequence and Structure cluster related web services
Various requests related to the sequence and 3D - structure clustering are available:
/pdb/rest/sequenceCluster?cluster=40&structureId=4hhb.A Get all the sequence cluster at 40% sequence ID for a particular chain ID.
/pdb/rest/representatives?cluster=40 Get all representative chains from the 40% sequence clustering.
/pdb/rest/representatives?structureId=4hhb.A Get the representative for a chain (the chain on Rank 1 in the sequence clustering).
/pdb/rest/representativeDomains?cluster=40 Get all representative domains that are used for the systematic structure alignments.
/pdb/rest/representativeDomains?structureId=4hhb.A Get the representatives domains for a chain.
The names of the representative domains are either SCOP domain IDs (starting with "d") or domain IDs as have been assigned with the Protein Domain Parser software ("PDP:")

The all vs. all structural similarity results table for a representative chain can be downloaded in XML. For example, this returns Rank, PDB.Chain, Description, P-value, Score, RMSD, Len1, Len2, %Sim1, and %Sim2 for 3BMV.A /pdb/explorer/structCompXMLData.jsp?method=pw_fatcat&chain=d3bmva1&page=1&rows=10&prettyXML. Note: A maximum 2000 rows can be returned through this URL. To fetch all approx. 17,000 results for a chain,you need to slice through the results using the page parameter.

There are additional parameters for this URL, which allow sorting. e.g. this sorts by P-value /pdb/explorer/structCompXMLData.jsp?method=pw_fatcat&showAllResults=false&chain=d1iarb1&rows=15&page=1&sidx=probability&sord=asc Parameters that can be used for sorting (the value of the sidx parameter) are: name2,desc,probability, score, rmsdOpt, len1, len2, pid, sim1, sim2.

 
Third-party annotations and PDB to UniProtKB mapping
DAS Service: 
The RESTful services for providing third-party annotations (SCOP, CATH, Pfam, etc.) follows the DAS protocol. The DAS server is available from /pdb/rest/das. The DAS protocol command SOURCES (description of the provided sources) is available from /pdb/rest/das/sources. At the present there are two DAS sources provided:
pdbchainfeatures:

Provides various third party annotations that have been computed for PDB chains.
Get the third party features (a DAS - FEATURES request): /pdb/rest/das/pdbchainfeatures/features?segment=5pti.A
Get the ATOM sequence of the PDB chain (a DAS - SEQUENCE request): /pdb/rest/das/pdbchainfeatures/sequence?segment=5pti.A
pdb_uniprot_mapping:

Provides a DAS source that is serving the alignment between UniProtKB and PDB, derived from the SIFTS mappings.
Example: Get all alignments for a PDB (a DAS - ALIGNMENT request) /pdb/rest/das/pdb_uniprot_mapping/alignment?query=4hhb
Example: Get all alignments for a single PDB chain (a DAS - ALIGNMENT request) /pdb/rest/das/pdb_uniprot_mapping/alignment?query=4hhb.A
For more documentation on the DAS protocol, see http://www.dasregistry.org/

 
Chemical Structure searches with SMILES or SMARTS strings
This query performs chemical structure searches using SMILES and SMARTS linear notations. 
Search types include exact, substructure, superstructure and similarity.
Exact: find an exact structure match
/pdb/rest/smilesQuery?smiles=NC(=O)C1=CC=CC=C1&search_type=exact
Substructure: find ligands that contain the specified structure as a substructure
/pdb/rest/smilesQuery?smiles=NC(=O)C1=CC=CC=C1&search_type=substructure
Superstructure: find ligands that are substructures (fragments) of the specified structure
/pdb/rest/smilesQuery?smiles=OC(=O)c1ccc(OCc2ccccc2)cc1&search_type=superstructure
Similarity: find structures that bind similar ligands.
Specify a similarity threshold to change the degree of similarity in the [0...1] range: 0 dissimilar ... 1 identical.
The similarity is based on the number of chemical features in common between the query and the target molecule. Similarity is calculated using the Tanimoto Coefficient.
/pdb/rest/smilesQuery?smiles=OC(=O)c1ccc(OCc2ccccc2)cc1&search_type=similarity&similarity=0.7
 
SEARCH service
This interface exposes the RCSB PDB advanced search interface as an XML Web Service.

To use this service, POST a XML representation of an advanced search to /pdb/rest/search.

XML representation of advanced search
Every advanced search can be represented by XML. To view an example representation, simply execute an advanced search query and then click on the Result tab. One of the links on the top of the page is Query Details. Clicking on this link will provide the XML representation of the query.

Every query is described by two data items:

queryType: the name of the class that is implementing the query
arguments: depending on the type of query that is being executed one or more differently named arguments need to be provided.
 
Sample XML Queries:

The Query is displayed in the Textbox below

Example:
<orgPdbQuery>    
    <queryType>org.pdb.query.simple.UpAccessionIdQuery</queryType>
    <description>Simple query for a list of UniprotKB Accession IDs: P50225</description>   
    <accessionIdList>P50225</accessionIdList>
</orgPdbQuery>
 

