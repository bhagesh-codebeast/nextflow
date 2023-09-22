process MULTIQC {

	publishDir "${params.output}/multiqc", mode: 'copy'
	container 'staphb/multiqc:latest'

	input:
	path(logs)

	output:
	path '*'

	script:
	"""
	multiqc .
	"""

}