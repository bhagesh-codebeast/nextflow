process DIRECTIVES {
	cpus 1

	input:
	val sample

	// process named outpt
	output:
	path "${sample}.txt", emit: file_name

	script:
	"""
	echo number of cpus $task.cpus > ${sample}.txt
	"""

}

process ORGOUT {

	input:
	path "${sample}.txt"

	script:
	"""
	cat ${sample}.txt
	"""
}

process FASTQC {
	container 'staphb/fastqc:latest'
	containerOptions "--rm"
	cpus 5

	input:
	tuple val(sample_id), path(reads)

	output:
	path "fastqc_${sample_id}_logs/*.zip"

	script:
	"""
	mkdir -p fastqc_${sample_id}_logs/
	fastqc -o fastqc_${sample_id}_logs/ \
	-f fastq \
	-q ${reads} \
	-t ${task.cpus}
	"""
}

process PARSEZIP {
	publishDir "output", mode: 'copy'

	input:
	path flagstats

	output:
	path "pass_basic.txt"

	script:
	"""
	for zip in *.zip; do zipgrep 'Basic Statistics' \$zip | grep 'summary.txt'; done > pass_basic.txt
	"""
}

workflow {
	// sample = "test"

	// execution using variables
	// channel_1=DIRECTIVES(sample)
	// ORGOUT(channel_1)

	// process composition
	// ORGOUT(DIRECTIVES(sample))

	//process outputs
	// ORGOUT(DIRECTIVES(sample).out)

	// process named outputs
	// ORGOUT(DIRECTIVES(sample).file_name)

	params.fastq = "/Users/bhag/Documents/Code/nextflow_learn/data/*{1,2}.fastq.gz"
	params.reads = channel.fromFilePairs(params.fastq, checkIfExists: true)

	// collecting outputs into a list
	PARSEZIP(FASTQC(params.reads).collect())
}