/* Process syntax
process <process_name> {
	[directives]
	input:
		<type> <variable_name> from <channel_name>
	output:
		<type> <variable_name> into <channel_name>
	when:
		<condition>
	[script|shell|exec]:
		"""
		<command>
		"""
}
*/

// Command : nextflow_learn % nextflow run 4_Processes.nf -process.echo

// Example variable
params.kmer = 5

// Example Process
process GETCWD {
	/* Using shell block definition instead of script
		here single triple quotes (''') will be used to define shell block
		here nextflow variables will be in following syntax: !{variable_name} */
	shell:
	'''
	python_version=`python3 --version`
	echo "referencing bash variables: $python_version"
	echo "referencing param variables: !{params.kmer}"
	4_Processes.py
	'''
	// Python script or any script for that matter will not work without shebang line in it
}


// Example Workflow
workflow {
	GETCWD()
}