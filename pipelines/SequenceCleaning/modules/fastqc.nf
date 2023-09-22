process FASTQC {

	tag "${sample_id}"

	publishDir "${params.output}", mode: 'copy'

	container 'staphb/fastqc:latest'

	input:
	tuple val(sample_id), path(reads)

	output:
	path("${sample_id}_fastqc_logs/*.zip")

	script:
	"""
	mkdir -p ${sample_id}_fastqc_logs
	
	fastqc -o ${sample_id}_fastqc_logs \
	-f fastq \
	-q ${reads} \
	-t ${task.cpus}
	"""
	
}