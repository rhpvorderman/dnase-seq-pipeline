import "../../dnase.wdl" as dnase

workflow test_spot_score {
	File filtered_bam
	File mappable
	File chrom_info
	Int read_length

	call dnase.spot_score { input:
		filtered_bam = filtered_bam,
		mappable = mappable,
		chrom_info = chrom_info,
		read_length = read_length
	}
}