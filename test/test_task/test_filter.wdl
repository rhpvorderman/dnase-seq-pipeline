import "../../dnase.wdl" as dnase

workflow test_filter {
	File marked_bam
	Boolean UMI

	Int flag = if UMI then 1536 else 512

	call filter { input:
		marked_bam = marked_bam,
		flag = flag
	}
}