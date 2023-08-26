// Input qualifier val
process QUALVAL {
	input:
	val chr
	
	script:
	"""
	echo "Printing chromosome using val qualifier: $chr"
	"""
}

// Input qualifier path
process QUALPATH {
	input:
	path read
	
	script:
	"""
	echo "Printing line numbers using path qualifier: $read"
	echo "STATS: \$(wc $read)"
	"""
}

// Combining input qualifiers OR Input repeaters

/* by default the number of times a process runs is defined
	by the queue channel with the fewest items. */

// To prevent the default behaviour we can use Channel.value() or each

process QUALCOMBINE {
	input:
	val chr1
	each chr2
	/* the same could also be given as follows
		input:
			tuple val(chr1), each(chr2)
	*/

	script:
	"""
	echo $chr1 $chr2
	"""

}

workflow {
	chr = Channel.of(1..22,'X','Y','MT')
	QUALVAL(chr)

	read = Channel.fromPath('/Users/bhag/Documents/Code/Pipelines/Data/*.fasta')
	QUALPATH(read)

	chr1 = Channel.of(1..22,'X','Y','MT')
	chr2 = Channel.of('A'..'E')
	QUALCOMBINE(chr1,chr2)
}
