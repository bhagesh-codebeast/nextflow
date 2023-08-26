
params.reads = "data/*_{1,2}.fastq.gz"
params.transcriptome = "data/*.fa"
params.outdir = "output"

println "reads: $params.reads"

log.info """\
	R N A S e q   P i p e l i n e
	==================================================
	data		: https://www.hadriengourle.com/tutorials/rna/
	transcripome	: ${params.transcriptome}
	reads		: ${params.reads}
	outdir		: ${params.outdir}
	"""
	.stripIndent()

// Create Index
process INDEX {
	container 'biocontainers/salmon:v0.12.0ds1-1b1-deb_cv1'
	containerOptions '--rm'

	input:
	path transcripome

	output:
	path 'index'

	script:
	"""
	salmon --version >> tool.versions
	salmon index --threads $task.cpus -t $transcripome -i index
	"""
}

transcripome_ch = channel.fromPath(params.transcriptome)


workflow{

	INDEX(transcripome_ch)

}