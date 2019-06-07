#!/bin/bash

# Borrowed and modified from Jemma Nelson

function cmp_text() {
  name=$1
  echo "Comparing $name..."
  diff "expected/$name" "output/$name"
}

function cmp_picard() {
  expected=$(grep -v '^#' $1)
  output=$(grep -v '^#' $2)

  echo "Comparing $expected and $output"
  diff <(echo $expected) <(echo $output) || (echo "picard files don't match"; return 1)
}

function cmp_starch() {
  name=$1
  if ! command -v unstarch ; then
    echo "Cannot verify $name, unstarch is not available"
    return 0
  fi
  echo "Comparing $name..."
  cmp <(unstarch "expected/$name") <(unstarch "output/$name") \
    || (echo "$name does not match" ; false)
}

function cmp_bam() {
  expected=$1
  output=$2
  if ! command -v samtools ; then
    echo "Cannot verify $expected, samtools is not available"
    return 1
  fi
  echo "Comparing $expected with $output"
  cmp <(samtools view $expected) <(samtools view $output) \
    || (echo "bams don't match" ; return 1)

}
