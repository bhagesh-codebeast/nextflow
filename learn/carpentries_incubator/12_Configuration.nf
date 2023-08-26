params.message = 'Hello World from within script'

workflow {
	PRINT(params.message)
	PRINT2(params.message)

	READS = Channel.fromPath('data/*.fastq.gz')
	PRINT3(READS)
}

process PRINT{
	debug true

	input:
	val message

	script:
	"""
	echo $message
	"""
}


process PRINT2{
	debug true
	label 'PRINT2'

	input:
	val message

	script:
	"""
	echo $message
	"""
}

process PRINT3{
	debug true
	label 'PRINT3'
	container 'staphb/fastqc:0.12.1'
	containerOptions '--rm'

	input:
	path reads

	script:
	"""
	fastqc -t $task.cpus $reads
	"""
}
