// Operators : https://www.nextflow.io/docs/latest/operator.html
// channel.<operator>()

/* Operators can be separated in to several groups: 
filtering , transforming , splitting , combining , forking and Maths operators */

/* Operators can be chained using dot notations
channel
	.of(1..22,'X','Y','M')
	.view()

Closures can be used to moidify the output of the operator
without changing the content of the original channel
channel
	.of(1..22,'X','Y','M')
	.view({"Chrom $it"})
would prinrt Chrom 1...
	*/

// Create a channel
ch = channel.of(1..22,'X','Y','M')

// View Operator
ch.view()
// prints items emited by a channel appending a new line after each item.


// Filtering Operators
ch
	.filter(Number)
	.view()
// filter using literal value
ch
	.filter(2)
	.view()
// filter using Regex
ch
	.filter(~/^[2.*]/)
	.view()
// filter using closure | Boolean
ch
	.filter(Number)
	.filter{it % 2 == 0}
	.view()


// Mapping Operator
channel
	.of('chr1','chr2')
	.map({it.replaceAll('chr1','C1')})
	.view()


// Changing the default it variable name
channel
	.fromPath('data/*.fastq.gz') // create a channel from a file glob
	.map({file -> [file, file.countFastq()] }) // count the number of reads in each file
	.filter({fastq,reads -> reads > 0 }) // filter out empty files using fastq and reads as placeholders for file and read number
	.view({fastq,reads -> "file $fastq contains $reads reads"}) // print the result


// Flatten Operator
channel
	.of([1,2,3],['A','B','C'])
	.view()
	.flatten()
	.view()
/* falttens the tuple or list to single elements in the channel
similar to channel factory channel.fromList */


// Collect Operator
channel
	.of(1..22,'X','Y','M')
	.collect()
	.view()
/* collects all the items in the channel and returns a list
Opposite of flatten operator,
results ina value channel that can be used multiple times */


// GroupTuple Operator
channel
	.of(['sampleX','sampleX_1.fastq.gz'],['sampleX','sampleX_2.fastq.gz'])
	.groupTuple(size:2) // group the channel into tuples of size 2
	.view()

// Complex usecase
channel
	.fromPath('data/*.fastq.gz')
	.map({file -> [file.getName().split('_')[0],  file, file.countFastq()]}) // create a tuple of sample name and file
	.filter({sample, filename , reads -> reads > 0}) // filter out empty files
	.groupTuple(size:2)
	.view()


// Operators for Merging Channels

// Mix Operator
channel
	.of(1..22)
	.mix(channel.of('X','Y','M'))
	.view()

// Join Operator
reads1_ch = channel
  .of(['wt', 'wt_1.fq'], ['mut','mut_1.fq'])
reads2_ch= channel
  .of(['wt', 'wt_2.fq'], ['mut','mut_2.fq'])

reads_ch = reads1_ch
  .join(reads2_ch)
  .view()
/* output
	[wt, wt_1.fq, wt_2.fq]
	[mut, mut_1.fq, mut_2.fq] */


// Forking Operators

// set Operator
// splits the channel into multiple channels
channel
     .of( 'chr1', 'chr2', 'chr3' )
     .set{ ch1 }
ch1.view()


// Math Operators
// count, min, max, sum, integer 
channel
	.of(1..100)
	.sum()
	.view()


// Split Operators
/* spliCsv, splitFastq, splitFasta, splitText */

// splitCsv Operator
channel
	.fromPath('data/*.csv')
	.splitCsv(sep:',')
	.view({it[0]}) // print the first column of each row
// to reference a column by name set header true
channel
	.fromPath('data/*.csv')
	.splitCsv(sep:',', header:true)
	.view({it.sample_id}) // print the first column of each row