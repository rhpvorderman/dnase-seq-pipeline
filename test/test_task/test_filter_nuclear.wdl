import "../../dnase.wdl" as dnase

workflow test_filter_nuclear {
    File filtered_bam
	File nuclear_chroms

    call dnase.filter_nuclear { input:
		filtered_bam = filtered_bam,
	    nuclear_chroms = nuclear_chroms
    }
}