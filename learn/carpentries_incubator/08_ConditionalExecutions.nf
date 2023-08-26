process CONDITIONAL {
	input:
	val chr

	// Conditional to specify execution criteria
	when:
	chr <= 5

	script:
	"""
	echo $chr
	"""
}

chr_ch = channel.of(1..22)

workflow {
	CONDITIONAL(chr_ch)
}