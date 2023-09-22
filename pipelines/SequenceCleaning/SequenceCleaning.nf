nextflow.enable.dsl=2
// https://biocorecrg.github.io/CoursesCRG_Containers_Nextflow_May_2022/nextflow_2.html
include {FASTQC} from '/Users/bhag/Documents/Code/nextflow/pipelines/modules/fastqc.nf'
include {MULTIQC} from '/Users/bhag/Documents/Code/nextflow/pipelines/modules/multiqc.nf'

params.reads = "/Users/bhag/Documents/Code/nextflow/learn/carpentries_incubator/data/*_{1,2}.fastq.gz"
params.output = "$baseDir/output"

Channel
	.fromFilePairs(params.reads, checkIfExists: true)
	.set { read_pairs_ch }

log.info """
	S E Q U E N C E - C L E A N I N G - P I P E L I N E
	===========================================================
	Input	: 	${params.reads}
	Output	: 	${params.output}
	""".stripIndent()

workflow {
	FASTQC(read_pairs_ch)
	
	MULTIQC(FASTQC.out.collect())
}