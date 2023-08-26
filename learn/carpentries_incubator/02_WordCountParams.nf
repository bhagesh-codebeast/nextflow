// Simple workflow to count the number of lines in a fastq file

// Use Command: nextflow run -params-file 2_WordCountParams.json 2_WordCountParams.nf

// default workflow without name
workflow {

	// input channel to receive data
	input_channel = Channel.fromPath(params.input)

	// process to execute for the input data from channel
	NUM_LINES(input_channel)

	// display process output using out channel with view operator
	NUM_LINES.out.view()
	
}


// Process block
process NUM_LINES {

	// input channel
	input:
	path read

	// output channel
	output:
	stdout

	// script to execute
	script:
	"""
	printf '${read} '
	gunzip -c ${read} | wc -l
	"""

}