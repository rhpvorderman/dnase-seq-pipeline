import "../../dnase.wdl" as dnase

workflow test_insert_sizes {
    File filtered_bam
	File nuclear_chroms 

    call dnase.insert_sizes { input:
		filtered_bam = filtered_bam,
        nuclear_chroms = nuclear_chroms
    }
}
