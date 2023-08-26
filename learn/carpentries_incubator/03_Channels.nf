// Value Channel
// chr_list = Channel.of(1..22,'x','y')

// Queue Channel
// chr_list2 = Channel.from(1..22,'x','y')
// ...fromPath()
// ...fromFilePairs()
// ...fromSRA()


// Difference
test_list = [1,2,3,4,5,6,7,8,9,10]
test_path = '/Users/bhag/Documents/Code/Pipelines/Data/*.fastq.gz'
test_pair = '/Users/bhag/Documents/Code/Pipelines/Data/*_{1,2}.fastq.gz'
test_pair2 = '/Users/bhag/Documents/Code/Pipelines/Data/*_{1,2,3,4,5,6}*'

// of prints [1, 2, ..., 10]
Channel.of(test_list).view()

/* fromList prints
	1 
	2 
	3 
	... 
	10 */
Channel.fromList(test_list).view()

/* fromPath prints the path of the files:
	/Users/bhag/Documents/Code/Pipelines/Data/empty_2.fastq.gz
	/Users/bhag/Documents/Code/Pipelines/Data/SRR000024.fastq.gz
	/Users/bhag/Documents/Code/Pipelines/Data/SRR000028.fastq.gz
	/Users/bhag/Documents/Code/Pipelines/Data/SRR000022.fastq.gz
	/Users/bhag/Documents/Code/Pipelines/Data/empty_1.fastq.gz */
Channel.fromPath(test_path, checkIfExists:true).view()

/* fromFilePairs prints the path of the files:
[empty, 
	[/Users/bhag/Documents/Code/Pipelines/Data/empty_1.fastq.gz, 
	/Users/bhag/Documents/Code/Pipelines/Data/empty_2.fastq.gz]] */
Channel.fromFilePairs(test_pair).view()
/* [empty, 
	[/Users/bhag/Documents/Code/Pipelines/Data/empty_1.fastq.gz, 
	/Users/bhag/Documents/Code/Pipelines/Data/empty_2.fastq.gz, 
	/Users/bhag/Documents/Code/Pipelines/Data/empty_3.fastq.gz, 
	/Users/bhag/Documents/Code/Pipelines/Data/empty_4.fastq.gz, 
	/Users/bhag/Documents/Code/Pipelines/Data/empty_5.fastq.gz, 
	/Users/bhag/Documents/Code/Pipelines/Data/empty_6.fastq.gz]] */
Channel.fromFilePairs(test_pair2,size:6).view()


/* fromSRA queries NCBI and gets files associated with the SRA,ERR.. ID's:
[ERR908507, 
	[/vol1/fastq/ERR908/ERR908507/ERR908507_1.fastq.gz, 
	/vol1/fastq/ERR908/ERR908507/ERR908507_2.fastq.gz]] */
Channel.fromSRA('ERR908507').view()

