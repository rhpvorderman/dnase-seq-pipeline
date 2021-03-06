version 1.0


import "../../../wdl/subworkflows/trim_fastq_to_length.wdl" as concatenated_fastq


workflow trim {
    input {
        File concatenated_fastq
        Int trim_length = 101
        String machine_size = "medium"
    }

    Machines compute = read_json("wdl/runtimes.json")

    call concatenated_fastq.trim_fastq_to_length {
        input:
            fastq=concatenated_fastq,
            trim_length=trim_length,
            resources=compute.runtimes[machine_size],
    }

    output {
        File trimmed_fastq = trim_fastq_to_length.trimmed
    }
}
