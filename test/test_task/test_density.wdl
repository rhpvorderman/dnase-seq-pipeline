import "../../dnase.wdl" as dnase

workflow test_density {
   	File filtered_bam
	File reference_index
	File chrom_bucket
	Int window_size
	Int bin_size
	String scale

    call dnase.density { input:
		filtered_bam = filtered_bam,
        reference_index = reference_index,
        chrom_bucket = chrom_bucket,
        window_size = window_size,
        bin_size = bin_size,
        scale = scale
    }
}
