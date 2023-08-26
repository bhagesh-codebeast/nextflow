process DIRECTIVES {
	// Directives for the process
	tag "Directives testing for sample: $sample"
	cpus 1
	debug true
	cache false
	/* using container directives requires a nextflow.config file 
	with the following line

	docker {
		enabled = true
		}
	*/
	container 'staphb/fastqc:0.12.1'
	containerOptions '--rm'
	errorStrategy 'retry'
	

	input:
	val sample

	script:
	"""
	fastqc -v
	echo number of cpus $task.cpus
	"""

}

process ORGOUT {
	// Directive to organise output
	publishDir "output/"
	/* publishDir directive only symlinks the output files

		to copy the files
		publishDir "output/", mode: 'copy' or 'move'

		to overwrite the files 
		publishDir "output/", mode: 'copy', overwrite: true

		to only copy/move files when step is successful
		publishDir "output/", failOnError: true

		to copy/move multiple files to a different directory
		publishDir "output/bams", pattern: '*.bam', mode: 'copy'
		publishDir "output/index", pattern: '*.bam.bai', mode: 'copy'

	*/

	input:
	val sample

	// out variable should capture the exact output with path to copy/move
	output:
	path "${sample}/*.txt"

	script:
	"""
	mkdir -p ${sample}
	echo "This is a test" > ${sample}/${sample}.txt
	"""
}
sample = "test"

workflow {
	DIRECTIVES(sample)
	ORGOUT(sample)
}