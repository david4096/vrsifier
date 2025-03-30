# VRSifier Docker Image

This Docker image provides a containerized environment for running the `vrs-annotate` tool from the GA4GH VRS project. It allows users to annotate VCF files using the VRS annotation system.

## Usage

To run the container, use the following command:

```sh
docker run --platform linux/amd64 -v $(pwd)/data:/app/data david4096/vrsifier:latest /app/data/vrs-out1.vcf /app/data/ALL.chrX.BI_Beagle.20100804.sites.vcf.gz
```

### Explanation of Arguments:
- `--platform linux/amd64` ensures compatibility when running on different architectures.
- `-v $(pwd)/data:/app/data` mounts the local `data` directory into the container at `/app/data`.
- `david4096/vrsifier:latest` is the name of the Docker image.
- `/app/data/vrs-out1.vcf` specifies the output VCF file where the results will be saved.
- `/app/data/ALL.chrX.BI_Beagle.20100804.sites.vcf.gz` is the input VCF file to be annotated.

## Required Files
Ensure that your `data` directory contains the input VCF file (`ALL.chrX.BI_Beagle.20100804.sites.vcf.gz`) before running the command.

## Underlying Tool
This Docker image runs the [`vrs-annotate`](https://github.com/ga4gh/vrs-python/tree/main) tool from the GA4GH VRS project.

For more information, visit the [GA4GH VRS repository](https://github.com/ga4gh/vrs-python).

