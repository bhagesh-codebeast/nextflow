nextflow.enable.dsl=2
include {FASTQC} from '/Users/bhag/Documents/Code/nextflow/pipelines/SequenceCleaning/modules/fastqc.nf'
include {MULTIQC} from '/Users/bhag/Documents/Code/nextflow/pipelines/SequenceCleaning/modules/multiqc.nf'

log.info """
	S E Q U E N C E - C L E A N I N G - P I P E L I N E
	===========================================================
	Input	: 	${params.reads}
	Output	: 	${params.output}
	""".stripIndent()

Channel
	.fromFilePairs(params.reads, checkIfExists: true)
	.set { read_pairs_ch }

workflow {
	FASTQC(read_pairs_ch)
	MULTIQC(FASTQC.out.collect())
}