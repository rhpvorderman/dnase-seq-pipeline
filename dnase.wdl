version 1.0


import "wdl/workflows/dnase_replicate.wdl" as process


workflow dnase {
    input {
        Array[Replicate] replicates
        References references
        MachineSizes? machine_sizes
    }

    scatter (replicate in replicates) {
        call process.dnase_replicate {
            input:
                replicate=replicate,
                references=references,
                machine_sizes=machine_sizes,
        }
    }
}
