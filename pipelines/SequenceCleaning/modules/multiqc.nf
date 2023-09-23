process MULTIQC {

	publishDir "${params.output}/multiqc", mode: 'copy'

	input:
	path input_dir

	output:
	path '*'

	script:
	"""
	multiqc .
	"""

}