import "../../dnase.wdl" as dnase

workflow test_bam_counts {
	File marked_bam

	call dnase.bam_counts { input:
		marked_bam = marked_bam
	}
}