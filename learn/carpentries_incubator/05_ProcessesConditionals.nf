// Example variable
params.kmer = 5
params.condition = "true"

// Example Process
process TEST {
	/* Using script block definition instead of shell block
		here double triple quotes (""") will be used to define script block
		here nextflow variables will be in following syntax: $variable_name */
	script:
	if (params.condition == "true") {
		"""
		echo "Here is the kmer parameter: $params.kmer"
		"""
	} else {
		"""
		echo "Condition is false or unknown"
		"""
	}
}

// Example Workflow
workflow {
	TEST()
}