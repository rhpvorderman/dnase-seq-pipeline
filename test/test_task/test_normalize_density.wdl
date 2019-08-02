import "../../dnase.wdl" as dnase

workflow test_normalize_density {
    File filtered_bam
	File density
	File reference_index
	Int bin_size
	String scale

    call dnase.normalize_density { input:
        filtered_bam = filtered_bam,
        density = density,
        reference_index = reference_index,
        bin_size = bin_size,
        scale = scale
    }
}
