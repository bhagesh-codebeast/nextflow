// Input & Output qualifier val
process QUALVAL {
	input:
	val chr
	output:
	val chr
	script:
	"""
	echo "Printing chromosome using val qualifier: $chr"
	"""
}

// Input Output qualifier path
process QUALPATH {
	input:
	path read
	output:
	path read
	script:
	"""
	echo "Printing line numbers using path qualifier: $read"
	echo "STATS: \$(wc $read)"
	"""
}

// Capture Multiple outputs

process MULTIOUTPUTS {
	input:
	path read
	output:
	path "test/*.txt"
	script:
	"""
	mkdir -p test
	ls $read > test/test1.txt
	ls -lrth $read > test/test2.txt
	"""
}


process MULTIOUTPUTS2 {
	// using nextflow variable sample_id to capture the sample name
	input:
	tuple val(sample_id), path(reads)

	output:
	tuple val(sample_id), path("test/*tuple*.fastq.gz")

	script:
	"""
	mkdir -p test
	echo "Sample ID: ${sample_id}"
	cp ${reads[0]} test/${sample_id}_tuple_1.fastq.gz
	cp ${reads[1]} test/${sample_id}_tuple_2.fastq.gz
	"""
}

workflow {
	chr = Channel.of(1..22,'X','Y','MT')
	QUALVAL(chr)
	// Using $it to reference the output value
	QUALVAL.out.view({"Val from output : $it"})


	read = Channel.fromPath('/Users/bhag/Documents/Code/Pipelines/Data/*.fasta')
	QUALPATH(read)
	QUALPATH.out.view({"Path from output : $it"})
	
	MULTIOUTPUTS(read)
	MULTIOUTPUTS.out.view()

	read2 = Channel.fromFilePairs('/Users/bhag/Documents/Code/Pipelines/Data/empty_{1,2}.fastq.gz')
	MULTIOUTPUTS2(read2)
	MULTIOUTPUTS2.out.view()
}
