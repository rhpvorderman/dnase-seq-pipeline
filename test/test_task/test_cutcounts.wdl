import "../../dnase.wdl" as dnase

workflow test_cutcounts {
	File filtered_bam
	File reference_index
    
    call dnase.cutcounts { input:
		filtered_bam = filtered_bam,
        reference_index = reference_index
    }
}
