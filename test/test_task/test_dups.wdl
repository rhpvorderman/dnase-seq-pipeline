import "../../dnase.wdl" as dnase

workflow test_dups {
	Array[File] fastqs
	Boolean UMI
	String? UMI_value
	File adapters
	File reference_index
	File reference
	File nuclear_chroms
	Int split_fastq_chunksize
	Int trim_to = 0
	Int threads = 1

	scatter (i in range(length(fastqs))) {
		call dnase.split_fastq { input:
			fastq = fastqs[i],
			fastq_line_chunks = 4 * split_fastq_chunksize,
			read_number = i + 1
		}
	}

	Array[Pair[File, File]] chunked_pairs = zip(split_fastq.splits[0], split_fastq.splits[1])

	scatter (pair in chunked_pairs) {
		call dnase.trim_adapters { input:
			read_one = pair.left,
			read_two = pair.right,
			adapters = adapters,
			threads = threads
		}

		if (trim_to > 0) {
			call dnase.trim_to_length { input:
				read_one = trim_adapters.trimmed_fastqs[0],
				read_two = trim_adapters.trimmed_fastqs[1],
				trim_to = trim_to
			}
		}

		Array[File] trimmed_fastqs = select_first([trim_to_length.trimmed_fastqs, trim_adapters.trimmed_fastqs])

		if (UMI) {
			call dnase.add_umi_info { input:
				read_one = trimmed_fastqs[0],
				read_two = trimmed_fastqs[1],
				UMI_value = UMI_value
			}
		}

		Array[File] fastqs_for_alignment = select_first([add_umi_info.with_umi, trimmed_fastqs])

		call dnase.align { input:
			read_one = fastqs_for_alignment[0],
			read_two = fastqs_for_alignment[1],
			reference = reference,
			reference_index = reference_index,
			threads = threads
		}

		call dnase.filter_bam { input:
			unfiltered_bam = align.unfiltered_bam,
			nuclear_chroms = nuclear_chroms
		}

		call dnase.sort_bam { input:
			filtered_bam = filter_bam.filtered_bam,
			threads = threads
		}
	}

	call dnase.merge { input:
		bams = sort_bam.sorted_bam
	}

	String dups_cmd = 	if UMI then 'UmiAwareMarkDuplicatesWithMateCigar' 
							   else 'MarkDuplicatesWithMateCigar'
	String dups_extra = if UMI then 'UMI_TAG_NAME=XD'
					           else '' 
	call dnase.dups { input:
		merged_bam = merge.merged_bam,
		cmd = dups_cmd,
		extra = dups_extra
	}
}