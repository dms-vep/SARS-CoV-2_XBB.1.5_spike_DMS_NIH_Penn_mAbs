"""Custom rules used in the ``snakemake`` pipeline.

This file is included by the pipeline ``Snakefile``.

"""

rule spatial_distances:
    """Get spatial distances from PDB."""
    input: 
        pdb="data/PDBs/aligned_spike_TM.pdb",
    output:
        csv="results/spatial_distances/spatial_distances.csv",
    params:
        target_chains=["A", "B", "C"],
    log:
        log="results/logs/spatial_distances.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml")
    script:
        "scripts/spatial_distances.py"

rule escape_logos:
    """Make logo plots for each antibody"""
    input:
        per_antibody_escape = "results/summaries/Antibody_escape.csv",
    output:
        B09 = "results/escape_logos/018-1_spike_DMS_logo_plot.svg",
        B12 = "results/escape_logos/053-3_spike_DMS_logo_plot.svg",
        C09 = "results/escape_logos/053-6_spike_DMS_logo_plot.svg",
        C12 = "results/escape_logos/043-1_spike_DMS_logo_plot.svg",
        D09 = "results/escape_logos/052-3_spike_DMS_logo_plot.svg"
    log:
        notebook = "results/logs/escape_logoplots_for_key_sites.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml"),
    notebook:
        "notebooks/escape_logoplots_for_key_sites.py.ipynb"


other_target_files.append([
    rules.escape_logos.output.B09,
    rules.escape_logos.output.B12,
    rules.escape_logos.output.C09,
    rules.escape_logos.output.C12,
    rules.escape_logos.output.D09,
     ] )
