import "../../dnase.wdl" as dnase

workflow test_hotspot2 {
    File filtered_bam
    File mappable
    File chrom_sizes
	File centers
    
	call dnase.hotspot2 { input:
		filtered_bam = filtered_bam,
		mappable = mappable,
        chrom_sizes = chrom_sizes,
        centers = centers
	}
}