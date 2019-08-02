import "../../dnase.wdl" as dnase

workflow test_count_adaptors {
	File marked_bam

	call dnase.count_adaptors { input:
		marked_bam = marked_bam
	}
}