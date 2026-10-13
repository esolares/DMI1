# DMI1
*D. melanogaster* ISO1 ONT Assembly Pipeline

## Data

- Raw ONT and Illumina reads: NCBI BioProject [PRJNA433573](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA433573)
- Reads and assemblies: Zenodo [doi:10.5281/zenodo.23349694](https://doi.org/10.5281/zenodo.23349694)
- Assemblies from the publication: [github.com/danrdanny/Nanopore_ISO1](https://github.com/danrdanny/Nanopore_ISO1)

Files on Zenodo were restored from backups. md5sum hashes below are for the files restored from backups (also in [`MD5SUMS_restored_from_backups.txt`](MD5SUMS_restored_from_backups.txt); verify with `md5sum -c MD5SUMS_restored_from_backups.txt`).

| Description | File | md5sum (restored from backup) |
|---|---|---|
| ONT reads, Albacore 2.0.2, pass only | `diso1_a2_pass.fastq.gz` | `90effd02c2933d7054381167d134b2be` |
| DBG2OLC draft assembly | `iso1_onp_a2_1kb_30x_LD0_K25_KCOV2_ADAPT0.01_MINOVL35_RMCHIM1_asm.fasta` | `9450df34dd604d772f21062d3fb02624` |
| Canu 1.5 draft assembly | `iso1onpa2.contigs.corrected.fasta` | `cc7ce08587945d28c405793f0a6e53a7` |
| QuickMerge final polished assembly (nanopolish + Pilon x2) | `iso1_onta2_quickmerge_contigs.fasta.gz` | `2ccf755fddaca9065ffe67422a817cd9` |
| Bionano scaffolded assembly | `iso1_onp_keep_bn_keep_ngs.fasta.gz` | `962ed0d38dd8925ff06c57b2c32fe664` |

The Canu 1.5 corrected reads are no longer available.

## Citation

Solares EA, Chakraborty M, Miller DE, Kalsow S, Hall K, Perera AG, Emerson JJ, Hawley RS. Rapid Low-Cost Assembly of the *Drosophila melanogaster* Reference Genome Using Low-Coverage, Long-Read Sequencing. *G3* 8(10):3143–3154 (2018). [doi:10.1534/g3.118.200162](https://doi.org/10.1534/g3.118.200162)
