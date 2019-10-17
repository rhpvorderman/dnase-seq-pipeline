import "../../dnase.wdl" as dnase

workflow test_preseq {
    File nuclear_bam

    call dnase.preseq { input:
		nuclear_bam = nuclear_bam
    }
}